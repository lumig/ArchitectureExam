//
//  AECourseModel.m
//  ArchitectureExam
//
//  Created by abc on 16/1/6.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AECourseModel.h"

@implementation AECourseModel

+ (AECourseModel *)fetchWithDic:(NSDictionary *)dic
{
    AECourseModel *model = [[AECourseModel alloc]init];
    
    if ([dic isKindOfClass:[NSDictionary class]]) {
        [model setValuesForKeysWithDictionary:dic];
    }
    
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.courseId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.courseDescription = value;
    }
}

@end
