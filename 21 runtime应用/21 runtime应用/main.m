//
//  main.m
//  21 runtime应用
//
//  Created by Chiu Young on 2020/11/5.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"
#import "NSObject+Json.h"


void changeMethod(){
    NSLog(@"-----changeMethod");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 字典转模型
        NSDictionary *json = @{
                               @"age" : @20,
                               @"weight" : @60,
                               @"name" : @"Jack"
                               };
        Person *person = [Person mj_objectWithJson:json];


        NSLog(@"age = %d",person.age);
        NSLog(@"weight = %d",person.weight);
        NSLog(@"name = %@",person.name);

        
    }
    return 0;
}


void test4(){
    //        Person * per = [[Person alloc]init];
    //        //替换原有方法
    //        class_replaceMethod([Person class], @selector(run), (IMP)changeMethod, "v");
    //        [per run];
    
    
    Person * per = [[Person alloc]init];
    Method runMethod = class_getInstanceMethod([Person class], @selector(run));
    Method testMethod = class_getInstanceMethod([Person class], @selector(test));
    //方法交换
    method_exchangeImplementations(runMethod, testMethod);
    [per run];
    [per test];
    
}

void test3(){
    unsigned int count;
    Ivar * ivas = class_copyIvarList([Person class], &count);
    for (int i = 0; i < count; i++) {
        Ivar iva = ivas[i];
        NSLog(@"%s   %s",ivar_getName(iva),ivar_getTypeEncoding(iva));
    }
    free(ivas);
}
void test2(){
    // 获取成员变量信息
    Ivar ageIvar = class_getInstanceVariable([Person class], "_age");
    //获取ivar属性名称和编码类型
    NSLog(@"%s  %s", ivar_getName(ageIvar),ivar_getTypeEncoding(ageIvar));
    
    // 设置和获取成员变量的值
    Ivar nameIvar = class_getInstanceVariable([Person class], "_name");
    Person * per = [[Person alloc]init];
    object_setIvar(per, nameIvar, @"Tom");
    object_setIvar(per, ageIvar, (__bridge id)(void *)10);
    NSLog(@"%@ %d", per.name, per.age);
    
}


void run(id self, SEL _cmd){
    NSLog(@"%@ -  %@",self,NSStringFromSelector(_cmd));
}
void test1(){
    // 动态创建类
    Class newClass = objc_allocateClassPair([NSObject class], "Stuent", 0);
    //添加属性(从以前的结构图我们可以知道，属性只能在注册之前添加)
    class_addIvar(newClass, "_age", 4, 1, @encode(int));
    //添加方法(可以注册前也可以注册后添加方法)
    class_addMethod(newClass, @selector(run), (IMP)run, "v@:");
    // 注册类
    objc_registerClassPair(newClass);
    id stu = [[newClass alloc] init];
    [stu setValue:@10 forKey:@"_age"];
    NSLog(@"age = %@",[stu valueForKey:@"_age"]);
    
    
    Person * per = [[Person alloc]init];
    //设置isa指向的Class(直接将Person类换成了我们动态生成的Stuent类)
    object_setClass(per, newClass);
    [per run]; //<Stuent: 0x10050d8f0> -  run
}
