//
//  NSMutableArray+Extension.m
//  22 runtime应用
//
//  Created by Chiu Young on 2020/11/6.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>
@implementation NSMutableArray (Extension)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //得到所属类
        Class cls = NSClassFromString(@"__NSArrayM");
        Method mt1 = class_getInstanceMethod(cls, @selector(insertObject:atIndex:));
        Method mt2 = class_getInstanceMethod(cls, @selector(cy_insertObject:atIndex:));
        method_exchangeImplementations(mt1, mt2);
    });
}
- (void)cy_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if (anObject == nil) { //如果是空数据就返回，不让添加进来
        return;
    }
    [self cy_insertObject:anObject atIndex:index];
}
@end
