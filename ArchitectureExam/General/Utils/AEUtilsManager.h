//
//  AEUtilsManager.h
//  ArchitectureExam
//
//  Created by abc on 16/1/6.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEUtilsManager : NSObject

+(BOOL)isNilWithDictionary:(id)dictionary;

+(NSString *)isNilWithString:(id)string;

+ (CGSize)stringBoundingRectWithSize:(CGSize)contentMaxSize font:(UIFont *)font text:(NSString *)text;

+ (UIWindow *)getSystemWindow;

+ (void)showAlertView:(NSString *)msg;

+ (id)mutablWithChanged:(id)obj;

+ (NSString *)countDownDateFormartWithSecond:(int)second;

+ (NSString *)countDownStringWithSecond:(int)second;

+ (NSString *)getCurrentTime;

@end
