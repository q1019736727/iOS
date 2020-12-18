//
//  ViewController.m
//  35 Tagged Pointer
//
//  Created by Chiu Young on 2020/12/17.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSString *name;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
        
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
//    for (int a = 0; a < 1000; a++) {
//        dispatch_async(queue, ^{
//            self.name = [NSString stringWithFormat:@"abcdefghijk"];
//        });
//    }
    
    for (int a = 0; a < 1000; a++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"abc"];
        });
    }

    
        NSNumber * num1 = @3;
        NSNumber * num2 = @4;
        NSNumber * num3 = @5;
        NSNumber * num4 = @(0xFFFFFFFFFFFFFFF);
        NSObject * obj = [[NSObject alloc]init];
    
        NSLog(@"%p  %p  %p  %p  %p",num1,num2,num3,num4,obj);
    //
    //    //查看3  4  5 的 ASCII码
    //    NSLog(@"%p %p %p",'3','4','5');

    

//    NSString * str1 = [NSString stringWithFormat:@"123abc"];
//    NSString * str2 = [NSString stringWithFormat:@"abcdefghijk"];
//
//    NSLog(@"str1 = %@   str2 = %@",[str1 class],[str2 class]);
//    NSLog(@"end");
}

//- (void)setName:(NSString *)name{
//    if (_name != name) {
//        [_name release];
//        _name = [name retain];
//    }
//}


@end
