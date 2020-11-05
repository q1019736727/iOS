//
//  Cat.h
//  16 runtime 消息转发
//
//  Created by Chiu Young on 2020/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cat : NSObject
- (int)changeAge:(int)age;
+ (void)metaClassTest;
@end

NS_ASSUME_NONNULL_END
