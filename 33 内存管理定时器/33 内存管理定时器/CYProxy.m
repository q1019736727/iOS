//
//  CYProxy.m
//  33 内存管理定时器
//
//  Created by Chiu Young on 2020/12/15.
//

#import "CYProxy.h"

@interface CYProxy()

@end

@implementation CYProxy

+ (instancetype)initWithTarget:(id)target;
{
    CYProxy * proxy = [[CYProxy alloc]init];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    return self.target;
}

@end
