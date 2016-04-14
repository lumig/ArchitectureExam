//
//  AECourseContentwCell.m
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AECourseContentwCell.h"
#import "AECourseButton.h"

@interface AECourseContentwCell ()

@property (strong ,nonatomic)UILabel    *courseTitleLabel;
@property (strong ,nonatomic)UILabel    *courseContentLabel;

@end

@implementation AECourseContentwCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.courseTitleLabel];
        [self.contentView addSubview:self.courseContentLabel];
        [self.contentView addSubview:[self getLineViewWith:CGRectMake(0, 89,SCREEN_WIDTH, 1)]];
        
        CGFloat width = SCREEN_WIDTH / 3.0;
        
        for (int i = 0; i < 3; i++) {
            AECourseButton *button = [AECourseButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i * width, 90, width, width);
            button.tag = 10 + i;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [self.contentView addSubview:button];
            
            if (i < 2) {
                [self.contentView addSubview:[self getLineViewWith:CGRectMake(CGRectGetMaxX(button.frame), button.frame.origin.y, 1, button.frame.size.height)]];
            }
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.courseTitleLabel.text = titleStr;
}

- (void)setContentStr:(NSString *)contentStr
{
    _contentStr = contentStr;
    self.courseContentLabel.text = contentStr;
}



- (void)setContentArr:(NSArray *)contentArr
{
    _contentArr = contentArr;
    
    for (int i = 0; i < contentArr.count; i++) {
        AECourseButton *button = (AECourseButton *)[self.contentView viewWithTag:10 + i];
        NSDictionary *dic = contentArr[i];
        
        [button setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[dic objectForKey:@"image"]] forState:UIControlStateNormal];
    }
}

- (void)buttonClick:(AECourseButton *)button
{
    NSInteger tag = button.tag - 10;
    
    [super routerEventWithName:kCourseContentRouterEvent userInfo:@{@"index":self.indexPath,@"tag":[NSNumber numberWithInteger:tag]}];
}


- (UIView *)getLineViewWith:(CGRect)frame
{
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = COLOR_LINGGRAY;
    return lineView;
}


- (UILabel *)courseTitleLabel
{
    if (_courseTitleLabel == nil) {
        _courseTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 8, SCREEN_WIDTH - 40, 33)];
        _courseTitleLabel.font = [UIFont systemFontOfSize:21];
    }
    return _courseTitleLabel;
}

- (UILabel *)courseContentLabel
{
    if (_courseContentLabel == nil) {
        _courseContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 49, SCREEN_WIDTH - 40, 20)];
        _courseContentLabel.font = [UIFont systemFontOfSize:15];
        _courseContentLabel.textColor = COLOR_LINGGRAY;
    }
    return _courseContentLabel;
}

+ (CGFloat)defaultHeight
{
    CGFloat width = SCREEN_WIDTH / 3.0;

    return 90 + width;
}


@end
