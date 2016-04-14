//
//  AEExamAnalysisTableViewCell.h
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEExamAnalysisTableViewCell : UITableViewCell

@property (strong,nonatomic)NSDictionary *examDic;

+ (AEExamAnalysisTableViewCell *)getExamAnalysisTableViewCell:(UITableView *)tableView;

+ (CGFloat)heightForDic:(NSDictionary *)dic;

@end
