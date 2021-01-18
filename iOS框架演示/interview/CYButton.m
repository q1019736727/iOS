//
//  CYButton.m
//  interview
//
//  Created by Chiu Young on 2021/1/12.
//  Copyright © 2021 Mac. All rights reserved.
//

#import "CYButton.h"

@implementation CYButton

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
//    NSLog(@"SEL %@",NSStringFromSelector(action));
    [super sendAction:action to:target forEvent:event];
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@"CYButton Bool %d",[super pointInside:point withEvent:event]);
    return  [super pointInside:point withEvent:event];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@"CYButton View  %@",[super hitTest:point withEvent:event]);
    return  [super hitTest:point withEvent:event];
}
@end
