//
//  main.m
//  13 查看对象Cache
//
//  Created by Chiu Young on 2020/10/27.
//

#import <Foundation/Foundation.h>
#import "MJGoodStudent.h"
#import "MJClassInfo.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //        MJPerson *person = [[MJPerson alloc] init];
        //        mj_objc_class *personClass = (__bridge mj_objc_class *)[MJPerson class];
        //
        //        [person personTest];
        
        MJGoodStudent *goodStudent = [[MJGoodStudent alloc] init];
        mj_objc_class *goodStudentClass = (__bridge mj_objc_class *)[MJGoodStudent class];
        [goodStudent goodStudentTest];
        [goodStudent studentTest];
        [goodStudent personTest];
        [goodStudent goodStudentTest];
        [goodStudent studentTest];
        NSLog(@"--------------------------");
        cache_t cache = goodStudentClass->cache;
        //这里的 cache.imp 是自己封装的
        NSLog(@"%s %p", @selector(personTest), cache.imp(@selector(personTest)));
        NSLog(@"%s %p", @selector(studentTest), cache.imp(@selector(studentTest)));
        NSLog(@"%s %p", @selector(goodStudentTest), cache.imp(@selector(goodStudentTest)));
        NSLog(@"--------------------------");
        bucket_t *buckets = cache._buckets;
        bucket_t bucket = buckets[(long long)@selector(studentTest) & cache._mask];
        NSLog(@"%s %p", bucket._key, bucket._imp);
        NSLog(@"--------------------------");
        //获取散列表里面的数据
        for (int i = 0; i < cache._mask; i++) {
            bucket_t bucket = buckets[i];
            NSLog(@"%s %p", bucket._key, bucket._imp);
        }
        NSLog(@"123");
        
    }
    return 0;
}
