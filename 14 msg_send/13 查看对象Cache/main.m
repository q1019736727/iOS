//
//  main.m
//  13 查看对象Cache
//
//  Created by Chiu Young on 2020/10/27.
//

#import <Foundation/Foundation.h>
#import "MJGoodStudent.h"
#import <objc/runtime.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        MJPerson * person = [[MJPerson alloc]init];
        [person personTest];
        // objc_msgSend(person, @selector(personTest));
        // 消息接收者（receiver）：person
        // 消息名称：personTest
        
        
        [MJPerson initialize];
        // objc_msgSend([MJPerson class], @selector(initialize));
        // 消息接收者（receiver）：[MJPerson class]
        // 消息名称：initialize
        
        // OC的方法调用：消息机制，给方法调用者发送消息
        
        // objc_msgSend如果找不到合适的方法进行调用，会报错unrecognized selector sent to instance

        
        //编译出来的源码这里以对象方法personTest为例
//       ((void (*)(id, SEL))(void *)objc_msgSend)((id)person, sel_registerName("personTest"));
        
        //简写
//        objc_msgSend(person,sel_registerName("personTest"));
        
        //再次简写 sel_registerName("personTest") == @selector(personTest)
//        objc_msgSend(person,@selector(personTest));

    }
    return 0;
}

