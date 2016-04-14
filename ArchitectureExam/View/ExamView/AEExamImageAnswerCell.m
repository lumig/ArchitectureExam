//
//  AEExamImageAnswerCell.m
//  ArchitectureExam
//
//  Created by abc on 16/1/15.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEExamImageAnswerCell.h"

@interface AEExamImageAnswerCell ()
@property (weak, nonatomic) IBOutlet UILabel *optionsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *optionsImage;
@property (weak, nonatomic) IBOutlet UIImageView *examImage;

@end

@implementation AEExamImageAnswerCell

- (void)awakeFromNib {
    self.optionsLabel.layer.cornerRadius = self.optionsLabel.frame.size.width * 0.5;
    self.optionsLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setExamDetailDic:(NSDictionary *)examDetailDic{
    _examDetailDic = examDetailDic;
    self.uri = examDetailDic[@"uri"];
    self.optionsLabel.text = examDetailDic[@"num"];
}

- (void)setUri:(NSString *)uri{
    _uri = uri;
    
    [self.optionsImage sd_setImageWithURL:[NSURL URLWithString:uri] placeholderImage:[UIImage imageNamed:@"defaultHeight.png"]];
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
//    self.optionsContentLabel.textColor = color;
}


- (void)setUnSelectedStyle{
    NSRange range = [self.answerStr rangeOfString:self.examDetailDic[@"num"]];
    if (range.length > 0) {
        [self setColor:AERGB(112, 166, 223) textColor:AERGB(112, 166, 223)];
    }else{
        [self setColor:AERGB(181, 187, 193) textColor:[UIColor blackColor]];
    }
}
+ (AEExamImageAnswerCell *)getExamAnswerCellWith:(UITableView *)tableView{
    AEExamImageAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AEExamImageAnswerCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AEExamImageAnswerCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

+ (CGFloat)defaultHeight{
    return 44;
}

@end
