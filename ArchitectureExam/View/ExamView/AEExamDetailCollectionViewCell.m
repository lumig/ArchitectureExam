//
//  AEExamDetailCollectionViewCell.m
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import "AEExamDetailCollectionViewCell.h"

#import "AEExamContentCell.h"
#import "AEExamImageViewCell.h"
#import "AEExamAnalysisTableViewCell.h"
#import "AEExamConfirmCell.h"
#import "AEExamImageAnswerCell.h"
#import "AEExamCellAnswerCell.h"

#define kQeustionExamComplete @"qeustionExamComplete"


@interface AEExamDetailCollectionViewCell ()<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) UITableView   *tableView;
@property (assign,nonatomic)  BOOL          isExamComplete;
@property (strong,nonatomic)  NSString      *questionType;//SC 单选 MC多选 TFNG判断

@property (strong,nonatomic) NSMutableString       *selectedAnswer;

@end

@implementation AEExamDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.tableView];
    }
    return self;
}

- (void)setQeustionDic:(NSMutableDictionary *)qeustionDic{
    _qeustionDic = qeustionDic;
    self.examDic = nil;
    self.questionType = qeustionDic[@"questionType"];
    self.isExamComplete = [qeustionDic[kQeustionExamComplete] boolValue];
    
    NSString *answer = qeustionDic[kQeustionSelectedAnswer];
    
    if (answer == nil) {
        answer = @"";
    }
    [self.selectedAnswer setString:answer];
    [self loadQeustion];
}

- (void)loadQeustion{
    [[AERequestManger shareAERequestManger]getQeustionDetail:[AEUtilsManager getSystemWindow] questionId:self.qeustionDic[@"questionId"] success:^(id obj) {
        self.examDic = obj;
    }];
}


- (void)setExamDic:(NSDictionary *)examDic{
    _examDic = examDic;
    [self.tableView reloadData];
}
//1、题目 2、图片 3、选项 4、确定 5、分析
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.examDic) {
        return 5;
    }
    return 0;
}
//SC 单选 MC多选 TFNG判断
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
        {
            if ([self.examDic[@"uri"] length] > 0) {
                return 1;
            }
            return 0;
        }
            break;
        case 2:
        {
            NSArray *arr = self.examDic[@"answerItems"];
            return arr.count;
        }
            break;
        case 3:
        {
            if ([self.questionType isEqualToString:@"MC"]) {
                return 1;
            }
        }
            break;
        case 4:
        {
            if (self.isExamComplete) {
                return 1;
            }
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [self contentTableView:tableView cellForRowAtIndexPath:indexPath];
            break;
        case 1:
            return [self imageTableView:tableView cellForRowAtIndexPath:indexPath];
            break;
        case 2:
            return [self answerTableView:tableView cellForRowAtIndexPath:indexPath];
            break;
        case 3:
            return [self confirmTableView:tableView cellForRowAtIndexPath:indexPath];
            break;
        case 4:
            return [self analysisTableView:tableView cellForRowAtIndexPath:indexPath];
            break;
            
        default:
            break;
    }
    return [self defaultTableView:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return [AEExamContentCell heightForContent:self.examDic[@"content"]];
            break;
        case 1:
            return [AEExamImageViewCell defaultHeight];
            break;
        case 2:
        {
            NSArray *arr = self.examDic[@"answerItems"];
            
            if (arr.count > indexPath.row) {
                NSDictionary *dic = arr[indexPath.row];
                if ([dic[@"uri"] length] > 0) {
                    return [AEExamImageAnswerCell defaultHeight];
                }else{
                    return [AEExamCellAnswerCell heightFor:dic];
                }
            }
        }
            break;
        case 3:
        {
            return [AEExamConfirmCell defaultHeight];
        }
            break;
        case 4:
            return [AEExamAnalysisTableViewCell heightForDic:self.examDic];
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (self.isExamComplete) {
            return;
        }
        NSArray *arr = self.examDic[@"answerItems"];
        if (arr.count > indexPath.row) {
            NSDictionary *dic = arr[indexPath.row];
            NSString *num = dic[@"num"];
            NSRange range = [self.selectedAnswer rangeOfString:num];
            
            if (range.length > 0) {
                [self.selectedAnswer replaceCharactersInRange:range withString:num];
            }else{
                [self.selectedAnswer appendString:num];
            }
            
            if (![self.questionType isEqualToString:@"MC"]) {
                [self saveQeustion];
            }
            [self.tableView reloadData];
        }
    }
}

- (void)saveQeustion{
    [self.qeustionDic setValue:self.selectedAnswer forKey:kQeustionSelectedAnswer];
    self.isExamComplete = YES;
    [self.qeustionDic setValue:@1 forKey:kQeustionExamComplete];
    
    BOOL flag = NO;
    
    NSString *rightAnswer = self.examDic[@"rightAnswer"];
    if (self.selectedAnswer.length == [rightAnswer length]) {
        NSInteger count = self.selectedAnswer.length;
        
        int i = 0;
        for (i = 0; i < count; i++) {
            NSString *num = [self.selectedAnswer substringWithRange:NSMakeRange(i, 1)];
            NSRange range = [rightAnswer rangeOfString:num];
            if (range.length <= 0) {
                break;
            }
        }
        if (i == count) {
            flag = YES;
        }
    }
    
    [self.qeustionDic setValue:[NSNumber numberWithBool:flag] forKey:@"qeustionExamAnswer"];
    
    [self.tableView reloadData];
    
    if (!flag) {
        [[AEUserInfo shareAEUserInfo] addErrorQestionDic:self.qeustionDic];
    }
    
    if ([self.delegate respondsToSelector:@selector(collectionViewWithPath:indexPath:)]) {
        [self.delegate collectionViewWithPath:self.qeustionDic[@"savePath"] indexPath:self.indexPath];
    }
//    if ([self.delegate respondsToSelector:@selector(collectionViewWithQeustion:indexPath:)]) {
//        [self.delegate collectionViewWithQeustion:self.qeustionDic indexPath:self.indexPath];
//    }
    
}


- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    if ([eventName isEqualToString:kConfirmRouterEvent]) {
        [self saveQeustion];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        return 15;
    }
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

- (UITableViewCell *)defaultTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCellId"];
    return cell;
}

- (UITableViewCell *)contentTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AEExamContentCell *cell = [AEExamContentCell getExamContentCellWith:tableView];
    
    cell.contentLabel.text = self.examDic[@"content"];
    
    return cell;
}

- (UITableViewCell *)imageTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AEExamImageViewCell *cell = [AEExamImageViewCell getExamImageViewCellWith:tableView];
    
    cell.uriStr = self.examDic[@"uri"];
    
    return cell;
}


- (UITableViewCell *)answerTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = self.examDic[@"answerItems"];
    
    if (arr.count > indexPath.row) {
        NSDictionary *dic = arr[indexPath.row];
        
        if ([dic[@"uri"] length] > 0) {
            AEExamImageAnswerCell *cell = [AEExamImageAnswerCell getExamAnswerCellWith:tableView];
            cell.examDetailDic = dic;
            cell.rightAnswer = self.examDic[@"rightAnswer"];
            cell.isExamComplete = self.isExamComplete;
            cell.answerStr = self.selectedAnswer;
            
            if (indexPath.row % 2 == 0) {
                cell.backgroundColor = AERGB(248, 248, 248);
            }else{
                cell.backgroundColor = [UIColor whiteColor];
            }
            
            return cell;
        }else{
            AEExamCellAnswerCell *cell = [AEExamCellAnswerCell getExamAnswerCellWith:tableView];
            cell.examDetailDic = dic;
            cell.rightAnswer = self.examDic[@"rightAnswer"];
            cell.isExamComplete = self.isExamComplete;
            cell.answerStr = self.selectedAnswer;
            
            if (indexPath.row % 2 == 0) {
                cell.backgroundColor = AERGB(248, 248, 248);
            }else{
                cell.backgroundColor = [UIColor whiteColor];
            }
            return cell;
        }
    }
    
    return [self defaultTableView:tableView cellForRowAtIndexPath:indexPath];;
}

- (UITableViewCell *)confirmTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AEExamConfirmCell *cell = [AEExamConfirmCell getExamConfirmWith:tableView];
    
    return cell;
}

- (UITableViewCell *)analysisTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AEExamAnalysisTableViewCell *cell = [AEExamAnalysisTableViewCell getExamAnalysisTableViewCell:tableView];
    
    cell.examDic = self.examDic;
    
    return cell;
}

#pragma mark - 分享
- (void)startShare{
    NSArray *arr = self.examDic[@"answerItems"];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:arr.count - 1 inSection:2];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell) {
        CGFloat height = CGRectGetMaxY(cell.frame);
        CGSize size = CGSizeMake(SCREEN_WIDTH, height);
        
        AppShareManger *mageager = [AppShareManger shareManager];
        NSData *data = [mageager screenShots:self.tableView size:size];
        [mageager shareTitle:@"建筑考试宝" content:nil defaultContent:nil image:data url:nil mediaType:SSPublishContentMediaTypeImage];
    }
}


#pragma mark - getter

- (NSMutableString *)selectedAnswer{
    if (_selectedAnswer == nil) {
        _selectedAnswer = [[NSMutableString alloc]init];
    }
    return _selectedAnswer;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
    }
    return _tableView;
}


@end
