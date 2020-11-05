//
//  Student.m
//  18 super
//
//  Created by Chiu Young on 2020/10/29.
//

#import "Student.h"
#import <objc/runtime.h>
@implementation Student

/*
 [super message]的底层实现
 1.消息接收者仍然是子类对象
 2.从父类开始查找方法的实现
 */
struct objc_super {
    __unsafe_unretained _Nonnull id receiver; // 消息接收者
    __unsafe_unretained _Nonnull Class super_class; // 消息接收者的父类
};
- (void)run
{
    [super run];
    //上面方法clang出来的代码简化
    struct objc_super arg = {self, [Person class]};
    objc_msgSendSuper(arg, @selector(run));
    
//     objc_msgSendSuper(
//                         {self,//自身
//                         class_getSuperclass(objc_getClass("Student"))//父类也就是[MJPerson class]
//                         }, //对象有两个参数
//                        @selector("run") //方法名
//     );
     
    NSLog(@"run方法");
}
//编译出来的方法
/*
static void _I_Student_run(Student * self, SEL _cmd) {
    ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("Student"))}, sel_registerName("run"));
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_rg_r9gjwl7d0mzd9yyrh26jknqr0000gn_T_Student_880d4e_mi_0);
}
 */





- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"[self class] = %@", [self class]); // Student
        NSLog(@"[self superclass] = %@", [self superclass]); // Person
        NSLog(@"--------------------------------");
        NSLog(@"[super class] = %@", [super class]); // Student
        NSLog(@"[super superclass] = %@", [super superclass]); // Person
        
        
        [self class];
        objc_msgSend(self,@selector(class));
        
        [super class];
        objc_msgSendSuper({self, [MJPerson class]}, @selector(class));
    }
    return self;
}

@end

@implementation NSObject

- (Class)superclass
{
    return class_getSuperclass(object_getClass(self));
}

- (Class)class
{
    //这里的返回值取决于消息接接收者
    return object_getClass(self);
}


@end
