//
//  AENetworkingManager.m
//  ArchitectureExam
//
//  Created by abc on 16/1/5.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AENetworkingManager.h"

#define HOST_DOMAIN @"http://www.foredusoft.com"

static AENetworkingManager *g_networkingManager;

@implementation AENetworkingManager

+ (AENetworkingManager *)shareAENetworkingManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_networkingManager = [[self alloc]init];
    });
    return g_networkingManager;
}

- (void)getListAllCourse:(UIView *)view
                 success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self getWithPath:@"/exam/course/guest/listAllCourse" parameters:nil view:view success:success failure:failure];
}

//获取课程所有的章节信息
- (void)getListCourseDetail:(UIView *)view
                courseId:(NSString *)courseId
                 success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self getWithPath:@"/exam/chapter/guest/listAllChapterInCourse" parameters:@{@"courseId":courseId} view:view success:success failure:failure];

}

//获获取试题详情
- (void)getQuestionDetail:(UIView *)view
               questionId:(NSString *)questionId
                  success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                  failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self getWithPath:@"/exam/question/guest/questionDetail" parameters:@{@"questionId":questionId} view:view success:success failure:failure];

}

//加载考试所有试题索引
- (void)getLoadQeustionIndexList:(UIView *)view
                   examinationId:(NSString *)examinationId
                        courseId:(NSString *)courseId
                        examType:(NSString *)examType
                       chapterId:(NSString *)chapterId
                         success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:@{@"examType":examType}];
    if (chapterId) {
        [dic setObject:chapterId forKey:@"chapterId"];
    }
    if (courseId) {
        [dic setObject:courseId forKey:@"courseId"];
    }
    
    if (examinationId) {
        [dic setObject:examinationId forKey:@"examinationId"];
    }
    
    [self getWithPath:@"/exam/examination/guest/loadQeustionIndexList" parameters:dic view:view success:success failure:failure];
}


//登录
- (void)loginWithName:(NSString *)name
             password:(NSString *)password
                 view:(UIView *)view
              success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self getWithPath:@"/exam/login" parameters:@{@"username":name,@"password":password} view:view success:success failure:failure];
}


//上传考试记录
- (void)updateMockExamRank:(UIView *)view
                  courseId:(NSString *)courseId
            mockExamResult:(NSDictionary *)mockExamResult
                   success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if (courseId) {
        [dic setValue:courseId forKey:@"courseId"];
    }
    
    if (mockExamResult) {
        [dic setValue:mockExamResult forKey:@"mockExamResult"];
    }
    
    [self getWithPath:@"/exam/user/mockExamRank" parameters:dic view:view success:success failure:failure];
}

- (void)queryFormalExaminations:(UIView *)view
                        success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self getWithPath:@"/exam/user/queryFormalExaminationsForAPP" parameters:nil view:view success:success failure:failure];

}

- (void)formalExamHistory:(UIView *)view
                  success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                  failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self getWithPath:@"/exam/user/formalExamHistory" parameters:nil view:view success:success failure:failure];
}


- (void)getWithPath:(NSString *)url
             parameters:(id)parameters
                   view:(UIView *)view
                success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self getWithBasePath:[NSString stringWithFormat:@"%@%@",HOST_DOMAIN,url] parameters:parameters view:view success:success failure:failure];
}


//get请求
- (void)getWithBasePath:(NSString *)url
         parameters:(id)parameters
               view:(UIView *)view
            success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
            failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if (view) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    session.responseSerializer = serializer;
    [session GET:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (view) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            });
        }
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (view) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            });
        }
        if (failure) {
            failure(task,error);
        }
    }];
}


- (void)postWithPath:(NSString *)url
              parameters:(id)parameters
                    view:(UIView *)view
                 success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    
}

//get请求
- (void)postWithBasePath:(NSString *)url
             parameters:(id)parameters
                   view:(UIView *)view
                success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if (view) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.removesKeysWithNullValues = YES;
    session.responseSerializer = serializer;
    [session POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (view) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            });
        }
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (view) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            });
        }
        if (failure) {
            failure(task,error);
        }
    }];
}

@end
