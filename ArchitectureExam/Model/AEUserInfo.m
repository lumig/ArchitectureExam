//
//  AEUserInfo.m
//  ArchitectureExam
//
//  Created by abc on 16/1/18.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEUserInfo.h"

#define kUserErrorKey @"kUserErrorKey"
#define kUserCollectionKey @"kUserCollectionKey"
#define kExamRecordKey @"kExamRecordKey"
#define kLastExamRecordKey @"kLastExamRecordKey"
#define kLastExamIndexKey @"kLastExamIndexKey"

static AEUserInfo *g_userInfo;

@interface AEUserInfo ()

@end

@implementation AEUserInfo

+ (AEUserInfo *)shareAEUserInfo{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_userInfo = [[self alloc]init];
        [g_userInfo getLocationLastExamIndex];
        [g_userInfo getLocationError];
        [g_userInfo getLocationCollection];
        [g_userInfo getExamRecord];
        [g_userInfo getLastExamRecord];
    });
    
    return g_userInfo;
}

- (void)getLocationUserInfo{
//    [self getLocation];
}

- (void)setLastExamIndex:(NSInteger)lastExamIndex{
    _lastExamIndex = lastExamIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithInteger:lastExamIndex] forKey:kLastExamIndexKey];
    [defaults synchronize];
}

- (void)getLocationLastExamIndex{
    _lastExamIndex =  [[[NSUserDefaults standardUserDefaults] objectForKey:@"kLastExamIndexKey"] integerValue];;
}

- (void)saveLocationUserInfo:(NSDictionary *)dic{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:dic forKey:kUserInfoKey];
//    [defaults synchronize];
    self.userInfo = dic;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kUserInfoDefaultCenter object:nil];
}

//- (void)getLocation{
//    self.userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoKey];
//}

- (void)removeLocationUserInfo{
    self.userInfo = nil;
    [[NSNotificationCenter defaultCenter]postNotificationName:kUserInfoDefaultCenter object:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"kUserInfoNameKey"];
    [defaults removeObjectForKey:@"kUserInfoPwdKey"];
    [defaults synchronize];
}

- (void)saveExamRecordWith:(NSMutableDictionary *)recordDic{
    [self.examRecordArr addObject:recordDic];
    self.examRecordDic = recordDic;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.examRecordArr forKey:kExamRecordKey];
    [defaults setValue:recordDic forKey:kLastExamRecordKey];
    [defaults synchronize];
}

- (void)removeLastExamRecord{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLastExamRecordKey];
}

- (void)getLastExamRecord{
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"kLastExamRecordKey"];
    if (dic) {
        [self.examRecordDic removeAllObjects];
        for (NSString *key in dic.allKeys) {
            [self.examRecordDic setValue:dic[key] forKey:key];
        }
    }
}

- (void)getExamRecord{
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:kExamRecordKey];
    if (arr.count > 0) {
        [self.examRecordArr addObjectsFromArray:arr];
    }
}


#pragma mark - 错题
- (void)addErrorQestionDic:(NSMutableDictionary *)qestionDic{
    BOOL flag = NO;
    for (NSDictionary *q in self.errorArr) {
        if ([q[@"questionId"] isEqualToString:qestionDic[@"questionId"]]) {
            flag = YES;
            break;
        }
    }
    if (!flag) {
        if (qestionDic) {
//            [qestionDic setObject:@NO forKey:@"qeustionExamComplete"];
//            [qestionDic removeObjectForKey:@"qeustionSelectedAnswer"];
            [self.errorArr addObject:qestionDic];
            [self modifyError];
        }
    }
}
- (void)removeErrorQestionDic:(NSMutableDictionary *)qestionDic{
    for (NSDictionary *q in self.errorArr) {
        if ([q[@"questionId"] isEqualToString:qestionDic[@"questionId"]]) {
            [self.errorArr removeObject:q];
            break;
        }
    }
    [self modifyError];
}

- (void)modifyError{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.errorArr forKey:kUserErrorKey];
    [defaults synchronize];
}

- (void)getLocationError{
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:kUserErrorKey];
    if (arr.count > 0) {
        [self.errorArr addObjectsFromArray:[self mutableValue:arr]];
    }
}

- (void)removeAllError{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserErrorKey];
    [self.errorArr removeAllObjects];
}

#pragma mark - 收藏

- (void)addCollectionQestionDic:(NSMutableDictionary *)qestionDic{
    BOOL flag = NO;
    for (NSDictionary *q in self.collectionArr) {
        if ([q[@"questionId"] isEqualToString:qestionDic[@"questionId"]]) {
            flag = YES;
            break;
        }
    }
    if (!flag) {
        if (qestionDic) {
//            [qestionDic setObject:@NO forKey:@"qeustionExamComplete"];
//            [qestionDic removeObjectForKey:@"qeustionSelectedAnswer"];
            [self.collectionArr addObject:qestionDic];
            [self modifyCollection];
        }
    }
}
- (void)removeCollectionQestionDic:(NSMutableDictionary *)qestionDic{
    BOOL flag = NO;
    for (NSDictionary *q in self.collectionArr) {
        if ([q[@"questionId"] isEqualToString:qestionDic[@"questionId"]]) {
            flag = YES;
            [self.collectionArr removeObject:q];
            break;
        }
    }
    if (flag) {
        [self modifyError];
    }
}

- (void)removeAllCollection{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserCollectionKey];
    [self.collectionArr removeAllObjects];
}

- (BOOL)isJudgeCollectionDic:(NSMutableDictionary *)qestionDic{
    for (NSDictionary *q in self.collectionArr) {
        if ([q[@"questionId"] isEqualToString:qestionDic[@"questionId"]]) {
            return YES;
        }
    }
    return NO;
}


- (void)modifyCollection{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.collectionArr forKey:kUserCollectionKey];
    [defaults synchronize];
}

- (void)getLocationCollection{
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:kUserCollectionKey];
    if (arr.count > 0) {
        [self.collectionArr addObjectsFromArray:[self mutableValue:arr]];
    }
}

#pragma mark - 
- (id)mutableValue:(id)obj{
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
        [questionArr addObject:qDic];
    }
    
    return questionArr;
}

#pragma mark - getter

- (NSMutableArray *)errorArr{
    if (_errorArr == nil) {
        _errorArr = [[NSMutableArray alloc]init];
    }
    return _errorArr;
}

- (NSMutableArray *)collectionArr{
    if (_collectionArr == nil) {
        _collectionArr = [[NSMutableArray alloc]init];
    }
    return _collectionArr;
}

- (NSMutableArray *)examRecordArr{
    if (_examRecordArr == nil) {
        _examRecordArr = [[NSMutableArray alloc]init];
    }
    return _examRecordArr;
}

@end
