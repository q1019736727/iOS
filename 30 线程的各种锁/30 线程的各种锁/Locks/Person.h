//
//  Person.h
//  30 线程的各种锁
//
//  Created by Chiu Young on 2020/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (strong, atomic) NSMutableArray * data;

@end

NS_ASSUME_NONNULL_END
