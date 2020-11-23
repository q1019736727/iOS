//
//  ViewController.m
//  23 Runloop(NSTimer)
//
//  Created by Chiu Young on 2020/11/23.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scr.backgroundColor = [UIColor grayColor];
    _scr.contentSize = CGSizeMake(0, 1000);
    
    //这里我们如果直接这样拖动scr，定时器是不会走的
//    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"123");
//    }];
    
    //解决方法
    NSTimer * timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"123");
    }];
    
//    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop]addTimer:timer forMode:UITrackingRunLoopMode];
    
    //这一句等价于上面两句
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];

    // NSDefaultRunLoopMode、UITrackingRunLoopMode才是真正存在的模式
    // NSRunLoopCommonModes并不是一个真的模式，它只是一个标记
    // timer能在_commonModes数组中存放的模式下工作

    
}


@end
