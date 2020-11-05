//
//  Person.m
//  16 dynamic
//
//  Created by Chiu Young on 2020/10/29.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

// 提醒编译器不要自动生成setter和getter的实现、不要自动生成成员变量
@dynamic age;

void setAge(id self, SEL _cmd, int age)
{
    NSLog(@"age is %d", age);
}
int age(id self, SEL _cmd)
{
    return 120;
}
//自己实现
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(setAge:)) {
        class_addMethod(self, sel, (IMP)setAge, "v@:i");
        return YES;
    } else if (sel == @selector(age)) {
        class_addMethod(self, sel, (IMP)age, "i@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}


////默认生成 _age可以随便命名,但是下面的_age要与这里保持一致
//@synthesize age = _age;
////默认生成
//- (void)setAge:(int)age{
//    _age = age;
//}
////默认生成
//- (int)age{
//    return  _age;
//}




@end
