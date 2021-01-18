//
//  RunloopWatchController.m
//  interview
//
//  Created by Chiu Young on 2021/1/18.
//  Copyright © 2021 Mac. All rights reserved.
//

#import "RunloopWatchController.h"


//线程卡顿检测

static CGFloat lagTimeInterval = 0.5;

@interface RunloopWatchController ()

//监听子线程
@property (nonatomic, strong) NSThread *monitorThread;
//是否进入休眠
@property (nonatomic, assign) BOOL isBeforeWaiting;
//即将处理source0的时间
@property (nonatomic, strong) NSDate *beforeSource0Time;

@end

@implementation RunloopWatchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建监听子线程，打开其RunLoop
    _monitorThread = [[NSThread alloc] initWithTarget:self selector:@selector(openRunLoop) object:nil];
    [_monitorThread start];
    //添加定时器
    [self performSelector:@selector(startMonitorTimer) onThread:_monitorThread withObject:nil waitUntilDone:NO];
    
    //主线程RunLoop添加观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopBeforeSources:
            {
                _beforeSource0Time = [NSDate date];
                _isBeforeWaiting = NO;
            }
                break;
            case kCFRunLoopBeforeWaiting:
            {
                _isBeforeWaiting = YES;
            }
                break;
                
            default:
                break;
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);
}

//打开子线程的RunLoop对象，保证子线程活着
- (void)openRunLoop {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSPort port] forMode:NSRunLoopCommonModes];
        [runLoop run];
    }
}

//添加定时器到子线程的RunLoop中
- (void)startMonitorTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5*lagTimeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        //如果_isBeforeWaiting状态为YES，表示主线程RunLoop即将进入休眠
        if(!_isBeforeWaiting) {
            //获取当前时间与记录时间的差值
            NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:_beforeSource0Time];
            //如果大于卡顿时间，则打印出来
            if(timeInterval >= lagTimeInterval) {
                NSLog(@"##############卡了");
                [self logStack];
            } else {
                NSLog(@"##############没卡");
            }
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)logStack {
    NSLog(@"%@", [NSThread callStackSymbols]);
}


@end
