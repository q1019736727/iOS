//
//  Person.m
//  31 atomic
//
//  Created by Chiu Young on 2020/12/14.
//

#import "Person.h"

@implementation Person

- (void)setName:(NSString *)name
{
    // 加锁
    self.name = name;
    // 解锁
}

- (NSString *)name
{
    // 加锁
    return self.name;
    // 解锁
}

@end
