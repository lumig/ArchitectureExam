//
//  AERequestManger.h
//  ArchitectureExam
//
//  Created by abc on 16/1/14.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AERequestManger : NSObject

+ (AERequestManger *)shareAERequestManger;

//获取课程
- (void)getAllCourse:(UIView *)view success:(void(^)(id obj))success;

//获取课程章节列表
- (void)getListCourseDetail:(UIView *)view courseId:(NSString *)courseId success:(void(^)(id obj))success;

//获取试题详情
- (void)getloadQeustionIndexList:(UIView *)view chapterId:(NSString *)chapterId courseId:(NSString *)courseId examType:(NSString *)examType success:(void(^)(id obj))success;

//获取试题详情
- (void)getQeustionDetail:(UIView *)view questionId:(NSString *)questionId success:(void(^)(id obj))success;


@end
