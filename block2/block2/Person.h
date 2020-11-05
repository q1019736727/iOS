//
//  Person.h
//  block2
//
//  Created by Chiu Young on 2020/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MJBlock) (void);
@interface Person : NSObject
@property (copy, nonatomic) MJBlock block;
@property (assign, nonatomic) int age;
@end
NS_ASSUME_NONNULL_END
