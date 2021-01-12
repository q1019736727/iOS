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
    return  [super pointInside:point withEvent:event];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"View  %@",[super hitTest:point withEvent:event]);
    return  [super hitTest:point withEvent:event];
}

@end
