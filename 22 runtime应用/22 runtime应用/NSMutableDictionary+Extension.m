//
//  NSMutableDictionary+Extension.m
//  22 runtime应用
//
//  Created by Chiu Young on 2020/11/6.
//

#import "NSMutableDictionary+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Extension)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"__NSDictionaryM");
        Method method1 = class_getInstanceMethod(cls, @selector(setObject:forKey:));
        Method method2 = class_getInstanceMethod(cls, @selector(cy_setObject:forKey:));
        method_exchangeImplementations(method1, method2);
        
        Class cls2 = NSClassFromString(@"__NSDictionaryI");
        Method method3 = class_getInstanceMethod(cls2, @selector(objectForKeyedSubscript:));
        Method method4 = class_getInstanceMethod(cls2, @selector(cy_objectForKeyedSubscript:));
        method_exchangeImplementations(method3, method4);
    });
}
//设key值为空处理
- (void)cy_setObject:(id)obj forKey:(id<NSCopying>)key
{
    if (!key) return;
    
    [self cy_setObject:obj forKey:key];
}
//取不存在的字段名 处理
- (id)cy_objectForKeyedSubscript:(id)key
{
    if (!key) return nil;
    
    return [self cy_objectForKeyedSubscript:key];
}
@end
