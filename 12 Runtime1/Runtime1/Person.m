//
//  Person.m
//  Runtime1
//
//  Created by Chiu Young on 2020/10/22.
//

#import "Person.h"


// 掩码，一般用来按位与(&)运算的
//#define MJTallMask 1
//#define MJRichMask 2
//#define MJHandsomeMask 4

//#define MJTallMask 0b00000001
//#define MJRichMask 0b00000010
//#define MJHandsomeMask 0b00000100

//********************************************************第一种******************************************************************************//

//#define MJTallMask (1<<0) //1左移0位  0b00000001    1
//#define MJRichMask (1<<1) // 1左移1位 0b00000010    2
//#define MJHandsomeMask (1<<2) //1左移2位 0b00000100    4
//@interface Person()
//{
//    char _tallRichHansome;
//}
//@end
//@implementation Person
//
//- (instancetype)init{
//    if (self = [super init]) {
//        //一个字节8位
//        //这里我们将tall存第一位为，rich第二位，handsome第三位 (默认都是0)
//        _tallRichHansome = 0b00000000;
//    }
//    return self;
//}
//- (void)setTall:(BOOL)tall{
//    if (tall) {//YES
//        //0000 0001 (mask) |（或)上 0000 0000 , 就能设置对应的位为1
//        _tallRichHansome |= MJTallMask;
//    }else{//NO
//        //这里 ~MJTallMask 表示取反 ，就是 1111 1110 (mask) &(与)上 0000 0000,就能设置对应的位为0
//        _tallRichHansome &= ~MJTallMask;
//    }
//}
//- (BOOL)isTall{
//    //取值这里重点讲一下
//    //我们以取第二位为例, 取下来的值 要么是有值(YES)，要么没有值(NO),那么我们可以通过取反来得到BOOL类型的值
//    //  0000 0011 (值第二位为YES）       0000 0001  （值第二位为NO）
//    // &0000 0010                     &0000 0010
//    // ----------                     ----------
//    //  0000 0010                      0000 0000
//// 结果     2(10进制)                    0(10进制)
////上面结果   !(2)取反就是NO(因为值取反,有值就变为没值0),然后再次取反 !!(2) 就得到最后的结果
//    //根据上面的推理我们可以如下表示
//    return !!(_tallRichHansome & MJTallMask);
//}
//- (void)setRich:(BOOL)rich{
//    if (rich) {
//        _tallRichHansome |= MJRichMask;
//    }else{
//        _tallRichHansome &= ~MJRichMask;
//    }
//}
//- (BOOL)isRich{
//    return !!(_tallRichHansome & MJRichMask);
//}
//
//- (void)setHandsome:(BOOL)handsome{
//    if (handsome) {
//        _tallRichHansome |= MJHandsomeMask;
//    }else{
//        _tallRichHansome &= ~MJHandsomeMask;
//    }
//}
//
//- (BOOL)isHandsome{
//    return !!(_tallRichHansome & MJHandsomeMask);
//}

//********************************************************第二种******************************************************************************//


//@interface Person()
//{
//    // 位域
//    //下面的 :1 表示只用一个字节,如果没有:1一个char就要用8个字节
//    //重用往左
//    struct {
//        char tall : 1;
//        char rich : 1;
//        char handsome : 1;
//    } _tallRichHandsome;
//}
//@end
//
//@implementation Person
//
//- (void)setTall:(BOOL)tall
//{
//    _tallRichHandsome.tall = tall;
//}
//
//- (BOOL)isTall
//{
//    return !!_tallRichHandsome.tall;
//}
//
//- (void)setRich:(BOOL)rich
//{
//    _tallRichHandsome.rich = rich;
//}
//
//- (BOOL)isRich
//{
//    return !!_tallRichHandsome.rich;
//}
//
//- (void)setHandsome:(BOOL)handsome
//{
//    _tallRichHandsome.handsome = handsome;
//}
//
//- (BOOL)isHandsome
//{
//    return !!_tallRichHandsome.handsome;
//}


//********************************************************第三种******************************************************************************//


#define MJTallMask (1<<0)
#define MJRichMask (1<<1)
#define MJHandsomeMask (1<<2)
#define MJThinMask (1<<3)

@interface Person()
{
    union {
        //如果存储的数据要很大可以改变一下这个 bits的数据类型
        int bits;//4个字节(32位)
        //这下面相当于描述，没有这个也一样
        struct {
            char tall : 4;
            char rich : 4;
            char handsome : 4;
            char thin : 4;
        };
    } _tallRichHandsome;
}
@end
@implementation Person
- (void)setTall:(BOOL)tall
{
    if (tall) {
        //或上
        _tallRichHandsome.bits |= MJTallMask;
    } else {
        //与上
        _tallRichHandsome.bits &= ~MJTallMask;
    }
}
- (BOOL)isTall
{
    return !!(_tallRichHandsome.bits & MJTallMask);
}
- (void)setRich:(BOOL)rich
{
    if (rich) {
        _tallRichHandsome.bits |= MJRichMask;
    } else {
        _tallRichHandsome.bits &= ~MJRichMask;
    }
}
- (BOOL)isRich
{
    return !!(_tallRichHandsome.bits & MJRichMask);
}
- (void)setHandsome:(BOOL)handsome
{
    if (handsome) {
        _tallRichHandsome.bits |= MJHandsomeMask;
    } else {
        _tallRichHandsome.bits &= ~MJHandsomeMask;
    }
}
- (BOOL)isHandsome
{
    return !!(_tallRichHandsome.bits & MJHandsomeMask);
}
- (void)setThin:(BOOL)thin
{
    if (thin) {
        _tallRichHandsome.bits |= MJThinMask;
    } else {
        _tallRichHandsome.bits &= ~MJThinMask;
    }
}
- (BOOL)isThin
{
    return !!(_tallRichHandsome.bits & MJThinMask);
}

@end
