//
//  main.m
//  block
//
//  Created by Chiu Young on 2020/10/14.
//

#import <Foundation/Foundation.h>
#import "Person.h"
//int d = 10;//全局变量
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        //局部变量
//        int a = 10;
//        auto int b = 10;
//        static int c = 10;
//        void(^block)(void) = ^{
//            NSLog(@"a = %d",a);
//            NSLog(@"b = %d",b);
//            NSLog(@"c = %d",c);
//            NSLog(@"d = %d",d);
//        };
//        a = 20;
//        b = 20;
//        c = 20;
//        d = 20;
//        block();
//    }
//    return 0;
//}

//****************************************************

//******************MRC环境下******************
//int age = 20;
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        int a = 10;
//        static int b = 30;
//        void(^block1)(void) = ^{
//            NSLog(@"block1");
//        };
//        void(^block2)(void) = ^{
//            NSLog(@"block2  a = %d",a);
//        };
//        void(^block3)(void) = ^{
//            NSLog(@"block3  age = %d",b);
//        };
//        void(^block4)(void) = ^{
//            NSLog(@"block3  age = %d",age);
//        };
//        NSLog(@"block1  %@",[block1 class]);
//        NSLog(@"block2  %@",[block2 class]);
//        NSLog(@"block3  %@",[block3 class]);
//        NSLog(@"block4  %@",[block4 class]);
//        NSLog(@"block  %@",[^{} class]);
//    }
//    return 0;
//}

//****************************************************

//******************MRC环境下******************
//void(^block)(void);//定义一个block
//void test()
//{
//    int a = 10;
//    block = [^{
//        NSLog(@"block a = %d",a);
//    } copy]; //MRC环境下调用copy 变为堆block(MallocBlock)
//}
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        test();
//        block();
//    }
//    return 0;
//}

//****************************************************

//ARC环境下面
//typedef void(^CYBlock)(void);
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        CYBlock myblock1 = ^{
//
//        };
//
//        int a = 10;
//        CYBlock myblock2 = ^{
//            NSLog(@"a = %d",a);
//        };
//
//
//        NSLog(@"%@",[myblock1 class]);
//        NSLog(@"%@",[myblock2 class]);
//
//
//    }
//    return 0;
//}


//****************************************************
//ARC环境下面
//typedef void(^CYBlock)(void);
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        CYBlock block;
//
//        //下面的{}花括号 表示一个栈，花括号结束表示出栈
//        {
//            Person * person = [[Person alloc]init];
//            person.age = 10;
//            block = ^{
//                NSLog(@"====%ld",person.age);
//            };
//        }//出栈
//
//        block();//这里block强引用peroson在，当person出栈并不会销毁，只有当block出栈才会销毁
//        NSLog(@"--------------");
//
//    }//出栈
//    return 0;
//}

//typedef void(^CYBlock)(void);
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        CYBlock block;
//
//        //下面的{}花括号 表示一个栈，花括号结束表示出栈
//        {
//            Person * person = [[Person alloc]init];
//            person.age = 10;
//            __weak Person * weakPerson = person;
//            block = ^{
//                NSLog(@"====%ld",weakPerson.age);//这里弱引用peroson，一旦出栈，person就会被销毁
//            };
//        }//出栈
//
//        block();//调用时person已被销毁
//        NSLog(@"--------------");
//
//    }//出栈
//    return 0;
//}


//****************************************************
typedef void(^CYBlock)(void);
int main(int argc, const char * argv[]) {
    @autoreleasepool {

//        Person * person = [[Person alloc]init];
//        person.age = 10;
//        CYBlock block1 = ^{
//            person.age = 20;
//            NSLog(@"person.age ====%ld", person.age);
//        };
//        block1();
        
        __block int age = 10;
        CYBlock block2 = ^{
            age = 20;
            NSLog(@"age ====%d",age);
        };
        block2();
    }
    return 0;
}
