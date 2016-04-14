//
//  AEExamPresentView.h
//  ArchitectureExam
//
//  Created by abc on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AEExamPresentViewDelegate <NSObject>

@optional
- (void)examPresentView:(NSIndexPath *)indexPath;

- (void)examCleanAllData;

@end

@interface AEExamPresentView : UIView

@property (strong,nonatomic)NSMutableArray *qeustionArr;
@property (assign,nonatomic)id<AEExamPresentViewDelegate> delegate;

- (void)showInView;

- (void)packUp;

@end
