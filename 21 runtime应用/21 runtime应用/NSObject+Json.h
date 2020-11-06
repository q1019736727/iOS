//
//  NSObject+Json.h
//  21 runtime应用
//
//  Created by Chiu Young on 2020/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Json)
+ (instancetype)mj_objectWithJson:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
