//
//  CYUIView.m
//  interview
//
//  Created by Chiu Young on 2021/1/12.
//  Copyright © 2021 Mac. All rights reserved.
//

#import "CYUIView.h"

@implementation CYUIView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"CYUIView Bool %d",[super pointInside:point withEvent:event]);
    return  [super pointInside:point withEvent:event];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"CYUIView View  %@",[super hitTest:point withEvent:event]);
    return  [super hitTest:point withEvent:event];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击view");    
}
@end
