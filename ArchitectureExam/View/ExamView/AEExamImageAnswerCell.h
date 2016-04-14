//
//  AEExamImageAnswerCell.h
//  ArchitectureExam
//
//  Created by abc on 16/1/15.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEExamImageAnswerCell : UITableViewCell

@property (strong,nonatomic)NSDictionary *examDetailDic;
@property (assign,nonatomic)BOOL          isExamComplete;
@property (strong,nonatomic)NSString *uri;

@property (strong,nonatomic)NSString      *answerStr;
@property (strong,nonatomic)NSString      *rightAnswer;

+ (AEExamImageAnswerCell *)getExamAnswerCellWith:(UITableView *)tableView;

+ (CGFloat)defaultHeight;

@end
