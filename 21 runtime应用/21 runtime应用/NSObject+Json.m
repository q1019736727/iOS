//
//  NSObject+Json.m
//  21 runtime应用
//
//  Created by Chiu Young on 2020/11/6.
//

#import "NSObject+Json.h"
#import <objc/runtime.h>

@implementation NSObject (Json)
+ (instancetype)mj_objectWithJson:(NSDictionary *)json;
{
    id obj = [[self alloc] init];
      
      unsigned int count;
      Ivar *ivars = class_copyIvarList(self, &count);
      for (int i = 0; i < count; i++) {
          // 取出i位置的成员变量
          Ivar ivar = ivars[i];
          NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
          //删除掉前面名称最前面的下划线
          [name deleteCharactersInRange:NSMakeRange(0, 1)];
          // 设值
          id value = json[name];
          [obj setValue:value forKey:name];
      }
      free(ivars);
      
      return obj;
}
@end
