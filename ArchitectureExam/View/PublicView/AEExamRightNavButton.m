//
//  AEExamRightNavButton.m
//  ArchitectureExam
//
//  Created by abc on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEExamRightNavButton.h"

@implementation AEExamRightNavButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake((self.frame.size.width - 20) * 0.5, 0, 20, 20);
    self.titleLabel.frame = CGRectMake(0, 20, self.frame.size.width, 20);
}

@end
