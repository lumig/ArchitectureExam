//
//  AEExamImageViewCell.m
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import "AEExamImageViewCell.h"

#define kGap        20
#define kPadding    10

@interface AEExamImageViewCell ()

@property (strong,nonatomic)UIImageView *examImageView;

@end

@implementation AEExamImageViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.examImageView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setUriStr:(NSString *)uriStr{
    _uriStr = uriStr;
    
    [self.examImageView sd_setImageWithURL:[NSURL URLWithString:uriStr] placeholderImage:nil];
}


+ (AEExamImageViewCell *)getExamImageViewCellWith:(UITableView *)tableView{
    AEExamImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AEExamImageViewCellId"];
    if (cell == nil) {
        cell = [[AEExamImageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AEExamImageViewCellId"];
    }
    return cell;
}


- (UIImageView *)examImageView{
    if (_examImageView == nil) {
        _examImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kGap, kPadding, SCREEN_WIDTH - 2 * kGap, (SCREEN_WIDTH - 2 *kGap) * 260 / 640)];
        _examImageView.contentMode = UIViewContentModeCenter;
    }
    return _examImageView;
}

+ (CGFloat)defaultHeight{
    CGFloat height = (SCREEN_WIDTH - 2 *kGap) * 260 / 640;
    return kPadding + height;
}

@end
