//
//  Proxy.m
//  33 内存管理定时器
//
//  Created by Chiu Young on 2020/12/15.
//

#import "Proxy.h"

@implementation Proxy

+ (instancetype)proxyWithTarget:(id)target
{
    // NSProxy对象不需要调用init，因为它本来就没有init方法
    Proxy * proxy = [Proxy alloc];
    proxy.target = target;
    return proxy;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    //方法签名
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}

@end
