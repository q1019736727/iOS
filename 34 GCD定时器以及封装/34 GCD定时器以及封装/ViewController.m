//
//  ViewController.m
//  34 GCD定时器以及封装
//
//  Created by Chiu Young on 2020/12/16.
//

#import "ViewController.h"
#import "CYTimer.h"

@interface ViewController ()
@property (nonatomic, strong)dispatch_source_t timer;
@property (nonatomic, copy) NSString * timerIndf;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"begin");
    
//    self.timerIndf = [CYTimer doTask:^{
//        NSLog(@"1111");
//    } start:2.0 interval:1.0 repeats:NO async:YES];
    
    self.timerIndf = [CYTimer withTarget:self selector:@selector(doTask) start:0 interval:1 repeats:YES async:NO];
}
- (void)doTask{
    NSLog(@"doTask");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [CYTimer cancelTask:_timerIndf];
}
- (void)test{
    dispatch_queue_t queue = dispatch_queue_create("timerqueue", DISPATCH_QUEUE_SERIAL);
    ///下面的0，0一般都写默认的
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    NSInteger start = 0;
    
    NSInteger interval = 1;
    
    dispatch_source_set_timer(_timer,
                              dispatch_time(DISPATCH_TIME_NOW, start*NSEC_PER_SEC),
                              interval*NSEC_PER_SEC,
                              0);
    
    dispatch_source_set_event_handler(_timer, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    dispatch_resume(_timer);
}
@end
