//
//  AEStarView.m
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import "AEStarView.h"

@implementation AEStarView

- (void)setLevelStar:(NSInteger)levelStar{
    _levelStar = levelStar;
    [self setUp];
}

- (void)setUp{
    while (self.subviews.count > 0) {
        [self.subviews.lastObject removeFromSuperview];
    }
    [self addImageView];
}

- (void)addImageView{
    for (int i = 0; i < self.levelStar; i++) {
        CGRect frame = CGRectMake(i * 15, (self.frame.size.height - 15) * 0.5, 15, 15);
        [self createImageWithFrame:frame];
    }
}

- (void)createImageWithFrame:(CGRect)frame{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:@"章节练习界面_难度星.png"];
    [self addSubview:imageView];
}

@end
