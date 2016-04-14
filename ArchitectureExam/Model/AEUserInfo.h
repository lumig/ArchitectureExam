//
//  AEUserInfo.h
//  ArchitectureExam
//
//  Created by abc on 16/1/18.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserInfoDefaultCenter @"kUserInfoDefaultCenter"

@interface AEUserInfo : NSObject

+ (AEUserInfo *)shareAEUserInfo;

@property (strong,nonatomic)NSDictionary *userInfo;

@property (strong,nonatomic)NSMutableArray *errorArr;
@property (strong,nonatomic)NSMutableArray *collectionArr;
@property (assign,nonatomic)NSInteger      lastExamIndex;
@property (strong,nonatomic)NSMutableArray *examRecordArr;
@property (strong,nonatomic)NSMutableDictionary   *examRecordDic;

- (void)getLocationUserInfo;

- (void)saveLocationUserInfo:(NSDictionary *)dic;

- (void)removeLocationUserInfo;

- (void)saveExamRecordWith:(NSMutableDictionary *)recordDic;
- (void)removeLastExamRecord;


- (void)addErrorQestionDic:(NSMutableDictionary *)qestionDic;
- (void)removeErrorQestionDic:(NSMutableDictionary *)qestionDic;
- (void)addCollectionQestionDic:(NSMutableDictionary *)qestionDic;
- (void)removeCollectionQestionDic:(NSMutableDictionary *)qestionDic;
- (void)removeAllError;
- (void)removeAllCollection;
- (BOOL)isJudgeCollectionDic:(NSMutableDictionary *)qestionDic;

@end
