//
//  UIControl+Extension.m
//  22 runtime应用
//
//  Created by Chiu Young on 2020/11/6.
//

#import "UIControl+Extension.h"
#import <objc/runtime.h>
@implementation UIControl (Extension)
+ (void)load{
    //虽然load方法只会在编译的时候调用一次，但是为了防止手动调用,加个onceToken
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //这里的方法做了交换，那么IMP的地址就发生了交换
        Method mt1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method mt2 = class_getInstanceMethod(self, @selector(cy_sendAction:to:forEvent:));
        method_exchangeImplementations(mt1, mt2);
    });
}

- (void)cy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    //这里只做按钮的时间拦截，其他控件调
    if ([self isKindOfClass:[UIButton class]]) {
        NSLog(@"\n self = %@  \n target = %@  \n action = %@",self,target,NSStringFromSelector(action));
        return;
    }
    //这里不能使用下面注释的方法，因为方法交换后IMP的地址发生变化，如果还调用@selector(sendAction:to:forEvent),那么会调用到@selector(cy_sendAction:to:forEvent:)
    //造成死循环,所以要调用@selector(cy_sendAction:to:forEvent:)才是调用以前的方法
//    [self sendAction:action to:target forEvent:event];
    
    [self cy_sendAction:action to:target forEvent:event];//处理其他控件的事件
}
@end
