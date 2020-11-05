//
//  main.m
//  19 class
//
//  Created by Chiu Young on 2020/11/2.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"

//- (BOOL)isMemberOfClass:(Class)cls {
//    return [self class] == cls;
//}
//
//- (BOOL)isKindOfClass:(Class)cls {
//    for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
//        if (tcls == cls) return YES;
//    }
//    return NO;
//}
//
//
//+ (BOOL)isMemberOfClass:(Class)cls {
//    return object_getClass((id)self) == cls;
//}
//
//
//+ (BOOL)isKindOfClass:(Class)cls {
//    for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->superclass) {
//        if (tcls == cls) return YES;
//    }
//    return NO;
//}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        id person = [[Person alloc] init];
//
//        NSLog(@"%d", [person isMemberOfClass:[Person class]]);//1
//        NSLog(@"%d", [person isMemberOfClass:[NSObject class]]);//0
//
//        NSLog(@"%d", [person isKindOfClass:[Person class]]);//1
//        NSLog(@"%d", [person isKindOfClass:[NSObject class]]);//1
        
        
        // 这句代码的方法调用者不管是哪个类（只要是NSObject体系下的），都返回YES
        NSLog(@"%d", [NSObject isKindOfClass:[NSObject class]]); // 1
        NSLog(@"%d", [NSObject isMemberOfClass:[NSObject class]]); // 0
        NSLog(@"%d", [Person isKindOfClass:[Person class]]); // 0
        NSLog(@"%d", [Person isMemberOfClass:[Person class]]); // 0
        
        
        NSLog(@"%d", [person isKindOfClass:[NSObject class]]); // 1
        NSLog(@"%d", [person isMemberOfClass:[NSObject class]]); // 0
        NSLog(@"%d", [person isKindOfClass:[Person class]]); // 1
        NSLog(@"%d", [person isMemberOfClass:[Person class]]); // 1

    }
    return 0;
}
