//
//  ViewController.m
//  25 Runloop(线程保活)
//
//  Created by Chiu Young on 2020/11/23.
//

#import "ViewController.h"
#import "CYThread.h"

@interface ViewController ()
@property (nonatomic, strong) CYThread * thread;
@property (nonatomic, assign, getter=isStop) BOOL Stop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Stop = NO;
    
    __weak typeof(self) weakself = self;
    _thread = [[CYThread alloc]initWithBlock:^{
        NSLog(@"%s --- begin",__func__);
        [[NSRunLoop currentRunLoop]addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop]run];
        //注意一下这里的判断，如果不判断 weakself 是否存在，还是会直接接着进入runMode:beforeDate
        //因为调用dealloc之前,系统会将设置的weakself置为空，到时判断 !weakself.isStop 会成为YES，就会进入runMode:beforeDate方法，造成无法销毁线程
        while (weakself && !weakself.isStop) {
            [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        // NSRunLoop的run方法是无法停止的，它专门用于开启一个永不销毁的线程（NSRunLoop）
        //        [[NSRunLoop currentRunLoop] run];
        /*
         it runs the receiver in the NSDefaultRunLoopMode by repeatedly invoking runMode:beforeDate:.
         In other words, this method effectively begins an infinite loop that processes data from the run loop’s input sources and timers
         */

        NSLog(@"%s --- end",__func__);
    }];
    [_thread start];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.thread) return;
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}
- (void)test{
    NSLog(@"test %@",[NSThread currentThread]);
}
- (void)stop{
    if (!self.thread) return;
    //获取_thread所处在线程并销毁
    
    //如果这里我们waitUntilDone设置为NO，会造成 BAD_ACCESS  Crash错误,因为在执行dealloc执行到这句时，设置为NO就是不用等待子线程执行完
    //就接着向下执行，但是因为是dealloc，执行完controller里面的对象和方法都被销毁了，stopRunloop这个方法也不存在了，所以会crash，
    //在这里我们要把waitUntilDone设置YES
    [self performSelector:@selector(stopRunloop) onThread:self.thread withObject:nil waitUntilDone:YES];
    NSLog(@"--- stop %@",[NSThread currentThread]);
}
- (void)stopRunloop{
    
    self.Stop = YES;
    //利于C语言函数销毁
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"--- stopRunloop %@",[NSThread currentThread]);
}
- (void)dealloc{
    NSLog(@"ViewController --- dealloc");
    [self stop];
}
@end
