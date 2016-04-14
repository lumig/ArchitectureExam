//
//  AEBaseView.h
//  ArchitectureExam
//
//  Created by abc on 16/1/6.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AEBaseViewDelegate <NSObject>

- (void)touchBegin;

@end

@interface AEBaseView : UIView

@property (assign,nonatomic)id<AEBaseViewDelegate> deleagate;

@end
