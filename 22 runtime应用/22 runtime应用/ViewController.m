//
//  ViewController.m
//  22 runtime应用
//
//  Created by Chiu Young on 2020/11/6.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSString * obj = nil;
//
//    NSMutableArray * array = [NSMutableArray array];
//    [array addObject:@20];
//    [array addObject:obj];
//
//    NSLog(@"array = %@",array);
    
    
    
    NSString * obj = nil;

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@10 forKey:@"age"];
    [dic setValue:@10 forKey:nil];
    [dic setValue:obj forKey:@"name"];
//    dic[@"name"] = nil;
    
    NSLog(@"dic = %@",dic);
    
    NSLog(@"haha = %@",dic[@"haha"]);

    
    
}

- (IBAction)click1 {
    NSLog(@"click1");
}
- (IBAction)click2 {
    NSLog(@"click2");
}
- (IBAction)click3 {
    NSLog(@"click3");
}

@end
