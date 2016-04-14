//
//  AEChooseCourseView.h
//  ArchitectureExam
//
//  Created by abc on 16/1/6.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AECourseModel.h"

typedef void(^AEChooseCourseViewBlock)(AECourseModel *model);

@interface AEChooseCourseView : UIView

@property (copy,nonatomic)AEChooseCourseViewBlock courseBlock;

@property (strong,nonatomic)NSMutableArray *courseArr;

@property (assign,nonatomic)BOOL    isShowStation;

- (void)show;

- (void)showInView:(UIView *)view;

- (void)closeView;

@end
