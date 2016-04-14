//
//  AERequestManger.m
//  ArchitectureExam
//
//  Created by abc on 16/1/14.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AERequestManger.h"
static AERequestManger *g_requestManger;
@implementation AERequestManger


+ (AERequestManger *)shareAERequestManger{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_requestManger = [[self alloc]init];
    });
    return g_requestManger;
}


- (void)getAllCourse:(UIView *)view success:(void(^)(id obj))success{
    
    NSString *path = @"AllCourseList";
    
    [AESaveManager getCacheWithPath:path success:^(id obj) {
        id xObj = [self mutablCourseWithChanged:obj];
        if (success) {
            success(xObj);
        }
    } failure:^(NSString *msg) {
        [[AENetworkingManager shareAENetworkingManager] getListAllCourse:view success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *array = [responseObject objectForKey:@"allCourse"];
            if (array.count > 0) {
                id obj = [self mutablCourseWithChanged:responseObject];
                
                [AESaveManager saveCacheWithPath:path value:obj];
                
                if (success) {
                    success(responseObject);
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [AEUtilsManager showAlertView:@"网络异常"];
        }];
    }];
}


- (id)mutablCourseWithChanged:(id)obj
{
    if (obj) {
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
        
        NSArray *array = obj[@"allCourse"];
        NSMutableArray *mArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < array.count; i++) {
            NSDictionary *dic = array[i];
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
            for (NSString *key in dic.allKeys) {
                if ([key isEqualToString:@"classHours"] || [key isEqualToString:@"description"] ||
                    [key isEqualToString:@"id"] ||
                    [key isEqualToString:@"isDel"] ||
                    [key isEqualToString:@"major"] ||
                    [key isEqualToString:@"name"] ||
                    [key isEqualToString:@"no"]) {
                    [mDic setObject:dic[key] forKey:key];
                }
            }
            [mArr addObject:mDic];
        }
        [mDic setObject:mArr forKey:@"allCourse"];
        
        NSDictionary *cDic = obj[@"currentCourse"];
        NSMutableDictionary *cMDic = [[NSMutableDictionary alloc]init];
        for (NSString *key in cDic.allKeys) {
            if ([key isEqualToString:@"classHours"] || [key isEqualToString:@"description"] ||
                [key isEqualToString:@"id"] ||
                [key isEqualToString:@"isDel"] ||
                [key isEqualToString:@"major"] ||
                [key isEqualToString:@"name"] ||
                [key isEqualToString:@"no"]) {
                [cMDic setObject:cDic[key] forKey:key];
            }
        }
        
        [mDic setObject:cMDic forKey:@"currentCourse"];
        return mDic;
    }
    
    return obj;
}

#pragma mark - 课程试题列表
- (void)getListCourseDetail:(UIView *)view courseId:(NSString *)courseId success:(void(^)(id obj))success{
    NSString *path = [NSString stringWithFormat:@"CourseDetailList%@",courseId];
    
    [AESaveManager getCacheWithPath:path success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(NSString *msg) {
        [[AENetworkingManager shareAENetworkingManager] getListCourseDetail:view courseId:courseId success:^(NSURLSessionDataTask *task, id responseObject)
        {
            if ([[responseObject objectForKey:@"success"] boolValue]) {
                id value = [self mutableListCourse:responseObject[@"chapterList"]];
                if ([value count] > 0) {
                    [AESaveManager saveCacheWithPath:path value:value];
                }
                
                if (success) {
                    success(value);
                }
            }else{
                [AEUtilsManager showAlertView:@"加载失败"];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [AEUtilsManager showAlertView:@"网络异常"];
        }];
    }];
}

- (id)mutableListCourse:(id)obj{
    
    NSArray *chapterListArr = (NSArray *)obj;
    
    NSMutableArray *mutableArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < chapterListArr.count; i++) {
        NSDictionary *dic = chapterListArr[i];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
        
        for (NSString *key in dic.allKeys) {
            if ([key isEqualToString:@"id"]||
                [key isEqualToString:@"isDel"]||
                [key isEqualToString:@"name"]||
                [key isEqualToString:@"no"]) {
                [mDic setValue:dic[key] forKey:key];
            }
        }
        [mutableArr addObject:mDic];
    }
    
    return mutableArr;
}

- (void)getloadQeustionIndexList:(UIView *)view chapterId:(NSString *)chapterId courseId:(NSString *)courseId examType:(NSString *)examType success:(void(^)(id obj))success{
    NSString *path = [NSString stringWithFormat:@"CourseDetailList%@%@%@",chapterId,courseId,examType];
    [AESaveManager getCacheWithPath:path success:^(id obj) {
        id value = [self mutableQuestionIndexList:obj path:path];
        if (success) {
            success(value);
        }
    } failure:^(NSString *msg) {
        [[AENetworkingManager shareAENetworkingManager]getLoadQeustionIndexList:view examinationId:nil courseId:courseId examType:examType chapterId:chapterId success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([[responseObject objectForKey:@"success"] boolValue]) {
                
                id value = [self mutableQuestionIndexList:[responseObject objectForKey:@"questionIndexList"] path:path];
                
                if ([examType isEqualToString:@"ORDER"]) {
                    [AESaveManager saveCacheWithPath:path value:value];
                }
                if (success) {
                    success(value);
                }
            }else{
                [AEUtilsManager showAlertView:@"加载失败"];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [AEUtilsManager showAlertView:@"网络异常"];
        }];
    }];
}

- (id)mutableQuestionIndexList:(id)obj path:(NSString *)path{
    
    NSMutableArray *questionArr = [[NSMutableArray alloc]init];
    
    NSArray *listArr = (NSArray *)obj;
    
    for (int i = 0; i < listArr.count; i++) {
        NSMutableDictionary *qDic = [[NSMutableDictionary alloc]init];
        NSDictionary *dic = listArr[i];
        
        for (NSString *key in dic.allKeys) {
            id value = dic[key];
            
            NSString *valueStr = [NSString stringWithFormat:@"%@",value];
            
            [qDic setValue:[AEUtilsManager isNilWithString:valueStr] forKey:key];
        }
        [qDic setValue:path forKey:@"savePath"];
        
        [questionArr addObject:qDic];
    }
    
    return questionArr;
}

- (void)getQeustionDetail:(UIView *)view questionId:(NSString *)questionId success:(void(^)(id obj))success{
    NSString *path = [NSString stringWithFormat:@"questionId%@",questionId];
    [AESaveManager getCacheWithPath:path success:^(id obj) {
        id value = [self mutableQeustionDetail:obj];
        if (success) {
            success(value);
        }
    } failure:^(NSString *msg) {
        [[AENetworkingManager shareAENetworkingManager]getQuestionDetail:view questionId:questionId success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"success"] boolValue]) {
                id value = [self mutableQeustionDetail:responseObject[@"questionDetail"]];
                
                [AESaveManager saveCacheWithPath:path value:value];
                
                if (success) {
                    success(value);
                }
                
            }else{
                [AEUtilsManager showAlertView:@"加载失败"];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [AEUtilsManager showAlertView:@"网络异常"];
        }];
    }];
}

- (id)mutableQeustionDetail:(id)obj
{
    NSDictionary *qDic = (NSDictionary *)obj;
    
    NSMutableDictionary *dDic = [[NSMutableDictionary alloc]init];
    
    for (NSString *key in qDic.allKeys) {
        if ([key isEqualToString:@"content"] ||
            [key isEqualToString:@"id"] ||
            [key isEqualToString:@"isDel"] ||
            [key isEqualToString:@"questionType"] ||
            [key isEqualToString:@"questionTypeText"] ||
            [key isEqualToString:@"rightAnswer"] ||
            [key isEqualToString:@"difficultyLevel"]
            ||
            [key isEqualToString:@"uri"]) {
            [dDic setValue:qDic[key] forKey:key];
        }else if ([key isEqualToString:@"attachments"]
                  )
        {
            NSArray  *arr = qDic[key];
            if (arr.count > 0) {
                NSDictionary *dic = arr[0];
                if ([dic[@"uri"] length] > 0) {
                    [dDic setValue:dic[@"uri"] forKey:@"uri"];
                }
            }
        }else if ([key isEqualToString:@"answerItems"])
        {
            NSArray  *arr = qDic[key];
            NSMutableArray *mutableArr = [[NSMutableArray alloc]init];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *mDic = arr[i];
                NSMutableDictionary *aDic = [[NSMutableDictionary alloc]init];
                for (NSString *mKey in mDic.allKeys) {
                    if ([mKey isEqualToString:@"attachments"]) {
                        NSArray  *arr = mDic[mKey];
                        
                        if ([arr isKindOfClass:[NSArray class]]) {
                            if (arr.count > 0) {
                                NSDictionary *dic = arr[0];
                                if ([dic[@"uri"] length] > 0) {
                                    [aDic setValue:dic[@"uri"] forKey:@"uri"];
                                }
                            }
                        }
                    }else if ([mKey isEqualToString:@"content"] ||
                              [mKey isEqualToString:@"isDel"] ||
                              [mKey isEqualToString:@"num"]
                              ||
                              [mKey isEqualToString:@"uri"]){
                        [aDic setValue:mDic[mKey] forKey:mKey];
                    }
                }
                [mutableArr addObject:aDic];
            }
            
            [dDic setValue:mutableArr forKey:key];
        }else if ([key isEqualToString:@"questionAnalysis"])
        {
            NSArray *arr = qDic[key];
            
            if ([arr isKindOfClass:[NSArray class]]) {
                if (arr.count > 0) {
                    NSDictionary *dic = arr[0];
                    for (NSString *qKey in dic.allKeys) {
                        if ([qKey isEqualToString:@"content"]) {
                            [dDic setValue:dic[qKey] forKey:@"questionAnalysis"];
                        }
                    }
                }
            }else{
                [dDic setValue:arr forKey:@"questionAnalysis"];
 
            }
        }
    }
    
    return dDic;
}


@end
