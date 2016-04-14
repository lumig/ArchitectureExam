//
//  AEExamCellAnswerCell.m
//  ArchitectureExam
//
//  Created by abc on 16/1/15.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEExamCellAnswerCell.h"

@interface AEExamCellAnswerCell ()

@property (weak, nonatomic) IBOutlet UILabel *optionsLabel;

@property (weak, nonatomic) IBOutlet UILabel *optionsContentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *examImage;
@end

@implementation AEExamCellAnswerCell

- (void)awakeFromNib {
    self.optionsLabel.layer.cornerRadius = self.optionsLabel.frame.size.width * 0.5;
    self.optionsLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(NSString *)content{
    _content = content;
    self.optionsContentLabel.text = content;
}

- (void)setExamDetailDic:(NSDictionary *)examDetailDic{
    _examDetailDic = examDetailDic;
    
    self.content = examDetailDic[@"content"];
    self.optionsLabel.text = examDetailDic[@"num"];
}

- (void)setAnswerStr:(NSString *)answerStr{
    _answerStr = answerStr;
    
    if (self.isExamComplete) {
        self.examImage.hidden = NO;
        [self setSelectedImageStyle];
    }else{
        self.examImage.hidden = YES;
        [self setUnSelectedStyle];
    }
}


- (void)setSelectedImageStyle{
    NSRange rRange = [self.rightAnswer rangeOfString:self.examDetailDic[@"num"]];
    if (rRange.length > 0) {
        self.examImage.image = [UIImage imageNamed:@"green.png"];
        [self setColor:AERGB(144, 211, 83) textColor:AERGB(144, 211, 83)];

    }else{
        NSRange range = [self.answerStr rangeOfString:self.examDetailDic[@"num"]];
        if (range.length > 0) {
            self.examImage.image = [UIImage imageNamed:@"red.png"];
            [self setColor:AERGB(207, 78, 81) textColor:AERGB(207, 78, 81)];
        }else{
            self.examImage.hidden = YES;
            [self setColor:AERGB(181, 187, 193) textColor:[UIColor blackColor]];
        }
    }
}


- (void)setColor:(UIColor *)color textColor:(UIColor *)textColor{
    self.optionsLabel.backgroundColor = color;
    self.optionsContentLabel.textColor = textColor;
}


- (void)setUnSelectedStyle{
    NSRange range = [self.answerStr rangeOfString:self.examDetailDic[@"num"]];
    if (range.length > 0) {
        [self setColor:AERGB(112, 166, 223) textColor:AERGB(112, 166, 223)];
    }else{
        [self setColor:AERGB(181, 187, 193) textColor:[UIColor blackColor]];
    }
}

+ (AEExamCellAnswerCell *)getExamAnswerCellWith:(UITableView *)tableView{
    AEExamCellAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AEExamCellAnswerCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AEExamCellAnswerCell" owner:nil options:nil]lastObject];
    }
    return cell;
}


+ (CGFloat)heightFor:(NSDictionary *)detailDic{
    
    NSString *content = detailDic[@"content"];
    
    CGFloat height = [AEUtilsManager stringBoundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 60, MAXFLOAT) font:[UIFont systemFontOfSize:15] text:content].height + 1;
    
    return MAX(44, 14 + height);
}


@end
