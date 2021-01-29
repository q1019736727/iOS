//
//  Person+test.m
//  interview
//
//  Created by Chiu Young on 2020/10/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "Person+test.h"
#import <objc/runtime.h>
@implementation Person (test)

static void * PersonNameKey = &PersonNameKey;

NSInteger weight_;

- (void)setWeight:(NSInteger)weight{
    weight_ = weight;
}
- (NSInteger)weight{
    return  weight_;
}

- (void)setName:(NSString *)name{
    NSLog(@"key == %p",@selector(name));
    objc_setAssociatedObject(self, &PersonNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)name{
    return  objc_getAssociatedObject(self, &PersonNameKey);
}
@end
