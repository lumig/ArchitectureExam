//
//  AESaveManager.h
//  ArchitectureExam
//
//  Created by abc on 16/1/14.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESaveManager : NSObject


+ (void)getCacheWithPath:(NSString *)path success:(void(^)(id obj))success failure:(void(^)(NSString *msg))failure;

+ (void)saveCacheWithPath:(NSString *)path value:(id)value;

+ (void)removeCacheWithPath:(NSString *)path;

@end
