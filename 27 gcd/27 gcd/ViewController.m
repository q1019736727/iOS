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
    dispatch_async(queue, ^{
        NSLog(@"任务2");
    });
    
    NSLog(@"任务3");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
