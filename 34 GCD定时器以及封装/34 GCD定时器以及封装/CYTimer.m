//
//  CYTimer.m
//  34 GCD定时器以及封装
//
//  Created by Chiu Young on 2020/12/16.
//

#import "CYTimer.h"

@implementation CYTimer

static NSMutableDictionary * timers_;
dispatch_semaphore_t timerSemaphore_;
+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        timerSemaphore_ = dispatch_semaphore_create(1);//加入线程同步控制，谨防多个线程修改timers_里面的数据
    });
}


+ (NSString *)doTask:(void(^)(void))task
               start:(NSTimeInterval)start
            interval:(NSTimeInterval)interval
             repeats:(BOOL)repeats
               async:(BOOL)async;
{
    if (!task || start < 0 || (interval <= 0 && repeats)) return nil;
    
    // 队列
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0):dispatch_get_main_queue();
    
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置时间
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, start*NSEC_PER_SEC),
                              interval*NSEC_PER_SEC,
                              0);
    
    dispatch_semaphore_wait(timerSemaphore_, DISPATCH_TIME_FOREVER);
    // 定时器的唯一标识
    NSString * name = [NSString stringWithFormat:@"%zd", timers_.count];
    // 存放到字典中
    timers_[name] = timer; //一定要注意这里,要将timer引入NSMutableDictionary里面，不然timer会被释放无法执行任务
    dispatch_semaphore_signal(timerSemaphore_);
    
    //设置回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTask:name];
        }
    });
    
    //启动定时器
    dispatch_resume(timer);

    return name;
}
+ (NSString *)withTarget:(id)target
                selector:(SEL)selector
                   start:(NSTimeInterval)start
                interval:(NSTimeInterval)interval
                 repeats:(BOOL)repeats
                   async:(BOOL)async;
{
    return [self doTask:^{
        if ([target respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks" //这几句消除警告
            [target performSelector:selector];
#pragma clang diagnostic pop
        }
    } start:start interval:interval repeats:repeats async:async];
}
+ (void)cancelTask:(NSString *)name{
    if (name.length == 0) return;
    
    dispatch_semaphore_wait(timerSemaphore_, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = timers_[name];
    if (timer) {
        dispatch_source_cancel(timers_[name]);
        [timers_ removeObjectForKey:name];
    }
    dispatch_semaphore_signal(timerSemaphore_);
}
@end
