//
//  AESimulateExamPresentView.h
//  ArchitectureExam
//
//  Created by admin on 16/1/22.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AESimulateExamPresentViewDelegate <NSObject>

@optional
- (void)examPresentView:(NSIndexPath *)indexPath;

@end

@interface AESimulateExamPresentView : UIView

@property (strong,nonatomic)NSMutableArray *qeustionArr;

@property (assign,nonatomic)id<AESimulateExamPresentViewDelegate> delegate;

@property (assign,nonatomic)BOOL       isPop;

@property (strong,nonatomic)NSIndexPath *currentIndexPath;

- (void)showInView:(UIView *)view;

@end
