//
//  Person.h
//  16 runtime 消息转发
//
//  Created by Chiu Young on 2020/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

+ (void)metaClassTest;

- (void)testAge:(int)age;

- (int)changeAge:(int)age;

@end

NS_ASSUME_NONNULL_END
