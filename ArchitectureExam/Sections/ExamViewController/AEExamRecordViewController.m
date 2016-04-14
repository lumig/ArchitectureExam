//
//  AEExamRecordViewController.m
//  ArchitectureExam
//
//  Created by abc on 16/1/24.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEExamRecordViewController.h"
#import "AERankingTitleCell.h"
#import "AEExamRecordContentCell.h"

@interface AEExamRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UITableView     *tableView;
@property (strong,nonatomic)NSMutableArray  *recordArr;

@end

@implementation AEExamRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本地考试记录";
    
    [self.recordArr addObjectsFromArray:[AEUserInfo shareAEUserInfo].examRecordArr];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.recordArr.count == 0) {
        return 0;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.recordArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AERankingTitleCell *cell = [AERankingTitleCell getRankingCellWithTableView:tableView];
        cell.nameLabel.text = @"本地考试记录";
        return cell;
    }else{
        AEExamRecordContentCell *cell = [AEExamRecordContentCell getRecordContentWithTableView:tableView];
        if (self.recordArr.count > indexPath.row) {
            cell.recordDic = self.recordArr[indexPath.row];
        }
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [AERankingTitleCell defaultHeight];
    }
    return [AEExamRecordContentCell defaultHeight];
}



#pragma mark - getter

- (NSMutableArray *)recordArr{
    if (_recordArr == nil) {
        _recordArr = [[NSMutableArray alloc]init];
    }
    return _recordArr;
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
