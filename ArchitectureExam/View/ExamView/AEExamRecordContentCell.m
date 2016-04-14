//
//  AEExamRecordContentCell.m
//  ArchitectureExam
//
//  Created by abc on 16/1/24.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEExamRecordContentCell.h"

@implementation AEExamRecordContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecordDic:(NSDictionary *)recordDic{
    _recordDic = recordDic;
    
    int elapsedTime = [[recordDic objectForKey:@"elapsedTime"] intValue];
    int score = [[recordDic objectForKey:@"score"]intValue];
    self.timeLabel.text = [recordDic objectForKey:@"DateTime"];
    
    self.nameLabel.text = [[recordDic objectForKey:@"course"]objectForKey:@"name"];
    
    self.spendLabel.text = [AEUtilsManager countDownStringWithSecond:elapsedTime];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d分",score];
    
}

+ (AEExamRecordContentCell *)getRecordContentWithTableView:(UITableView *)tableView{
    AEExamRecordContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AEExamRecordContentCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AEExamRecordContentCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

+ (CGFloat)defaultHeight{
    return 44;
}

@end
