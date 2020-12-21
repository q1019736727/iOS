//
//  ViewController.m
//  37 copy
//
//  Created by Chiu Young on 2020/12/21.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Person * per = [[Person alloc]init];
    
    per.data = [NSMutableArray array];
    [per.data addObject:@"a"];
    [per.data addObject:@"b"];
    
    NSLog(@"%@",per.data);

    
    
}

void test1(){
    //不可变数据类型拷贝
    NSString *str1 = [[NSString alloc] initWithFormat:@"test"];
    
    //为什么没有产生新的对象呢，因为copy出来都是不可变得数据，而str1也是不可变的，所以直接接着使用str1的内存地址，节省内存开销
    NSString *str2 = [str1 copy];// 浅拷贝，指针拷贝，没有产生新对象
    
    //这里str3的数据类型是可变的字符串，所以必须产生新的对象,这样改变str3的数据，不会影响str1
    //如果我们将下面的 mutablecopy 改为 copy,在执行[str3 appendFormat:@"哈哈"]，会发生crash，报找不到appendFormat:方法
    //所以就算你前面声明的是NSMutableString类型，但是你是copy出来的，就会默认你是不可变类型
//    NSMutableString *str3 = [str1 copy];
//    [str3 appendFormat:@"哈哈"]; //crash
    NSMutableString *str3 = [str1 mutableCopy]; // 深拷贝，内容拷贝，有产生新对象
    [str3 appendFormat:@"哈哈"];
    
    NSLog(@"%@ %@ %@", str1, str2, str3);
    NSLog(@"%p %p %p", str1, str2, str3);

    
    //可变数据类型拷贝
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:@"a", @"b", nil];
    
    NSArray *array2 = [array1 copy]; // 深拷贝
    
    NSMutableArray *array3 = [array1 mutableCopy]; // 深拷贝
    [array3 addObject:@"c"];
    
    NSLog(@"%@ %@ %@", array1, array2, array3);
    NSLog(@"%p %p %p", array1, array2, array3);

}

@end
