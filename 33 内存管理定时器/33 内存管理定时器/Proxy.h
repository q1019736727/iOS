//
//  Proxy.h
//  33 内存管理定时器
//
//  Created by Chiu Young on 2020/12/15.
//

#import <Foundation/Foundation.h>


@interface Proxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;
@property (weak, nonatomic) id target;

@end


