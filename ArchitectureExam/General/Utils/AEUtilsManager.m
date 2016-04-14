//
//  AEUtilsManager.m
//  ArchitectureExam
//
//  Created by abc on 16/1/6.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEUtilsManager.h"

@implementation AEUtilsManager

+(BOOL)isNilWithDictionary:(id)dictionary{
    
    if (dictionary == [NSNull null]||dictionary == nil
        ||([dictionary isKindOfClass:[NSString class]] && [dictionary isEqualToString:@"<null>"])) {
        return NO;
    }
    NSDictionary *dict = dictionary;
    if(dict != nil && dict.count>0){
        return YES;
    }
    return NO;
}

+(NSString *)isNilWithString:(id)string
{
    if ([string isKindOfClass:[NSString class]]){
        if ([string isEqualToString:@"<null>"]) {
            return @"";
        }
    }
    if (string == [NSNull null] || string == nil || [string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    return string;
}

+ (CGSize)stringBoundingRectWithSize:(CGSize)contentMaxSize font:(UIFont *)font text:(NSString *)text
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [text boundingRectWithSize:contentMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}

+ (UIWindow *)getSystemWindow{
    return [[UIApplication sharedApplication].delegate window];
}

+ (void)showAlertView:(NSString *)msg{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

+ (id)mutablWithChanged:(id)obj{
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objDic = (NSDictionary *)obj;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        for (id xObj in objDic.allKeys) {
            
            id valueObj = objDic[xObj];
            
            if ([valueObj isKindOfClass:[NSDictionary class]] || [valueObj isKindOfClass:[NSArray class]]) {
                
                id value = [AEUtilsManager mutablWithChanged:valueObj];
                
                if (value) {
                    [dic setValue:value forKey:xObj];
                }
            }else{
                
                id value = [AEUtilsManager isNilWithString:valueObj];
                
                if (value) {
                    [dic setValue:value forKey:xObj];
                }
            }
        }
        return dic;
    }else if([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSArray *objArr = (NSArray *)obj;
        for (id xObj in objArr) {
            if ([xObj isKindOfClass:[NSDictionary class]] || [xObj isKindOfClass:[NSArray class]]) {
                id value = [AEUtilsManager mutablWithChanged:xObj];
                if (value) {
                    [arr addObject:value];
                }
            }else{
                
                id value = [AEUtilsManager isNilWithString:xObj];
                
                if (value) {
                    [arr addObject:value];
                }
            }
        }
    }
    
    return [AEUtilsManager isNilWithString:obj];
}

+ (NSString *)countDownDateFormartWithSecond:(int)second{
    NSMutableString *activtuDate = [[NSMutableString alloc]init];
    if (second >= 60){
        [activtuDate appendFormat:@"%.2d",(int)second/60];
        second %= 60;
    }else{
        [activtuDate appendFormat:@"00"];
    }
    [activtuDate appendFormat:@":%.2d",(int)second];
    return activtuDate;
}

+ (NSString *)countDownStringWithSecond:(int)second{
    NSMutableString *activtuDate = [[NSMutableString alloc]init];
    if (second >= 60){
        [activtuDate appendFormat:@"%.2d",(int)second/60];
        second %= 60;
    }else{
        [activtuDate appendFormat:@"00"];
    }
    [activtuDate appendFormat:@"分%.2d秒",(int)second];
    return activtuDate;
}

+ (NSString *)getCurrentTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

@end
