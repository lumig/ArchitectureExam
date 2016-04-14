//
//  AEExamAnalysisTableViewCell.m
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import "AEExamAnalysisTableViewCell.h"
#import "AEStarView.h"

#define kGap        20
#define kPadding    10

@interface AEExamAnalysisTableViewCell ()

@property (weak, nonatomic) IBOutlet AEStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *analysisLabel;

@end

@implementation AEExamAnalysisTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setExamDic:(NSDictionary *)examDic{
    _examDic = examDic;
    self.analysisLabel.text = examDic[@"questionAnalysis"];
    self.starView.levelStar = [examDic[@"difficultyLevel"] integerValue];
    
}

+ (AEExamAnalysisTableViewCell *)getExamAnalysisTableViewCell:(UITableView *)tableView{
    AEExamAnalysisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AEExamAnalysisTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AEExamAnalysisTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

+ (CGFloat)heightForDic:(NSDictionary *)dic{
    
    NSString *content = dic[@"questionAnalysis"];
    
    CGFloat height = [AEUtilsManager stringBoundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * kPadding, MAXFLOAT) font:[UIFont systemFontOfSize:15] text:content].height;
    
    return MAX(40, 45 + height);
}

@end
