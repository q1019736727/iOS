//
//  OSSpinLockDemo2.m
//  30 线程的各种锁
//
//  Created by Chiu Young on 2020/12/9.
//

#import "OSSpinLockDemo2.h"
#import <libkern/OSAtomic.h>

@implementation OSSpinLockDemo2
static OSSpinLock moneyLock_;
+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        moneyLock_ = 0;
    });
}

- (void)__drawMoney
{
    OSSpinLockLock(&moneyLock_);
    
    [super __drawMoney];
    
    OSSpinLockUnlock(&moneyLock_);
}

- (void)__saveMoney
{
    OSSpinLockLock(&moneyLock_);
    
    [super __saveMoney];
    
    OSSpinLockUnlock(&moneyLock_);
}

- (void)__saleTicket
{
    
    static OSSpinLock ticketLock = OS_SPINLOCK_INIT;
    
    OSSpinLockLock(&ticketLock);
    
    [super __saleTicket];
    
    OSSpinLockUnlock(&ticketLock);
}


@end
