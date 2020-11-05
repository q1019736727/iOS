//
//  Person.m
//  block2
//
//  Created by Chiu Young on 2020/10/20.
//

#import "Person.h"

@implementation Person
- (void)dealloc
{
//    [super dealloc];
    NSLog(@"%s", __func__);
}
- (void)test
{
//    __weak typeof(self) weakSelf = self;
//    self.block = ^{
//        NSLog(@"age is %d", weakSelf.age);
//    };
    
    
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        __strong typeof(weakSelf) myself = weakSelf;
        
        NSLog(@"age is %d", myself->_age);
    };
    
//    __unsafe_unretained typeof(self) weakSelf = self;
//    self.block = ^{
//        NSLog(@"age is %d", weakSelf.age);
//    };
}
@end
