//
//  AEExamImageViewCell.h
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEExamImageViewCell : UITableViewCell

@property (strong,nonatomic)NSString *uriStr;

+ (AEExamImageViewCell *)getExamImageViewCellWith:(UITableView *)tableView;

+ (CGFloat)defaultHeight;


@end
