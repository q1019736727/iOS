//
//  main.m
//  16 dynamic
//
//  Created by Chiu Young on 2020/10/29.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person * pr = [[Person alloc]init];
        pr.age = 20;
        NSLog(@"%d",pr.age);
        
    }
    return 0;
}
