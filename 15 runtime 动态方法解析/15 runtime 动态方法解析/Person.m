//
//  Person.m
//  15 runtime 动态方法解析
//
//  Created by Chiu Young on 2020/10/28.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Cat.h"







// typedef struct objc_method *Method;
// struct objc_method == struct method_t
//  struct method_t *otherMethod = (struct method_t *)class_getInstanceMethod(self, @selector(other));

struct method_t{
    SEL name;
    char * types;
    IMP imp;
};
@implementation Person

- (void)other{
    NSLog(@"%s",__func__);
}
////类对象方法动态解析添加
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//
//    if (sel == @selector(test)) {
//
////        Method otherMethod = class_getInstanceMethod(self, @selector(other));//和下面是等价关系(用下面构造一样的结构体主要是获取IMP和和types)
//
//        //获取other方法
//        struct method_t*method = (struct method_t*)class_getInstanceMethod(self, @selector(other));
//
//        NSLog(@"%s %s %p",method->name,method->types,method->imp);
//
//        //动态添加方法
//        class_addMethod(self, sel, method->imp, method->types);
//
//        // 返回YES代表有动态添加方法(按照runtime的规定最好返回YES)
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}


//类对象方法动态解析添加
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(test)) {
        
        //获取other方法
        Method method = class_getInstanceMethod(self, @selector(other));
        
        //动态添加方法
        class_addMethod(self, sel,
                        method_getImplementation(method),
                        method_getTypeEncoding(method));
        
        // 返回YES代表有动态添加方法(按照runtime的规定最好返回YES)
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
//类对象方法动态解析添加
+ (BOOL)resolveClassMethod:(SEL)sel{
    if (sel == @selector(classTest)) {
        //获取other方法
        Method method = class_getInstanceMethod(self, @selector(other));
        
        //动态添加方法
        class_addMethod(object_getClass(self), //根据前面所学，获取元类对象使用object_getClass()可以以获得
                        sel,
                        method_getImplementation(method),
                        method_getTypeEncoding(method));
        
        // 返回YES代表有动态添加方法(按照runtime的规定最好返回YES)
        return YES;

    }
    return [super resolveClassMethod:sel];
}


- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    if (aSelector == @selector(play)) {
        // objc_msgSend([[MJCat alloc] init], aSelector)
        return [[Cat alloc]init];//将play消息转发给Cat
    }
    return [super forwardingTargetForSelector:aSelector];
}

// 方法签名：返回值类型、参数类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(say)) {
        // "v16@0:8" 返回值类型、参数类型
        return  [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
    }
    return  [super methodSignatureForSelector:aSelector];
}
// NSInvocation封装了一个方法调用，包括：方法调用者、方法名、方法参数
//    anInvocation.target 方法调用者
//    anInvocation.selector 方法名
//    [anInvocation getArgument:NULL atIndex:0]
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    //    anInvocation.target = [[MJCat alloc] init];
    //    [anInvocation invoke];
    
    //等价于上面
    [anInvocation invokeWithTarget:[[Cat alloc]init]];
}
@end
