//
//  ExamSection2TableViewCell.h
//  ArchitectureExam
//
//  Created by Lumig on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExamSection2TableViewCell <NSObject>

//150219

- (void)examSection2BtnDidClickWithIndex:(NSInteger)index;

@end

@interface ExamSection2TableViewCell : UITableViewCell

@property (nonatomic,weak) id<ExamSection2TableViewCell> delegate;

+ (CGFloat)cellHeight;


@end
