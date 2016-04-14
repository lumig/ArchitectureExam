//
//  AEScoresRankingViewController.m
//  ArchitectureExam
//
//  Created by abc on 16/1/23.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEScoresRankingViewController.h"
#import "AERankingTitleCell.h"
#import "AERankingContentCell.h"


@interface AEScoresRankingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)UITableView     *tableView;

@property (strong,nonatomic)NSMutableArray  *rowsArr;

@end

@implementation AEScoresRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成绩排名";
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)loadData{
    NSDictionary *dic = [AEUserInfo shareAEUserInfo].examRecordDic;
    
    if (dic) {
        [dic setValue:@{@"id":[[AEUserInfo shareAEUserInfo].userInfo objectForKey:@"id"]} forKey:@"student"];
    }
    
    [[AENetworkingManager shareAENetworkingManager]updateMockExamRank:self.view courseId:self.courseModel.courseId mockExamResult:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            [self parsingWithResponseObj:responseObject];
            [[AEUserInfo shareAEUserInfo] removeLastExamRecord];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}


- (void)parsingWithResponseObj:(id)obj{
    NSArray *rows = [obj objectForKey:@"rows"];
    for (NSDictionary *dic in rows) {
        [self.rowsArr addObject:dic];
    }
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.rowsArr.count == 0) {
        return 0;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.rowsArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AERankingTitleCell *cell = [AERankingTitleCell getRankingCellWithTableView:tableView];
        cell.nameLabel.text = @"成绩排名";
        return cell;
    }else{
        AERankingContentCell *cell = [AERankingContentCell getRankingContentCellWithTableView:tableView];
        
        if (self.rowsArr.count > indexPath.row) {
            NSDictionary *dic = self.rowsArr[indexPath.row];
            
            cell.rankingNumLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
            cell.rankingNameLabel.text = [[dic objectForKey:@"student"] objectForKey:@"name"];
            cell.timeLabel.text = [AEUtilsManager countDownStringWithSecond:[[dic objectForKey:@"elapsedTime"] intValue]];
            cell.scoreLabel.text = [NSString stringWithFormat:@"%@分",dic[@"score"]];
        }
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [AERankingTitleCell defaultHeight];
    }
    return [AERankingContentCell defaultHeight];
}

#pragma mark - getter

- (NSMutableArray *)rowsArr{
    if (_rowsArr == nil) {
        _rowsArr = [[NSMutableArray alloc]init];
    }
    return _rowsArr;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
