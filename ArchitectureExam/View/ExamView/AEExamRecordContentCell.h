//
//  AEExamRecordContentCell.h
//  ArchitectureExam
//
//  Created by abc on 16/1/24.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEExamRecordContentCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *spendLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong,nonatomic)NSDictionary *recordDic;

+ (AEExamRecordContentCell *)getRecordContentWithTableView:(UITableView *)tableView;

+ (CGFloat)defaultHeight;

@end
