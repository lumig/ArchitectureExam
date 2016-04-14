//
//  AETapBackView.m
//  ArchitectureExam
//
//  Created by admin on 16/1/22.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AETapBackView.h"

@interface AETapBackView ()

@property (strong,nonatomic)UITapGestureRecognizer *tapGR;

@end

@implementation AETapBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGestureRecognizer:self.tapGR];
    }
    return self;
}

- (void)setIsEable:(BOOL)isEable{
    _isEable = isEable;
    self.tapGR.enabled = isEable;
}

- (void)tapDidClick{
    if ([self.delegate respondsToSelector:@selector(backViewTapDidClick)]) {
        [self.delegate backViewTapDidClick];
    }
}

- (UITapGestureRecognizer *)tapGR{
    if (_tapGR == nil) {
        _tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDidClick)];
        _tapGR.enabled = self.isEable;
    }
    return _tapGR;
}

@end
