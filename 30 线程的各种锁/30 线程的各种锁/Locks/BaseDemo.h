//
//  BaseDemo.h
//  30 线程的各种锁
//
//  Created by Chiu Young on 2020/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseDemo : NSObject


- (void)moneyTest;
- (void)ticketTest;
- (void)otherTest;

#pragma mark - 暴露给子类去使用
- (void)__saveMoney;
- (void)__drawMoney;
- (void)__saleTicket;

@end

NS_ASSUME_NONNULL_END
