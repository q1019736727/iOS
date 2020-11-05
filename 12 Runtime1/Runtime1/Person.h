//
//  Person.h
//  Runtime1
//
//  Created by Chiu Young on 2020/10/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
//@property (assign, nonatomic) BOOL tall;
//@property (assign, nonatomic) BOOL rich;
//@property (assign, nonatomic) BOOL handsome;

- (void)setTall:(BOOL)tall;
- (void)setRich:(BOOL)rich;
- (void)setHandsome:(BOOL)handsome;

- (BOOL)isTall;
- (BOOL)isRich;
- (BOOL)isHandsome;
@end

NS_ASSUME_NONNULL_END
