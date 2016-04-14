//
//  ScoreViewController.m
//  ArchitectureExam
//
//  Created by Lumig on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "ScoreViewController.h"
#import "ExamHeaderView.h"
#import "ExamSection1TableViewCell.h"
#import "ExamSection2TableViewCell.h"

#import "AEScoresRankingViewController.h"
#import "AEErrorViewController.h"
#import "AEExamReviewViewController.h"

@interface ScoreViewController ()<UITableViewDataSource,UITableViewDelegate,ExamSection1TableViewCellDelegate,ExamSection2TableViewCell>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong)ExamHeaderView *examHeaderView;

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self subviewUI];
}

- (void)subviewUI
{
    self.title = @"考试成绩";
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0F green:240/255.0F blue:240/255.0F alpha:1.0F];
    [self addRightBtn];
    [self.view addSubview:self.tableView];
    [self.examHeaderView fillExamDic:self.scoreDic];
}



- (void)addRightBtn
{
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 25, 25);
    [shareButton setImage:[UIImage imageNamed:@"系统设置_03-04.png"] forState:UIControlStateNormal];
    shareButton.highlighted = NO;
    [shareButton addTarget:self action:@selector(shareBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
}

- (void)shareBtnDidClick
{
    int score = [[self.scoreDic objectForKey:@"score"] intValue];
    int time = [[self.scoreDic objectForKey:@"elapsedTime"] intValue];
    NSString *name = [[self.scoreDic objectForKey:@"course"]objectForKey:@"name"];
    NSString *str = [NSString stringWithFormat:@"我在建筑考试宝APP的(%@)模拟考试中得%d分 用时%@!",name,score,[AEUtilsManager countDownStringWithSecond:time]];
    
    [[AppShareManger shareManager]shareTitle:@"建筑考试宝" content:str defaultContent:nil image:nil url:@"http://www.baidu.com" mediaType:SSPublishContentMediaTypeNews];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
       return  [self examSection1TableView:tableView cellForRowAtIndexPath:indexPath];
    }else
    {
        return [self examSection2TableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else{
        return [ExamSection2TableViewCell cellHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UITableViewCell *)examSection1TableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    ExamSection1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ExamSection1TableViewCell" owner:self options:nil] lastObject];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.examDic = self.scoreDic;
    
    return cell;
    
}

- (UITableViewCell *)examSection2TableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    ExamSection2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[ExamSection2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

- (void)viewDidClickWithIndex:(NSInteger)index
{
    if (index ==10) {
        NSLog(@"10");
    }
    else
    {
        NSLog(@"20");
    }
}

- (void)examSection2BtnDidClickWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [self shareBtnDidClick];
        }
            break;
        case 1:
        {
            AEExamReviewViewController *reviewVC = [[AEExamReviewViewController alloc]init];
            [self.navigationController pushViewController:reviewVC animated:YES];
            reviewVC.qeustionArr = self.qeustionArr;
        }
            break;
        case 2:
        {
            AEErrorViewController *errorVC = [[AEErrorViewController alloc]init];
            [self.navigationController pushViewController:errorVC animated:YES];
        }
            break;
        case 3:
        {
            if ([AEUserInfo shareAEUserInfo].userInfo) {
                AEScoresRankingViewController *rankingVC = [[AEScoresRankingViewController alloc]init];
                [self.navigationController pushViewController:rankingVC animated:YES];
            }else{
                [self presentViewController:[AELoginViewController showLoginView] animated:YES completion:nil];
            }
            
        }
            break;
            
        default:
            break;
    }
}


- (void)backClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - getter

- (ExamHeaderView *)examHeaderView
{
    if (_examHeaderView == nil) {
        _examHeaderView =[[[NSBundle mainBundle] loadNibNamed:@"ExamHeaderView" owner:self options:nil] lastObject];
        _examHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [ExamHeaderView defaultHeight]);
    }
    return _examHeaderView;
}



- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.examHeaderView;
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
