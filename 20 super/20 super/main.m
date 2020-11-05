//
//  main.m
//  20 super
//
//  Created by Chiu Young on 2020/11/3.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// 局部变量分配在栈空间
// 栈空间分配，从高地址到低地址
void test()
{
    //定义8个字节的abcd
    long long a = 4; // 0x7ffeee2d5d18
    long long b = 5; // 0x7ffeee2d5d10
    long long c = 6; // 0x7ffeee2d5d08
    long long d = 7; // 0x7ffeee2d5d00
    
    NSLog(@"%p %p %p %p", &a, &b, &c, &d);
}
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//        test();
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
