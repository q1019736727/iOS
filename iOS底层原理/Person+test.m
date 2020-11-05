//
//  Person+test.m
//  iOS底层原理
//
//  Created by Chiu Young on 2020/10/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "Person+test.h"
#import <objc/runtime.h>


@implementation Person (test)



- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name{
    //下面的 _cmd 是 @selector(name) 方法的,_cmd是个隐式参数，代表当前的函数地址
    // _cmd == @selector(name)
    return objc_getAssociatedObject(self, _cmd);
}




//static const char nameKey;
//
//- (void)setName:(NSString *)name{
//    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)name{
//    return objc_getAssociatedObject(self, &nameKey);
//}


////内存地址作为key
//#define CYKey [NSString stringWithFormat:@"%p",self]
//
//NSMutableDictionary * weights_;
//NSMutableDictionary * names_;
//
////load只会加载一次
//+ (void)load{
//    weights_ = [NSMutableDictionary dictionary];
//}
//
//- (void)setWeight:(NSInteger)weight{
//    weights_[CYKey] = @(weight);
//}
//- (NSInteger)weight{
//    return [weights_[CYKey] integerValue];
//}

//NSInteger weight_;
//- (void)setWeight:(NSInteger)weight{
//    weight_ = weight;
//}
//- (NSInteger)weight{
//    return  weight_;
//}

@end
