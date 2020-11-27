//
//  ViewController.m
//  27 gcd
//
//  Created by Chiu Young on 2020/11/25.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)test1{
    // 死锁1
    
    NSLog(@"任务1");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"任务2");
    });
    
    NSLog(@"任务3");
}

- (void)test2{
    
    NSLog(@"任务1");
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{ //block0
        
        NSLog(@"任务2");
        
        dispatch_sync(queue, ^{//block1
            NSLog(@"任务3");
        });
        
        NSLog(@"任务4");
    });
    
}
- (void)test3{
    NSLog(@"任务1");
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("myQueue2", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{ //block0
        
        NSLog(@"任务2");
        
        dispatch_sync(queue2, ^{//block1
            NSLog(@"任务3");
        });
        
        NSLog(@"任务4");
    });
}
- (void)test4{
    NSLog(@"任务1");
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        
        NSLog(@"任务2");

        dispatch_sync(queue, ^{
            NSLog(@"任务3");
        });
        
        NSLog(@"任务4");

    });
    NSLog(@"任务5");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self test4];
}


@end
