//
//  UIApplication+Sharing.h
//  FPHClient
//
//  Created by Lumig on 16/1/19.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"


@interface UIApplication (Sharing)

+ (void)registerApp;

+ (BOOL)shareHandleOpenURL:(NSURL *)url wxDelegate:(id<WXApiDelegate>)delegate;
+ (BOOL)shareHandleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation
           wxDelegate:(id<WXApiDelegate>)delegate;

@end
