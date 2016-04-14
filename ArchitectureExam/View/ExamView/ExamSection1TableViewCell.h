//
//  ExamSection1TableViewCell.h
//  ArchitectureExam
//
//  Created by Lumig on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExamSection1TableViewCellDelegate <NSObject>

- (void)viewDidClickWithIndex:(NSInteger)index;

@end

@interface ExamSection1TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *scoreView;

@property (weak, nonatomic) IBOutlet UIView *timeView;

@property (nonatomic,weak) id<ExamSection1TableViewCellDelegate> delegate;

@property (strong,nonatomic)NSDictionary *examDic;

@end
