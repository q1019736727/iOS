//
//  Person.m
//  16 runtime 消息转发
//
//  Created by Chiu Young on 2020/10/28.
//

#import "Person.h"
#import "Cat.h"

@implementation Person

//     [Person metaClassTest];

//类方法 + 号
+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(metaClassTest)) {
        //方法签名可以这样写
        return [Cat methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}
//类方法 + 号
+ (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"哈哈哈");
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(testAge:)) {
        //这里传递多了一个int参数，方法签名后面要多加一个i
        return [NSMethodSignature signatureWithObjCTypes:"v@:i"];
    }else if (aSelector == @selector(changeAge:)){
        //这里传递多了一个int参数，方法签名后面要多加一个i,有返回值第一个是i
        return [NSMethodSignature signatureWithObjCTypes:"i@:i"];
    }
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    // 参数顺序：receiver、selector、other arguments
    if (anInvocation.selector == @selector(testAge:)) {
        //获取参数
        int age;
        [anInvocation getArgument:&age atIndex:2];
        NSLog(@"age %d",age);
    }
    
    if (anInvocation.selector == @selector(changeAge:)) {
        //获取返回值
        //自己没有changeAge方法，转发给Cat实现
        [anInvocation invokeWithTarget:[[Cat alloc]init]];
        int rt;
        [anInvocation getReturnValue:&rt];
        NSLog(@"changeAge %d",rt);
    }
}
@end
