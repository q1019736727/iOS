//
//  main.m
//  block2
//
//  Created by Chiu Young on 2020/10/19.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [[Person alloc] init];
        person.age = 10;
        __weak typeof(person) weakperson = person;
        person.block = ^{
            NSLog(@"age is %d", weakperson.age);
        };
    }
    NSLog(@"111111");
    return 0;
}
    
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        Person *person = [[Person alloc] init];
//        person.age = 10;
//        person.block = ^{
//            NSLog(@"age is %d", person.age);
//        };
//    }
//    NSLog(@"111111");
//    return 0;
//}

