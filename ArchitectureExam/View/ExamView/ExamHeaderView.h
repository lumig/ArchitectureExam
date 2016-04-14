//
//  ExamHeaderView.h
//  ArchitectureExam
//
//  Created by Lumig on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *examTitleLabel;

- (void)fillExamDic:(NSDictionary *)examDic;

+ (CGFloat)defaultHeight;

@end
