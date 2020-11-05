//
//  main.m
//  16 runtime 消息转发
//
//  Created by Chiu Young on 2020/10/28.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Cat.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        Person * per = [[Person alloc]init];
//        [per testAge:25];
//        [per changeAge:33];
        
        [Person metaClassTest];
    }
    return 0;
}
