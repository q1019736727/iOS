//
//  main.m
//  15 runtime 动态方法解析
//
//  Created by Chiu Young on 2020/10/28.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person * per = [[Person alloc]init];
//        [per test];
//        [Person classTest];
//        [per play];
        
        [per say];
        
    }
    return 0;
}
