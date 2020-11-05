//
//  main.m
//  iOS底层原理
//
//  Created by Chiu Young on 2020/9/24.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "Person.h"
#import "Person+test.h"
struct NSObject_IMPL {
    Class isa;
};

struct People_IMPL {
    struct NSObject_IMPL NSObject_IVARS; //8字节
    int _age; //4字节
};// 16 内存对齐：结构体的大小必须是最大成员大小的倍数

struct Student_IMPL {
    struct People_IMPL People_IVARS; //16
    int _no; //4字节
};//16


@interface People : NSObject
{
    @public
    int _age;
}
@end
@implementation People
@end


@interface Student:People{
    @public
    int _no;
}
@end
@implementation Student
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //******************************************************************************
        
//        Person * obj = [[Person alloc]init];
//        NSLog(@"%zd",class_getInstanceSize([Person class]));
//        NSLog(@"%zd",malloc_size((__bridge const void*)obj));//(__bridge const void*)这里是桥接OC指针为c的指针
        
//        Student * stu = [[Student alloc]init];
//        NSLog(@"%zd",class_getInstanceSize([Student class]));
//        NSLog(@"%zd",malloc_size((__bridge const void*)stu));
//
//        NSObject * obj = [[NSObject alloc]init];
//        NSLog(@"%zd",class_getInstanceSize([NSObject class]));
//        NSLog(@"%zd",malloc_size((__bridge const void*)obj));
        
        
        //******************************************************************************

        
//        Student * stu1 = [[Student alloc]init];
//        Student * stu2 = [[Student alloc]init];
//
//        NSLog(@"instance = %p  %p",stu1,stu2);
//
//        Class stuClass1 = object_getClass(stu1);
//        Class stuClass2 = object_getClass(stu2);
//        Class stuClass3 = [stu1 class];
//        Class stuClass4 = [stu2 class];
//        Class stuClass5 = [Student class];
//        Class stuClass6 = [NSObject class];
//        NSLog(@"class = %p  %p  %p   %p   %p    %p",stuClass1,stuClass2,stuClass3,stuClass4,stuClass5,stuClass6);
//
//        Class metaClass1 = object_getClass(stuClass1);
//        Class metaClass2 = object_getClass(stuClass2);
//        Class metaClass3 = object_getClass(stuClass3);
//        Class metaClass4 = object_getClass(stuClass4);
//        Class metaClass5 = object_getClass(stuClass5);
//        NSLog(@"meta-class = %p  %p  %p   %p    %p",metaClass1,metaClass2,metaClass3,metaClass4,metaClass5);

        //******************************************************************************

//        Person * person1 = [[Person alloc]init];
//        person1.age = 18;
//        person1.name = @"jack";
//
//        Person * person2 = [[Person alloc]init];
//        person2.age = 20;
//        person2.name = @"rose";
//
//
//        NSLog(@"person1 age = %ld   name = %@",person1.age,person1.name);
//        NSLog(@"person2 age = %ld   name = %@",person2.age,person2.name);
        
        //************************************* block *****************************************

        void(^block)(void) = ^{
            NSLog(@"hello world");
        };
        block();
        
    }
    return 0;
}
