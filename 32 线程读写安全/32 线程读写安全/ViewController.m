//
//  ViewController.m
//  32 线程读写安全
//
//  Created by Chiu Young on 2020/12/14.
//

#import "ViewController.h"
#import <pthread.h>
@interface ViewController ()
@end
@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dispatch_queue_t rwqueue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int a = 0; a < 10; a ++) {
        dispatch_async(rwqueue, ^{
            [self read];
        });
        dispatch_async(rwqueue, ^{
            [self read];
        });
        dispatch_barrier_async(rwqueue, ^{
            [self write];
        });
    }
}

- (void)read{
    sleep(1);
    NSLog(@"read");
}
- (void)write{
    sleep(1);
    NSLog(@"write");
}




//@property (nonatomic, assign) pthread_rwlock_t rwt;
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    pthread_rwlock_init(&_rwt, NULL);
//    for (int a = 0; a < 10; a ++) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [self read];
//        });
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [self read];
//        });
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [self write];
//        });
//    }
//}
//- (void)read{
//    pthread_rwlock_rdlock(&_rwt);
//    sleep(1);
//    NSLog(@"read");
//    pthread_rwlock_unlock(&_rwt);
//}
//- (void)write{
//    pthread_rwlock_wrlock(&_rwt);
//    sleep(1);
//    NSLog(@"write");
//    pthread_rwlock_unlock(&_rwt);
//}
//- (void)dealloc{
//    pthread_rwlock_destroy(&_rwt);
//}







//@property (nonatomic, strong) dispatch_semaphore_t semaphore;

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//
//    self.semaphore = dispatch_semaphore_create(1);
//
//    for (int a = 0; a < 10; a ++) {
//
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [self read];
//        });
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [self write];
//        });
//
//    }
//
//}
//
//- (void)read{
//    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
//
//    sleep(1);
//    NSLog(@"read");
//
//    dispatch_semaphore_signal(self.semaphore);
//}
//
//- (void)write{
//    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
//
//    sleep(1);
//    NSLog(@"write");
//
//    dispatch_semaphore_signal(self.semaphore);
//}
@end
