//
//  ViewController.m
//  20 super
//
//  Created by Chiu Young on 2020/11/3.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * test = @"1234";
    
    id cls = [Person class];

    void *obj = &cls;

    [(__bridge id)obj print];
}


@end
