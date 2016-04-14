//
//  AppShareManger.h
//  ShareSDKDemo
//
//  Created by Lumig on 16/1/19.
//  Copyright © 2016年 mob.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
@interface AppShareManger : NSObject

+ (AppShareManger *)shareManager;

- (void)shareTitle:(NSString *)title content:(NSString *)content defaultContent:(NSString *)defaultContent image:(NSData *)image url:(NSString *)url mediaType:(SSPublishContentMediaType)mediaType;

- (NSData *)screenShots:(UIView *)view size:(CGSize)size;

@end
