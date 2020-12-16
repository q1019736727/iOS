//
//  main.m
//  33 内存管理定时器
//
//  Created by Chiu Young on 2020/12/15.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import "CYProxy.h"
#import "Proxy.h"
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        
        ViewController *vc = [[ViewController alloc] init];
        
        CYProxy *proxy1 = [CYProxy initWithTarget:vc];
        
        Proxy *proxy2 = [Proxy proxyWithTarget:vc];
        
        NSLog(@"%d %d",
              [proxy1 isKindOfClass:[ViewController class]],
              
              [proxy2 isKindOfClass:[ViewController class]]);

        
        
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
