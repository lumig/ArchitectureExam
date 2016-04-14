//
//  AEMainViewController.m
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AEMainViewController.h"
#import "AEExamViewController.h"
#import "AECourseTitleCell.h"
#import "AECourseContentwCell.h"

#import "AECourseModel.h"
#import "AEChooseCourseView.h"
#import "SimulationViewController.h"

#import "AEErrorViewController.h"
#import "AECollectionViewController.h"
#import "AESimulateExamViewController.h"
#import "AEScoresRankingViewController.h"
#import "AEExamRecordViewController.h"


@interface AEMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)UIButton *titleItembutton;

@property (strong,nonatomic)NSMutableArray *courseArr;

@property (strong,nonatomic)AECourseModel  *currentModel;

@property (strong,nonatomic)UITableView    *tableView;

@property (strong,nonatomic)AEChooseCourseView *courseView;

@end

@implementation AEMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addleftBtn];
    self.navigationItem.titleView = self.titleItembutton;
    [self setItemWithTitle:@"课程选择"];
    [self.view addSubview:self.tableView];
    //加载课程
    [self getWithData];
}

- (void)getWithData{
    
    [[AERequestManger shareAERequestManger]getAllCourse:self.view success:^(id obj) {
        NSArray *array = [obj objectForKey:@"allCourse"];
        
        for (int i = 0; i < array.count; i++) {
            [self.courseArr addObject:[AECourseModel fetchWithDic:array[i]]];
        }
        
        NSDictionary *cDic = [obj objectForKey:@"currentCourse"];
        
        if (cDic) {
            self.currentModel = [AECourseModel fetchWithDic:cDic];
        }
        else
        {
            if (array.count > 0) {
                self.currentModel = [AECourseModel fetchWithDic:array[0]];
            }
        }
    }];
}


- (void)setCurrentModel:(AECourseModel *)currentModel{
    _currentModel = currentModel;
    [self setItemWithTitle:currentModel.name];
}


- (void)addleftBtn
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 25, 25);
    [backButton setImage:[UIImage imageNamed:@"主界面_用户.png"] forState:UIControlStateNormal];
    backButton.highlighted = NO;
    [backButton addTarget:self action:@selector(unfoldDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
}

- (void)unfoldDidClick
{
    AENavigationController *aeNav = (AENavigationController *)self.navigationController;
    
    if (aeNav.drawer.drawerState == LDrawerStateClose) {
        [aeNav.drawer open];
    }else if (aeNav.drawer.drawerState == LDrawerStateOpen) {
        [aeNav.drawer close];
    }
}


- (void)titleItemDidClick
{
    if (self.courseView.isShowStation) {
        [self.courseView closeView];
    }else{
        self.courseView = [[AEChooseCourseView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
        self.courseView.courseArr = self.courseArr;
        [self.courseView showInView:self.view];
        
        __block AEMainViewController *pThis = self;
        
        self.courseView.courseBlock = ^(AECourseModel *model){
            pThis.currentModel = model;
        };
    }
    
}


- (void)setItemWithTitle:(NSString *)title
{
    [self.titleItembutton setImage:[UIImage imageNamed:@"主界面_下展开.png"] forState:UIControlStateNormal];
    [self.titleItembutton setTitle:title forState:UIControlStateNormal];
    [self.titleItembutton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.titleItembutton.imageView.frame.size.width, 0, self.titleItembutton.imageView.frame.size.width)];
    [self.titleItembutton setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleItembutton.titleLabel.frame.size.width, 0, -self.titleItembutton.titleLabel.frame.size.width)];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AECourseTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AECourseTitleCell"];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"AECourseTitleCell" owner:self options:nil]lastObject];
        }

        return cell;
    }
    
    
    AECourseContentwCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AECourseContentwCell"];
    
    if (cell == nil) {
        cell = [[AECourseContentwCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AECourseContentwCell"];
    }
    
    
    if (indexPath.section == 1) {
        cell.titleStr = @"章节联系";
        cell.contentStr = @"按章节练习,试题覆盖所有考试知识点";
        cell.contentArr = @[@{@"image":@"主界面_14.png",@"name":@"我的收藏"},@{@"image":@"主界面_14-06.png",@"name":@"顺序练习"},@{@"image":@"主界面_14-07.png",@"name":@"错题攻克"}];
    }else{
        cell.titleStr = @"模拟考试";
        cell.contentStr = @"全真模拟考试，50道题30分钟内完成测试";
        cell.contentArr = @[@{@"image":@"主界面_14-08.png",@"name":@"开始考试"},@{@"image":@"主界面_14-09.png",@"name":@"考试记录"},@{@"image":@"主界面_14-10.png",@"name":@"成绩排名"}];
    }
    
    cell.indexPath = indexPath;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [AECourseTitleCell defaultHeight];
    }
    
    return [AECourseContentwCell defaultHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        return 10;
    }
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    if ([eventName isEqualToString:kCourseContentRouterEvent]) {
        NSIndexPath *indexPath = [userInfo objectForKey:@"index"];
        NSNumber    *tag = [userInfo objectForKey:@"tag"];
        [self switchIndexPath:indexPath andTag:tag.integerValue];
    }
}

- (void)switchIndexPath:(NSIndexPath *)indexPath andTag:(NSInteger)tag{
    switch (indexPath.section) {
        case 1:
        {
            switch (tag) {
                case 0:
                {
                    AECollectionViewController *collectionVC = [[AECollectionViewController alloc]init];
                    [self.navigationController pushViewController:collectionVC animated:YES];
                }
                    break;
                case 1:
                {
                    AEExamViewController *examVC = [[AEExamViewController alloc]init];
                    [self.navigationController pushViewController:examVC animated:YES];
                    examVC.courseModel = self.currentModel;
                }
                    break;
                case 2:
                {
                    AEErrorViewController *errorVC = [[AEErrorViewController alloc]init];
                    [self.navigationController pushViewController:errorVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (tag) {
                case 0:
                {
                    SimulationViewController *simulationVC = [[SimulationViewController alloc] init];
                    [self.navigationController pushViewController:simulationVC animated:YES];
                    simulationVC.courseModel = self.currentModel;
                }
                    break;
                case 1:
                {
                    AEExamRecordViewController *recordVC = [[AEExamRecordViewController alloc] init];
                    [self.navigationController pushViewController:recordVC animated:YES];
                }
                    break;
                case 2:
                {
                    if ([AEUserInfo shareAEUserInfo].userInfo) {
                        AEScoresRankingViewController *rankingVC = [[AEScoresRankingViewController alloc]init];
                        [self.navigationController pushViewController:rankingVC animated:YES];
                        rankingVC.courseModel = self.currentModel;
                    }else{
                        [self presentViewController:[AELoginViewController showLoginView] animated:YES completion:nil];
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - getter

- (NSMutableArray *)courseArr{
    if (_courseArr == nil) {
        _courseArr = [[NSMutableArray alloc]init];
    }
    return _courseArr;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}


- (UIButton *)titleItembutton
{
    if (_titleItembutton == nil) {
        _titleItembutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleItembutton.highlighted = NO;
        _titleItembutton.frame = CGRectMake(0, 0, SCREEN_WIDTH - 150, 30);
        [_titleItembutton addTarget:self action:@selector(titleItemDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _titleItembutton;
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
