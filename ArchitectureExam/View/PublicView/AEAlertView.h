//
//  AEAlertView.h
//  ArchitectureExam
//
//  Created by admin on 16/1/22.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertViewBlock)(NSInteger index,NSInteger viewTag);

@interface AEAlertView : UIView

@property (copy,nonatomic)AlertViewBlock alertViewBlock;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle complete:(AlertViewBlock)complete;

- (void)show;

@end
