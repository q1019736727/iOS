//
//  ViewController.m
//  24 Runloop(线程保活)
//
//  Created by Chiu Young on 2020/11/23.
//

#import "ViewController.h"
#import "CYThread.h"

@interface ViewController ()
@property (nonatomic,strong) CYThread * tread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tread = [[CYThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    [self.tread start];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // waitUntilDone
    // YES就是子任务执行完再来执行下面的代码
    // NO直接执行NSLog 111 代码，不用等子线程执行完
    [self performSelector:@selector(test) onThread:self.tread withObject:nil waitUntilDone:YES];
//    NSLog(@"111");
}
// 子线程需要执行的任务
- (void)test{
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
}
// 这个方法的目的：线程保活
- (void)run{
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
    
    // 往RunLoop里面添加Source\Timer\Observer
    // 防止线路被销毁
    [[NSRunLoop currentRunLoop]addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    //因为有上面两行代码的保活，下面这个nslog将不会被执行
    NSLog(@"end --- run");
}

@end
