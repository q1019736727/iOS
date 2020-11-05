//
//  Person+test.m
//  interview
//
//  Created by Chiu Young on 2020/10/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "Person+test.h"

@implementation Person (test)

NSInteger weight_;

- (void)setWeight:(NSInteger)weight{
    weight_ = weight;
}
- (NSInteger)weight{
    return  weight_;
}

@end
