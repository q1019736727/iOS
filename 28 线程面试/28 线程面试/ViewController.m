//
//  ViewController.m
//  28 线程面试
//
//  Created by Chiu Young on 2020/11/30.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //队列组
    
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        for (int a = 0; a < 3; a++) {
            NSLog(@"任务1 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (int a = 0; a < 3; a++) {
            NSLog(@"任务2 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int a = 0; a < 3; a++) {
                NSLog(@"任务3 %@",[NSThread currentThread]);
            }
        });
    });

    
    
    
}
- (void)test{
    NSLog(@"2");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1");
        
        [self performSelector:@selector(test) withObject:nil afterDelay:0];
        
        //有没有这句都可以，因为performSelector:withObject:afterDelay 内部里面就添加到有定时器，就不需要NSPort了
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
//        [self performSelector:@selector(test) withObject:nil];
        
        NSLog(@"3");
    });
}

@end
