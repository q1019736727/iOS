//
//  ViewController.m
//  33 内存管理定时器
//
//  Created by Chiu Young on 2020/12/15.
//


//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[CYProxy initWithTarget:self] selector:@selector(test) userInfo:nil repeats:YES];


#import "ViewController.h"
#import "CYProxy.h"
#import "Proxy.h"

@interface ViewController ()
@property (nonatomic, strong)NSTimer * timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    __weak typeof(self) weakSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"%@",weakSelf);
//    }];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[CYProxy initWithTarget:self] selector:@selector(test) userInfo:nil repeats:YES];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[Proxy proxyWithTarget:self] selector:@selector(test) userInfo:nil repeats:YES];

}

- (void)test{
    NSLog(@"%s",__func__);
}

- (void)dealloc{
    [self.timer invalidate];
    NSLog(@"ViewController dealloc");
}

@end
