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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSConditionDemo * demo = [[NSConditionDemo alloc]init];
//    [demo moneyTest];
//    [demo ticketTest];
    [demo otherTest];
    
//    NSLockDemo * demo = [[NSLockDemo alloc]init];
//    [demo moneyTest];
//    [demo ticketTest];

}


@end
