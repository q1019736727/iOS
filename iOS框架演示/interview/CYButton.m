//
//  CYButton.m
//  interview
//
//  Created by Chiu Young on 2021/1/12.
//  Copyright © 2021 Mac. All rights reserved.
//

#import "CYButton.h"

@implementation CYButton

- (instancetype)init{
    self = [super init];
    if (self) {
//        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
//    NSLog(@"SEL %@",NSStringFromSelector(action));
    [super sendAction:action to:target forEvent:event];
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"CYButton Bool %d",[super pointInside:point withEvent:event]);
    
    // 当前btn的大小
    CGRect btnBounds=self.bounds;
    // 扩大按钮的点击范围，改为负值
    btnBounds=CGRectInset(btnBounds, -10, -10);
    // 若点击的点在新的bounds里，就返回YES
    return CGRectContainsPoint(btnBounds, point);
    
//    return  [super pointInside:point withEvent:event];
    
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"CYButton View  %@",[super hitTest:point withEvent:event]);
    return  [super hitTest:point withEvent:event];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击button");
}

@end
