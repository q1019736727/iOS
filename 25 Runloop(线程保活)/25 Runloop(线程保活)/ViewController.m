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
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:YES];
}
- (void)test{
    NSLog(@"test %@",[NSThread currentThread]);
}
- (void)stop{
    //获取_thread所处在线程并销毁
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
