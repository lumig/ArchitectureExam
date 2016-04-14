//
//  AEExamCellAnswerCell.h
//  ArchitectureExam
//
//  Created by abc on 16/1/15.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEExamCellAnswerCell : UITableViewCell

@property (strong,nonatomic)NSDictionary *examDetailDic;

@property (strong,nonatomic)NSString *content;

@property (assign,nonatomic)BOOL          isExamComplete;
@property (strong,nonatomic)NSString      *answerStr;
@property (strong,nonatomic)NSString      *rightAnswer;

//@property (assign,nonatomic)BOOL          isSelected;

+ (AEExamCellAnswerCell *)getExamAnswerCellWith:(UITableView *)tableView;

//144 211 83 正确答案
//207 78  81 错误答案
//112 166 223 选中
//181 187 193 未选中
+ (CGFloat)heightFor:(NSDictionary *)detailDic;

@end
