//
//  AEPresentCollectionViewCell.m
//  ArchitectureExam
//
//  Created by abc on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEPresentCollectionViewCell.h"

@interface AEPresentCollectionViewCell ()

@property (strong,nonatomic)UILabel *textLabel;

@end

@implementation AEPresentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.textLabel];
        self.layer.cornerRadius = frame.size.width * 0.5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth   = 1;
    }
    return self;
}
          //子
//error 210 112 113   237 215 215
//right 150 220 91    224 246 217
//186 186 186


- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    self.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
    
    if (self.isExamComplete) {
        if (self.isRightAnswer) {
            [self setTextColor:AERGB(150, 220, 91) backColor:AERGB(224, 246, 217)];

        }else{
            [self setTextColor:AERGB(210, 112, 113) backColor:AERGB(237, 215, 215)];
        }
    }else{
        [self setTextColor:AERGB(186, 186, 186) backColor:[UIColor whiteColor]];
    }
}

- (void)setTextColor:(UIColor *)textColor backColor:(UIColor *)color{
    self.layer.borderColor = textColor.CGColor;
    self.textLabel.textColor = textColor;
    self.backgroundColor = color;
}



- (UILabel *)textLabel{
    if (_textLabel == nil){
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.contentView.frame.size.height - 20) * 0.5, self.contentView.frame.size.width, 20)];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
