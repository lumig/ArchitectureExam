//
//  ExamSection1TableViewCell.m
//  ArchitectureExam
//
//  Created by Lumig on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "ExamSection1TableViewCell.h"

@implementation ExamSection1TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    UITapGestureRecognizer *tap1= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scoreViewDidClick)];
    _scoreView.tag =10;
    [_scoreView addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer *tap2= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeViewDidClick)];
    _timeView.tag =20;
    [_timeView addGestureRecognizer:tap2];
    
}

- (void)setExamDic:(NSDictionary *)examDic{
    _examDic = examDic;
    
    int score = [[examDic objectForKey:@"score"] intValue];
    int time = [[examDic objectForKey:@"elapsedTime"] intValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    self.timeLabel.text = [NSString stringWithFormat:@"%d",time / 60];
}

- (void)scoreViewDidClick
{
    if ([self.delegate respondsToSelector:@selector(viewDidClickWithIndex:)]) {
        [self.delegate viewDidClickWithIndex:10];
    }
}

- (void)timeViewDidClick
{
    if ([self.delegate respondsToSelector:@selector(viewDidClickWithIndex:)]) {
        [self.delegate viewDidClickWithIndex:20];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
