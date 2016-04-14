//
//  AERankingTitleCell.m
//  ArchitectureExam
//
//  Created by abc on 16/1/23.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AERankingTitleCell.h"

@implementation AERankingTitleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (AERankingTitleCell *)getRankingCellWithTableView:(UITableView *)tableView{
    AERankingTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AERankingTitleCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AERankingTitleCell" owner:nil options:nil]lastObject];
    }
    return cell;
}


+ (CGFloat)defaultHeight{
    return 50;
}

@end
