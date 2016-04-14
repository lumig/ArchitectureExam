//
//  AEChooseCourseView.m
//  ArchitectureExam
//
//  Created by abc on 16/1/6.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEChooseCourseView.h"

#define kGap 15

@interface AEChooseCourseView ()<AEBaseViewDelegate>

@property (strong,nonatomic)UIScrollView *scrollView;

@end

@implementation AEChooseCourseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setCourseArr:(NSMutableArray *)courseArr{
    _courseArr = courseArr;
    CGFloat allWitdh = kGap;
    for (int i = 0; i < courseArr.count; i++) {
        AECourseModel *model = courseArr[i];
        CGFloat w = [AEUtilsManager stringBoundingRectWithSize:CGSizeMake(MAXFLOAT, self.scrollView.frame.size.height) font:[UIFont systemFontOfSize:15] text:model.name].width;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(allWitdh, 0, w, self.scrollView.frame.size.height);
        button.tag = 10 + i;
        [button setTitle:model.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        allWitdh += (w + kGap);
    }
    self.scrollView.contentSize = CGSizeMake(allWitdh, 0);
}


- (void)btnDidClick:(UIButton *)button{
    NSInteger tag = button.tag - 10;
    
    if (self.courseArr.count > tag) {
        AECourseModel *model = self.courseArr[tag];
        if (self.courseBlock) {
            self.courseBlock(model);
        }
        [self closeView];
    }
}


- (void)closeView{
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self.superview removeFromSuperview];
//    }];
    
    self.isShowStation = NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.layer.transform = CATransform3DMakeTranslation(0, -40, 0);
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];
    
}

- (void)touchBegin{
    [self closeView];
}

- (void)show{
    UIWindow *window = [AEUtilsManager getSystemWindow];
    
    AEBaseView *baseView = [[AEBaseView alloc]initWithFrame:window.bounds];
    baseView.deleagate = self;
    [window addSubview:baseView];
    [baseView addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showInView:(UIView *)view{
    AEBaseView *baseView = [[AEBaseView alloc]initWithFrame:view.bounds];
    baseView.deleagate = self;
    baseView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [view addSubview:baseView];
    [baseView addSubview:self];
    self.isShowStation = YES;
    self.layer.transform = CATransform3DMakeTranslation(0, -40, 0);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
    }];
}


- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = YES;
    }
    return _scrollView;
}


@end
