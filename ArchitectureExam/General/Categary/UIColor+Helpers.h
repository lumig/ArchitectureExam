//
//  UIColor+Helpers.h
//  FrameWork
//
//  Created by chuxiaolong on 15/8/9.
//  Copyright (c) 2015年 BST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Helpers)
+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)RandomColor;
@end
