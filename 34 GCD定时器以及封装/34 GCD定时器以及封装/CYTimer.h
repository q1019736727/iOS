//
//  CYTimer.h
//  34 GCD定时器以及封装
//
//  Created by Chiu Young on 2020/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYTimer : NSObject

+ (NSString *)doTask:(void(^)(void))task
               start:(NSTimeInterval)start
            interval:(NSTimeInterval)interval
             repeats:(BOOL)repeats
               async:(BOOL)async;

+ (NSString *)withTarget:(id)target
                selector:(SEL)selector
                   start:(NSTimeInterval)start
                interval:(NSTimeInterval)interval
                 repeats:(BOOL)repeats
                   async:(BOOL)async;


+ (void)cancelTask:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
