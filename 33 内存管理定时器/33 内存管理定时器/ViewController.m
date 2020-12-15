//
//  ViewController.m
//  33 内存管理定时器
//
//  Created by Chiu Young on 2020/12/15.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)NSTimer * timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:YES];
}

- (void)test{
    NSLog(@"%s",__func__);
}

- (void)dealloc{
    [self.timer invalidate];
    NSLog(@"ViewController dealloc");
}

@end
