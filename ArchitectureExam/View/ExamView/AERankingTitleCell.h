//
//  AERankingTitleCell.h
//  ArchitectureExam
//
//  Created by abc on 16/1/23.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AERankingTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *nameImageView;


+ (AERankingTitleCell *)getRankingCellWithTableView:(UITableView *)tableView;

+ (CGFloat)defaultHeight;

@end
