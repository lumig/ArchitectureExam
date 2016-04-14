//
//  AEExamConfirmCell.m
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import "AEExamConfirmCell.h"

@implementation AEExamConfirmCell

- (void)awakeFromNib {
    self.submitButton.layer.cornerRadius = 6;
    self.submitButton.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)submitClick:(id)sender {
    [super routerEventWithName:kConfirmRouterEvent userInfo:nil];
}

+ (AEExamConfirmCell *)getExamConfirmWith:(UITableView *)tableView{
    AEExamConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AEExamConfirmCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AEExamConfirmCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

+ (CGFloat)defaultHeight{
    return 44;
}

@end
