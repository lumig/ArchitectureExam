//
//  AECourseModel.h
//  ArchitectureExam
//
//  Created by abc on 16/1/6.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AECourseModel : NSObject

@property (strong,nonatomic)NSString *classHours;
@property (strong,nonatomic)NSString *courseAdmin;
@property (strong,nonatomic)NSString *createBy;
@property (strong,nonatomic)NSString *createTime;
@property (strong,nonatomic)NSString *courseDescription;
@property (strong,nonatomic)NSString *courseId;
@property (strong,nonatomic)NSString *isDel;
@property (strong,nonatomic)NSString *lastUpdateBy;
@property (strong,nonatomic)NSString *lastUpdateTime;
@property (strong,nonatomic)NSString *major;
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *no;

+ (AECourseModel *)fetchWithDic:(NSDictionary *)dic;

@end
