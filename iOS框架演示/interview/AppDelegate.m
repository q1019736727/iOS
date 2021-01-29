//
//  AppDelegate.m
//  interview
//
//  Created by Chiu Young on 2020/9/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AppDelegate.h"

//crash信息捕获
#include <signal.h>
#include <execinfo.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)initHandler {
    struct sigaction newSignalAction;
    memset(&newSignalAction, 0,sizeof(newSignalAction));
    newSignalAction.sa_handler = &signalHandler;
    sigaction(SIGABRT, &newSignalAction, NULL);
    sigaction(SIGILL, &newSignalAction, NULL);
    sigaction(SIGSEGV, &newSignalAction, NULL);
    sigaction(SIGFPE, &newSignalAction, NULL);
    sigaction(SIGBUS, &newSignalAction, NULL);
    sigaction(SIGPIPE, &newSignalAction, NULL);
    
    //异常时调用的函数
    NSSetUncaughtExceptionHandler(&handleExceptions);
}
void handleExceptions(NSException *exception) {
    NSLog(@"捕获 exception = %@",exception);
    NSLog(@"捕获 reason = %@",exception.reason);
    NSLog(@"捕获 callStackSymbols = %@",[exception callStackSymbols]);
    NSLog(@"------------------------------------------");
}

void signalHandler(int sig) {
    //最好不要写，可能会打印太多内容
//    NSLog(@"signal = %d", sig);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initHandler];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
