//
//  AESaveManager.m
//  ArchitectureExam
//
//  Created by abc on 16/1/14.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AESaveManager.h"

@implementation AESaveManager


+ (void)getCacheWithPath:(NSString *)path success:(void(^)(id obj))success failure:(void(^)(NSString *msg))failure{
    id cache = [[NSUserDefaults standardUserDefaults]objectForKey:path];
    
    if (cache) {
        if (success) {
            success(cache);
        }
    }else{
        if (failure) {
            failure(@"无数据");
        }
    }
}

+ (void)saveCacheWithPath:(NSString *)path value:(id)value{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:value forKey:path];
        [defaults synchronize];
    });
}

+ (void)removeCacheWithPath:(NSString *)path{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:path];
    [defaults synchronize];
}


@end
