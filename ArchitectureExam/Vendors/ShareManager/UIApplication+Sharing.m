//
//  UIApplication+Sharing.m
//  FPHClient
//
//  Created by Lumig on 16/1/19.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import "UIApplication+Sharing.h"

#define shareSdkApp @"de90525eb200"
#define weChatApp @"wx216c5b4803a52876"
#define weChatAppSecret @"25a5c750f7a2f9ef082f4675905eb485"
#define QzoneApp @""
#define QQApp @""
#define QQAppSecret @""
#define weiboApp @""
#define weiboAppSecret @""


@implementation UIApplication (Sharing)
//- (BOOL)application: didFinishLaunchingWithOptions:  中调用
+ (void)registerApp
{
    [ShareSDK registerApp:shareSdkApp];//字符串api20为您的ShareSDK的AppKey


    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址   http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:weChatApp
                           appSecret:weChatAppSecret
                           wechatCls:[WXApi class]];
//    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
//                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
//                           wechatCls:[WXApi class]];
    
}


+ (BOOL)shareHandleOpenURL:(NSURL *)url wxDelegate:(id<WXApiDelegate>)delegate
{
    return [ShareSDK handleOpenURL:url wxDelegate:delegate];
}

+ (BOOL)shareHandleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation wxDelegate:(id<WXApiDelegate>)delegate
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:delegate];
}


@end
