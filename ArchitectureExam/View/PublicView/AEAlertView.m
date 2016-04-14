//
//  AEAlertView.m
//  ArchitectureExam
//
//  Created by admin on 16/1/22.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEAlertView.h"
#import "AEBaseView.h"

#define kGap 30
#define kPadding 10
#define kTitleHeight 40
#define kButtonHeight 35
#define KMsgHeight   80

@interface AEAlertView ()

@property (strong,nonatomic)NSString *titleStr;
@property (strong,nonatomic)NSString *messageStr;
@property (strong,nonatomic)NSString *cancelStr;
@property (strong,nonatomic)NSString *confirmStr;
@property (strong,nonatomic)AEBaseView *baseView;

@end

@implementation AEAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle complete:(AlertViewBlock)complete{
    
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH - 2 * kGap, kPadding + kTitleHeight + kButtonHeight + KMsgHeight);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.alertViewBlock = complete;
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        self.titleStr = title;
        self.messageStr = message;
        self.cancelStr = cancelButtonTitle;
        self.confirmStr = confirmButtonTitle;
        [self setUpSubView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)setUpSubView{
    
    [self setUpLabelWithFrame:CGRectMake(0, 0, self.frame.size.width, kTitleHeight) title:self.titleStr font:[UIFont systemFontOfSize:16] color:nil];
    [self setUpLineViewFrame:CGRectMake(2 * kPadding, kTitleHeight, self.frame.size.width - 4 * kPadding, 1)];
    [self setUpLabelWithFrame:CGRectMake(2 * kPadding, kTitleHeight, self.frame.size.width - 4 * kPadding, KMsgHeight) title:self.messageStr font:[UIFont systemFontOfSize:14] color:[UIColor grayColor]];
    
    if (self.cancelStr.length > 0 && self.confirmStr.length) {
        CGFloat w = (self.frame.size.width - 5 * kPadding)/2;
        
        [self setUpButtonWithFrame:CGRectMake(2 * kPadding, KMsgHeight + kTitleHeight, w, kButtonHeight) title:self.cancelStr font:[UIFont systemFontOfSize:14] color:[UIColor grayColor] tag:0];
        
        [self setUpButtonWithFrame:CGRectMake(3 * kPadding + w, KMsgHeight + kTitleHeight, w, kButtonHeight) title:self.confirmStr font:[UIFont systemFontOfSize:14] color:AERGB(147, 216, 110) tag:1];
        
    }else if (self.cancelStr.length > 0){
        [self setUpButtonWithFrame:CGRectMake(2 * kPadding, KMsgHeight + kTitleHeight, self.frame.size.width - 4 *kPadding, kButtonHeight) title:self.cancelStr font:[UIFont systemFontOfSize:14] color:[UIColor grayColor] tag:0];

    }else if (self.confirmStr.length > 0){
        [self setUpButtonWithFrame:CGRectMake(2 * kPadding, KMsgHeight + kTitleHeight, self.frame.size.width - 4 *kPadding, kButtonHeight) title:self.confirmStr font:[UIFont systemFontOfSize:14] color:AERGB(147, 216, 110) tag:1];
    }
}


- (void)setUpLabelWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text =title;
    if (color) {
       label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self addSubview:label];
}

- (void)setUpLineViewFrame:(CGRect)frame{
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
    [self addSubview:lineView];
}

- (void)setUpButtonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color tag:(NSInteger)tag{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.backgroundColor = color;
    button.layer.cornerRadius = 3;
    button.tag = tag;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)buttonClick:(UIButton *)button{
    if (self.alertViewBlock) {
        self.alertViewBlock(button.tag,self.tag);
    }
    [self closeView];
}

- (void)show{
    UIWindow *window = [AEUtilsManager getSystemWindow];
    
    self.baseView.frame = window.bounds;
    [window addSubview:self.baseView];
    
    self.center = window.center;
    [window addSubview:self];
    
    self.layer.transform = CATransform3DMakeScale(0, 0, 1);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.layer.transform = CATransform3DIdentity;
        self.baseView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    } completion:^(BOOL finished) {
    }];
}

- (void)closeView{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.layer.transform = CATransform3DScale(self.layer.transform, 0.0000001, 0.0000001, 1);
        self.baseView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
    } completion:^(BOOL finished)
     {
         [self.baseView removeFromSuperview];
         [self removeFromSuperview];
     }];
}


- (AEBaseView *)baseView{
    if (_baseView == nil) {
        _baseView = [[AEBaseView alloc]initWithFrame:CGRectZero];
    }
    return _baseView;
}

@end
