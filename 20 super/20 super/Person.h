//
//  Person.h
//  20 super
//
//  Created by Chiu Young on 2020/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (copy, nonatomic) NSString *name;

- (void)print;
@end

NS_ASSUME_NONNULL_END
