//
//  Person.h
//  21 runtime应用
//
//  Created by Chiu Young on 2020/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (assign, nonatomic) int age;
@property (assign, nonatomic) int weight;
@property (copy, nonatomic) NSString * name;



- (void)run;

- (void)test;

@end

NS_ASSUME_NONNULL_END
