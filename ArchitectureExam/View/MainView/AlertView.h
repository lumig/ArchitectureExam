//
//  AlertView.h
//  ArchitectureExam
//
//  Created by Lumig on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertBlock)(NSInteger index);

@interface AlertView : UIView

+ (void)showInView:(UIView *)superView title:(NSString *)title content:(NSString *)content indexBlock:(AlertBlock)block;
@end
