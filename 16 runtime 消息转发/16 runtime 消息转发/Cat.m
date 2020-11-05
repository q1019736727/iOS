//
//  Cat.m
//  16 runtime 消息转发
//
//  Created by Chiu Young on 2020/10/28.
//

#import "Cat.h"

@implementation Cat
- (int)changeAge:(int)age;
{
    return  age*2;
}
+ (void)metaClassTest;
{
    NSLog(@"%s",__func__);
}
@end
