//
//  AENetworkingManager.h
//  ArchitectureExam
//
//  Created by abc on 16/1/5.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AENetworkingManager : NSObject

+ (AENetworkingManager *)shareAENetworkingManager;


//获取课程列表
- (void)getListAllCourse:(UIView *)view
                 success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
//获取课程所有的章节信息
- (void)getListCourseDetail:(UIView *)view
                courseId:(NSString *)courseId
                 success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
//加载试题详情
- (void)getQuestionDetail:(UIView *)view
                questionId:(NSString *)questionId
                 success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

//加载考试所有试题索引
- (void)getLoadQeustionIndexList:(UIView *)view
                   examinationId:(NSString *)examinationId
                        courseId:(NSString *)courseId
                        examType:(NSString *)examType
                       chapterId:(NSString *)chapterId
                         success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
//登录
- (void)loginWithName:(NSString *)name
             password:(NSString *)password
                 view:(UIView *)view
              success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
//上传考试记录
- (void)updateMockExamRank:(UIView *)view
                  courseId:(NSString *)courseId
            mockExamResult:(NSDictionary *)mockExamResult
                   success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
//最近考试通知
- (void)queryFormalExaminations:(UIView *)view
                        success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
//历史考试记录
- (void)formalExamHistory:(UIView *)view
                  success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                  failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
