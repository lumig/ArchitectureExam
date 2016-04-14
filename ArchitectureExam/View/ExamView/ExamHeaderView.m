//
//  ExamHeaderView.m
//  ArchitectureExam
//
//  Created by Lumig on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "ExamHeaderView.h"

@implementation ExamHeaderView


- (void)fillExamDic:(NSDictionary *)examDic{
    int score = [[examDic objectForKey:@"score"] intValue];
    NSString *name = [[examDic objectForKey:@"course"]objectForKey:@"name"];
    UIImage *image;
    if (score < 60) {
        image = [UIImage imageNamed:@"不及格.png"];
    }else if (score >= 60 && score < 80){
        image = [UIImage imageNamed:@"及格.png"];
    }else{
       image = [UIImage imageNamed:@"优秀.png"];
    }
    
    self.headerImgView.image = image;
    
    self.examTitleLabel.text = name;
    if ([AEUserInfo shareAEUserInfo].userInfo) {
        self.nameLabel.text = [[AEUserInfo shareAEUserInfo].userInfo objectForKey:@"name"];
    }else{
        self.nameLabel.text = @"未登录";
    }
}

+ (CGFloat)defaultHeight{
    return 45 + SCREEN_WIDTH * 480 / 720;
}


@end
