//
//  Macro.h
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#ifndef Macro_h
#define Macro_h


#define systemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define AERGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//导航栏的颜色
#define COLOR_NAV [UIColor colorWithHex:0x2EA6F2]

//背景颜色
#define COLOR_BACKGROUD [UIColor colorWithHex:0xF2F2F2]

//浅灰色
#define COLOR_LINGGRAY [UIColor colorWithHex:0xCFCFCF]

//深灰色
#define COLOR_DAERTGRAY [UIColor colorWithHex:0x636363]

//橘黄色
#define COLOR_ORANGE [UIColor colorWithHex:0xF27E19]

#endif /* Macro_h */
