//
//  AERankingContentCell.h
//  ArchitectureExam
//
//  Created by abc on 16/1/23.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AERankingContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankingNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankingNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

+ (AERankingContentCell *)getRankingContentCellWithTableView:(UITableView *)tableView;

+ (CGFloat)defaultHeight;

@end
