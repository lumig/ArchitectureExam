//
//  AELeftViewController.m
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AELeftViewController.h"
#import "AELoginViewController.h"
#import "SettingViewController.h"
#import "MyTestViewController.h"
@interface AELeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *imgArray;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)UIButton *loginBtn;

@end

@implementation AELeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginChanged) name:kUserInfoDefaultCenter object:nil];
    [self loginChanged];
}

- (void)loginChanged
{
    if ([AEUserInfo shareAEUserInfo].userInfo) {
        [self.loginBtn setTitle:[[AEUserInfo shareAEUserInfo].userInfo objectForKey:@"name"] forState:UIControlStateNormal];
        self.loginBtn.enabled = NO;
    }else{
        [self.loginBtn setTitle:@"点击登录" forState:UIControlStateNormal];
        self.loginBtn.enabled = YES;
    }
}

- (void)baseUI
{
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark -- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imgArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID= @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 20, 20)];
        leftImgView.tag = 11;
        [cell addSubview:leftImgView];
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImgView.frame) + 5, 11, 150, 20)];
        nameLable.tag = 12;
        [cell.contentView addSubview:nameLable];
        leftImgView.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
        nameLable.text = self.titleArray[indexPath.row];
        nameLable.font = [UIFont systemFontOfSize:15];
        
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row < _imgArray.count)
    {
        UIImageView *leftImgView = [cell.contentView viewWithTag:11];
        
        if (leftImgView) {
            leftImgView.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
        }
        
        UILabel *nameLable =  [cell.contentView viewWithTag:12];
        
        if (nameLable) {
            nameLable.text = self.titleArray[indexPath.row];
        }
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            if ([AEUserInfo shareAEUserInfo].userInfo) {
                AENavigationController *nav = (AENavigationController *)self.drawer.centerController;
                MyTestViewController *testVC = [[MyTestViewController alloc]init];
                [nav pushViewController:testVC animated:YES];
                [self.drawer close];
            }else{
                [self loginBtnClick];
            }
        }
            break;
        case 1:
        {
            [self shareClick];
        }
            break;
        case 2:
        {
            AENavigationController *nav = (AENavigationController *)self.drawer.centerController;
            SettingViewController *settingVC = [[SettingViewController alloc]init];
            [nav pushViewController:settingVC animated:YES];
            [self.drawer close];
        }
            break;
            
        default:
            break;
    }
}

- (void)shareClick{
    [[AppShareManger shareManager]shareTitle:@"建筑考试宝" content:@"我正在使用建筑考试宝APP学习和测试，快来看看吧！建筑考试宝APP" defaultContent:nil image:nil url:@"http://www.baidu.com" mediaType:SSPublishContentMediaTypeNews];
}


#pragma amrk -- event 
- (UIView *)addHeaderView
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-100, 200)];
    UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    headerImgView.image = [UIImage imageNamed:@"user.png"];
    headerImgView.center = CGPointMake((SCREEN_WIDTH -100)/2.0f, 80);
    [header addSubview:headerImgView];
    
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(headerImgView.frame), CGRectGetMaxY(headerImgView.frame)+10, 80, 30)];
    [self.loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginBtn setTitle:@"点击登录" forState:UIControlStateNormal];
    self.loginBtn.center = CGPointMake((SCREEN_WIDTH -100)/2.0f, 130);
    [self.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIImageView *rightArrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.loginBtn.frame), CGRectGetMinY(self.loginBtn.frame) + 10, 6, 10)];
    rightArrowImgView.image = [UIImage imageNamed:@"分享_03"];
    [header addSubview:rightArrowImgView];
    [header addSubview:self.loginBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, header.frame.size.height - 11, header.frame.size.width, 1)];
    lineView.backgroundColor = COLOR_LINGGRAY;
    [header addSubview:lineView];
    
    return header;
}

- (void)loginBtnClick
{
    [self presentViewController:[AELoginViewController showLoginView] animated:YES completion:nil];
}

#pragma mark -- setter and getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [self addHeaderView];
    }
    return _tableView;
}

- (NSArray *)imgArray
{
    if (!_imgArray) {
        _imgArray = @[@"分享_03-02.png",@"分享_03-03.png",@"分享_03-04.png"];
    }
    return _imgArray;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"我的考试",@"分享推荐",@"系统设置"];
    }
    return _titleArray;
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
