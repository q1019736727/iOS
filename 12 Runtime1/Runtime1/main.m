//
//  main.m
//  Runtime1
//
//  Created by Chiu Young on 2020/10/21.
//

#import <Foundation/Foundation.h>
#import "Person.h"



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person * person = [[Person alloc]init];
        person.tall = YES;
        person.rich = YES;
        person.handsome = YES;
        NSLog(@"tall : %d",person.isTall);
        NSLog(@"rich : %d",person.isRich);
        NSLog(@"handsome : %d",person.isHandsome);

    }
    return 0;
}
