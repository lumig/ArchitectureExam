//
//  AESection2Btn.m
//  ArchitectureExam
//
//  Created by Lumig on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AESection2Btn.h"

@implementation AESection2Btn


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect imageRect = self.imageView.frame;
    
    imageRect.size = CGSizeMake(40, 40);
    imageRect.origin.x = (self.frame.size.width - 40) * 0.5;
    imageRect.origin.y = self.frame.size.height * 0.5 - 50;
    
    
    CGRect titleRect = self.titleLabel.frame;
    
    titleRect.origin.x = 0;
    
    titleRect.origin.y = self.frame.size.height * 0.5 ;
    titleRect.size.width = self.frame.size.width;
    
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
