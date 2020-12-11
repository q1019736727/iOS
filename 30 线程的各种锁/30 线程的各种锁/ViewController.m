//
//  ViewController.m
//  30 线程的各种锁
//
//  Created by Chiu Young on 2020/12/2.
//

#import "ViewController.h"
#import "BaseDemo.h"
#import "OSSpinLockDemo.h"
#import "OSSpinLockDemo2.h"
#import "OSUnfairLockDemo.h"
#import "MutexDemo.h"
#import "MutexDemo2.h"
#import "MutexDemo3.h"
#import "NSLockDemo.h"
#import "NSConditionDemo.h"
#import "NSConditionLockDemo.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSConditionLockDemo * demo = [[NSConditionLockDemo alloc]init];
//    [demo moneyTest];
//    [demo ticketTest];
    [demo otherTest];
    
//    NSLockDemo * demo = [[NSLockDemo alloc]init];
//    [demo moneyTest];
//    [demo ticketTest];
    
}



#define SemaphoreBegin \
static dispatch_semaphore_t semaphore;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
    semaphore = dispatch_semaphore_create(1);\
});\
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

#define SemaphoreEnd \
dispatch_semaphore_signal(semaphore);

- (void)test{
    SemaphoreBegin
    
    //.....do something
    NSLog(@"111");
    
    SemaphoreEnd
}
- (void)test1{
    SemaphoreBegin

    //.....do something
    NSLog(@"222");
    
    SemaphoreEnd
}
- (void)test2{
    SemaphoreBegin
    
    //.....do something
    NSLog(@"333");
    
    SemaphoreEnd
}
@end
