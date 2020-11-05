//
//  ViewController.m
//  Runtime2
//
//  Created by Chiu Young on 2020/10/26.
//

#import "ViewController.h"

@interface ViewController ()

@end
//typedef enum {
//    MJOptionsOne = 1,   // 0b0001
//    MJOptionsTwo = 2,   // 0b0010
//    MJOptionsThree = 4, // 0b0100
//    MJOptionsFour = 8   // 0b1000
//} MJOptions;

typedef enum {
    //如果想要传入多个枚举值,在设置值时需要遵循一定规律,如下设置
//    MJOptionsNone = 0,    // 0b0000
    MJOptionsOne = 1<<0,   // 0b0001
    MJOptionsTwo = 1<<1,   // 0b0010
    MJOptionsThree = 1<<2, // 0b0100
    MJOptionsFour = 1<<3   // 0b1000
} MJOptions;
@implementation ViewController

- (void)setOptions:(MJOptions)options
{
    //与(&)上，有值就传入了这个枚举，没有就是没传入该枚举值
    if (options & MJOptionsOne) {
        NSLog(@"包含了MJOptionsOne");
    }
    
    if (options & MJOptionsTwo) {
        NSLog(@"包含了MJOptionsTwo");
    }
    
    if (options & MJOptionsThree) {
        NSLog(@"包含了MJOptionsThree");
    }
    
    if (options & MJOptionsFour) {
        NSLog(@"包含了MJOptionsFour");
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 这里|(或)上  MJOptionsOne | MJOptionsFour
    //  0000 0001
    // |0000 1000
    // -----------
    //  0000 1001
    [self setOptions:MJOptionsOne|MJOptionsFour];
}


@end
