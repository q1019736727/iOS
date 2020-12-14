//
//  main.m
//  31 atomic
//
//  Created by Chiu Young on 2020/12/14.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person * p = [[Person alloc]init];
        p.data = [NSMutableArray array];//setter
        for (int i = 0; i < 10; i++) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // 加锁
                p.data = [NSMutableArray array];
                // 解锁
            });
        }

        NSMutableArray * arr = [p data];//getter
        [arr addObject:@"1"];
        [arr addObject:@"2"];
        
        NSLog(@"%@",p.data);

    }
    return 0;
}
