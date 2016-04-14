//
//  ExamSection2TableViewCell.m
//  ArchitectureExam
//
//  Created by Lumig on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "ExamSection2TableViewCell.h"
#import "AESection2Btn.h"

@interface ExamSection2TableViewCell()

@property (nonatomic,strong)NSArray *dataArray;
@end

@implementation ExamSection2TableViewCell

- (void)awakeFromNib {
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1.0f];
        [self.contentView addSubview:lineView];
        CGFloat width = SCREEN_WIDTH /4;
        for (int i = 0; i < 4; i ++) {
            AESection2Btn *btn = [AESection2Btn buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i * width, 20, width, width);
            btn.tag = 10 +i;
           [ btn setTitle:self.dataArray[i][@"btnName"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:self.dataArray[i][@"btnImg"] ]forState:UIControlStateNormal];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;

            btn.highlighted = NO;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            
        }
    }
    return self;
}

- (void)btnDidClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(examSection2BtnDidClickWithIndex:)]) {
        
        [self.delegate examSection2BtnDidClickWithIndex:btn.tag - 10];
    }
}

+ (CGFloat)cellHeight
{
    return SCREEN_WIDTH/4 + 20;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@{@"btnName":@"求鞭策",@"btnImg":@"模拟考试_13.png"},@{@"btnName":@"查看考试",@"btnImg":@"模拟考试_13-04.png"},@{@"btnName":@"只看错题",@"btnImg":@"模拟考试_13-05.png"},@{@"btnName":@"排行榜",@"btnImg":@"模拟考试_13-06.png"}];
    }
    
    return _dataArray;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
