//
//  ViewController.m
//  interview
//
//  Created by Chiu Young on 2020/9/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"
#import "Person+test.h"
#import "CYButton.h"
#import "CYUIView.h"
#import "CYOperation.h"
#import <objc/runtime.h>
#import "RunloopWatchController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)controlA{
    NSLog(@"control click");
}
- (void)btnClick2{
    NSLog(@"加大点击");
}

void test1(){
    
}
- (void)openRunLoop{
    NSLog(@"当前开辟线程 -->  %@",[NSThread currentThread]);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSThread * _monitorThread = [[NSThread alloc] initWithTarget:self selector:@selector(openRunLoop) object:nil];
    [_monitorThread start];
    
    RunloopWatchController * vc = [[NSClassFromString(@"RunloopWatchController") alloc]init];
    NSLog(@"%@",vc);
    
    //******************************************************************************

//    Person * person1 = [[Person alloc]init];
//    person1.age = 18;
//    Person * person2 = [[Person alloc]init];
//    person2.age = 20;
//    NSLog(@"未添加KVO前");
//    [self printMethods:object_getClass(person1)];
//    [self printMethods:object_getClass(person2)];
//    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew ;
//    [person1 addObserver:self forKeyPath:@"age" options:options context:nil];
//    NSLog(@"添加KVO后");
//    [self printMethods:object_getClass(person1)];
//    [self printMethods:object_getClass(person2)];
    
    //******************************************************************************

//    Person * person1 = [[Person alloc]init];
//    person1.age = 18;
//    person1.weight = 125;
//    
//    Person * person2 = [[Person alloc]init];
//    person2.age = 20;
//    person2.weight = 130;
//    
//    NSLog(@"person1 age = %ld   weight = %ld",person1.age,person1.weight);
//    NSLog(@"person2 age = %ld   weight = %ld",person2.age,person2.weight);
    Person * per = [[Person alloc]init];
    per.name = @"bob";
    NSLog(@"name == %@",per.name);
    
    
    UIControl * control = [[UIControl alloc]init];
    control.frame = CGRectMake(0, 50, 100, 100);
    control.backgroundColor = [UIColor grayColor];
    [self.view addSubview:control];
    [control addTarget:self action:@selector(controlA) forControlEvents:UIControlEventTouchUpInside];
    
  
    CYUIView * vi = [[CYUIView alloc]init];
    vi.backgroundColor = [UIColor greenColor];
    vi.frame = CGRectMake(100, 50, 100, 100);
    [self.view addSubview:vi];
    
    CYButton * btn = [[CYButton alloc]init];
    btn.frame = CGRectMake(50, 50, 100, 100);
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [vi addSubview:btn];

//    UIView * pu = [[UIView alloc]init];
//    pu.backgroundColor = [UIColor purpleColor];
//    pu.frame = CGRectMake(100, 100, 80, 80);
//    [self.view addSubview:pu];
    
    
//    CYButton * btn22 = [[CYButton alloc]init];
//    btn22.frame = CGRectMake(100, 300, 100, 100);
//    btn22.backgroundColor = [UIColor linkColor];
//    [btn22 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn22];
    
        
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 2;
    
    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
//    [op1 start];
    
    NSBlockOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    
    CYOperation * op3 = [[CYOperation alloc]init];
//    [op2 start];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];

//    for (int a = 0; a < 100000; a ++) {
//        NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{
//            NSLog(@"%@",[NSThread currentThread]);
//        }];
//        [queue addOperation:op];
//    }


    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting | kCFRunLoopExit, false, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"主线程监听");
    });
    
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    CFRelease(observer);
    
    
    
    unsigned int count;
    Ivar * ivas = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        Ivar iva = ivas[i];
//        NSLog(@"%s   %s",ivar_getName(iva),ivar_getTypeEncoding(iva));
    }
    free(ivas);
    
    UITextField * textF = [[UITextField alloc]init];
    textF.frame = CGRectMake(100, 100, 100, 50);
    textF.placeholder = @"请输入";
//    [self.view addSubview:textF];
    //iOS13 以前能通过KVC方式修改，现在不行了禁止了
//    [textF setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    


}

- (void)btnClick{
    NSLog(@"btnClick");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    Person * p = [[Person alloc]init];
    p.name = @"你好啊";
    __weak Person * weakPerson = p;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"----%@",weakPerson);
    });
    NSLog(@"touchesBegan:withEvent:");
}//出栈

- (void)printMethods:(Class)class{
    NSMutableArray * arr = [NSMutableArray array];
    unsigned int count;
    // 获得方法数组
    //C语言的方法出现creat或则copy最后都需要free(释放)
    Method * methodlists = class_copyMethodList(class, &count);
    for (int a = 0; a < count; a++) {
        // 获得方法
        Method method = methodlists[a];
        // 获得方法名
        NSString * methodname = NSStringFromSelector(method_getName(method));
        [arr addObject:methodname];
    }
    // 释放
    free(methodlists);
    NSLog(@"==%@",arr);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"age"];
}
@end
