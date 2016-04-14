//
//  AEExamConfirmCell.h
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kConfirmRouterEvent @"kConfirmRouterEvent"

@interface AEExamConfirmCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

+ (AEExamConfirmCell *)getExamConfirmWith:(UITableView *)tableView;

+ (CGFloat)defaultHeight;

@end
