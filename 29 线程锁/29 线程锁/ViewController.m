//
//  ViewController.m
//  29 线程锁
//
//  Created by Chiu Young on 2020/12/1.
//

#import "ViewController.h"
#import <libkern/OSAtomic.h>

@interface ViewController ()
@property (assign, nonatomic) int money;
@property (assign, nonatomic) int ticketsCount;
//卖票和存取钱因为是可以同时发生的事情，所以可以不共用一把锁
@property (assign, nonatomic) OSSpinLock lock;
@property (assign, nonatomic) OSSpinLock lock1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化锁
    self.lock = OS_SPINLOCK_INIT;
    self.lock1 = OS_SPINLOCK_INIT;

    [self ticketTest];
    [self moneyTest];
    
}
#pragma mark -- 存取钱

- (void)moneyTest
{
    self.money = 100;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self drawMoney];
        }
    });

}
/**
 存钱
 */
- (void)saveMoney
{
    // 加锁
    OSSpinLockLock(&_lock1);
    
    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 50;
    self.money = oldMoney;
    
    NSLog(@"存50，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
    
    // 解锁
    OSSpinLockUnlock(&_lock1);
}

/**
 取钱
 */
- (void)drawMoney
{
    // 加锁
    OSSpinLockLock(&_lock1);
    
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20;
    self.money = oldMoney;
    
    NSLog(@"取20，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
    // 解锁
    OSSpinLockUnlock(&_lock1);
}
#pragma mark --卖票演示
- (void)ticketTest
{
    self.ticketsCount = 15;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
}

/**
 卖1张票
 */
- (void)saleTicket
{
    
    // 加锁
    OSSpinLockLock(&_lock);

    int oldTicketsCount = self.ticketsCount;
    sleep(.2);
    oldTicketsCount--;
    self.ticketsCount = oldTicketsCount;
    NSLog(@"还剩%d张票 - %@", oldTicketsCount, [NSThread currentThread]);
    
    // 解锁
    OSSpinLockUnlock(&_lock);
}

@end
