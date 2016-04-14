//
//  AERankingContentCell.m
//  ArchitectureExam
//
//  Created by abc on 16/1/23.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AERankingContentCell.h"

@implementation AERankingContentCell

- (void)awakeFromNib {
    self.rankingNumLabel.layer.cornerRadius = self.rankingNumLabel.frame.size.width * 0.5;
    self.rankingNumLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (AERankingContentCell *)getRankingContentCellWithTableView:(UITableView *)tableView{
    AERankingContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AERankingContentCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AERankingContentCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

+ (CGFloat)defaultHeight{
    return 44;
}

@end
