//
//  AETapBackView.h
//  ArchitectureExam
//
//  Created by admin on 16/1/22.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AETapBackViewDelegate <NSObject>

- (void)backViewTapDidClick;

@end

@interface AETapBackView : UIView

@property (assign,nonatomic)id<AETapBackViewDelegate> delegate;

@property (assign,nonatomic)BOOL    isEable;

@end
