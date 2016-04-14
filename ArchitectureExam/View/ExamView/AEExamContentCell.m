//
//  AEExamContentCell.m
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import "AEExamContentCell.h"

#define kPadding 10

@implementation AEExamContentCell
   - (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (AEExamContentCell *)getExamContentCellWith:(UITableView *)tableView{
    AEExamContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AEExamContentCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AEExamContentCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

+ (CGFloat)heightForContent:(NSString *)content{
    CGFloat height = [AEUtilsManager stringBoundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * kPadding, MAXFLOAT) font:[UIFont systemFontOfSize:15] text:content].height;
    return MAX(60, 41 + height);
}


@end
