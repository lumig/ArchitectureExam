//
//  AppShareManger.m
//  ShareSDKDemo
//
//  Created by Lumig on 16/1/19.
//  Copyright © 2016年 mob.com. All rights reserved.
//

#import "AppShareManger.h"

@implementation AppShareManger
+ (AppShareManger *)shareManager
{
    static AppShareManger *shareManager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        shareManager = [[AppShareManger alloc] init];
    });
    
    return shareManager;
}

- (void)shareTitle:(NSString *)title content:(NSString *)content defaultContent:(NSString *)defaultContent image:(NSData *)image url:(NSString *)url mediaType:(SSPublishContentMediaType)mediaType
{
    //1、构造分享内容
    //1.1、要分享的图片（以下分别是网络图片和本地图片的生成方式的示例）
//    id<ISSCAttachment> remoteAttachment = [ShareSDKCoreService attachmentWithUrl:@"http://f.hiphotos.bdimg.com/album/w%3D2048/sign=df8f1fe50dd79123e0e09374990c5882/cf1b9d16fdfaaf51e6d1ce528d5494eef01f7a28.jpg"];
//        id<ISSCAttachment> localAttachment = [ShareSDKCoreService attachmentWithPath:[[NSBundle mainBundle] pathForResource:@"screenshots" ofType:@"png"]];
    id<ISSCAttachment> localAttachment = [ShareSDKCoreService attachmentWithData:image fileName:nil mimeType:nil];
    
    //1.2、以下参数分别对应：内容、默认内容、图片、标题、链接、描述、分享类型
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:nil
                                                image:localAttachment
                                                title:title
                                                  url:url
                                          description:nil
                                            mediaType:mediaType];
    
    //1.3、自定义各个平台的分享内容(非必要)
    [self customizePlatformShareContent:publishContent];
    
    //1.4、自定义一个分享菜单项(非必要)
    id<ISSShareActionSheetItem> customItem = [ShareSDK shareActionSheetItemWithTitle:@"Custom"
                                                                                icon:[UIImage imageNamed:@"Icon.png"]
                                                                        clickHandler:^{
                                                                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Custom item"
                                                                                                                                message:@"Custom item has been clicked"
                                                                                                                               delegate:nil
                                                                                                                      cancelButtonTitle:@"OK"
                                                                                                                      otherButtonTitles:nil];
                                                                            [alertView show];
                                                                        }];
    //1.5、分享菜单栏选项排列位置和数组元素index相关(非必要)
    NSMutableArray *shareArray = [NSMutableArray array];
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"sinaweibo://"]]){
        [shareArray addObject:SHARE_TYPE_NUMBER(ShareTypeSinaWeibo)];

    }
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"mqq://"]]){
        [shareArray addObject:SHARE_TYPE_NUMBER(ShareTypeQQ)];
    }
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"wechat://"]]){
        [shareArray addObject:SHARE_TYPE_NUMBER(ShareTypeWeixiSession)];
    }
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"mqzone://"]]){
        [shareArray addObject:
                               SHARE_TYPE_NUMBER(ShareTypeQQSpace)];
    }
    NSArray *shareList = [ShareSDK currentAuthUserWithType:shareArray];

    
    //1+、创建弹出菜单容器（iPad应用必要，iPhone应用非必要）
    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //2、展现分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                NSLog(@"=== response state :%zi ",state);
                                
                                //可以根据回调提示用户。
                                if (state == SSResponseStateSuccess)
                                {
                                    [self showHUBWithTitle:@"分享成功!"];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    [self showHUBWithTitle:[NSString stringWithFormat:@"Error Description：%@",[error errorDescription]]];
                                }
                            }];
}


- (void)customizePlatformShareContent:(id<ISSContent>)publishContent
{
    //定制QQ空间分享内容
    [publishContent addQQSpaceUnitWithTitle:@"The title of QQ Space."
                                        url:@"http://www.mob.com"
                                       site:nil
                                    fromUrl:nil
                                    comment:@"comment"
                                    summary:@"summary"
                                      image:nil
                                       type:@(4)
                                    playUrl:nil
                                       nswb:0];
    
    //定制邮件分享内容
    [publishContent addMailUnitWithSubject:@"The subject of Mail"
                                   content:@"The content of Mail."
                                    isHTML:[NSNumber numberWithBool:YES]
                               attachments:nil
                                        to:nil
                                        cc:nil
                                       bcc:nil];
    
    //定制新浪微博分享内容
    id<ISSCAttachment> localAttachment = [ShareSDKCoreService attachmentWithPath:[[NSBundle mainBundle] pathForResource:@"shareImg" ofType:@"png"]];
    [publishContent addSinaWeiboUnitWithContent:@"The content of Sina Weibo" image:localAttachment];
}

- (void)showHUBWithTitle:(NSString *)title
{
    MBProgressHUD *hub=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = title;
    [hub hide:YES afterDelay:1];
}

//截屏获取相应位置的图片
- (NSData *)screenShots:(UIView *)view size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImage *image = [self combine:img backImage:[UIImage imageNamed:@"erweima.jpg"] size:size];
    
    NSData *data = UIImagePNGRepresentation(image);
    return data;
    
}

#pragma mark -- 拼接图片
- (UIImage *)combine:(UIImage *)frontImage backImage:(UIImage *)backImage size:(CGSize)size
{
    UIGraphicsBeginImageContext(CGSizeMake(320, 426));
    [backImage drawInRect:CGRectMake(0, 0, 320, 426)];
    
    [frontImage drawInRect:CGRectMake(20, 100, 280,210)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
