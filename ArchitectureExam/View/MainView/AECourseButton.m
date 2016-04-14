//
//  AECourseButton.m
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AECourseButton.h"

@implementation AECourseButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect imageRect = self.imageView.frame;
    
    imageRect.size = CGSizeMake(30, 30);
    imageRect.origin.x = (self.frame.size.width - 30) * 0.5;
    imageRect.origin.y = self.frame.size.height * 0.5 - 40;
    
    
    CGRect titleRect = self.titleLabel.frame;
    
    titleRect.origin.x = (self.frame.size.width - titleRect.size.width) * 0.5;
    
    titleRect.origin.y = self.frame.size.height * 0.5 ;
    
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
}

@end
