//
//  AEExamContentCell.h
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEExamContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

+ (AEExamContentCell *)getExamContentCellWith:(UITableView *)tableView;

+ (CGFloat)heightForContent:(NSString *)content;

@end
