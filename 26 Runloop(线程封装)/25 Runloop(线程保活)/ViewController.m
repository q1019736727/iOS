//
//  ViewController.m
//  25 Runloop(线程保活)
//
//  Created by Chiu Young on 2020/11/23.
//

#import "ViewController.h"
#import "CYCustomThread.h"

@interface ViewController ()
@property (nonatomic, strong) CYCustomThread * thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thread = [[CYCustomThread alloc]init];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.thread executeTask:^{
        NSLog(@"执行任务 %@",[NSThread currentThread]);
    }];
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
