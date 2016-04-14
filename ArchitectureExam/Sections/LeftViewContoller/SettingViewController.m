//
//  SettingViewController.m
//  ArchitectureExam
//
//  Created by Lumig on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *imgArray;
@property(nonatomic,strong)NSArray *titleArray;


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseUI];
}

- (void)baseUI
{
    self.title = @"系统设置";
    [self.view addSubview:self.tableView];
    
}

#pragma mark -- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 3;
    }
    else
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
          return  [self setting1TableView:tableView cellForRowAtIndexPath:indexPath];
        }
            break;
        case 1:
        {
            return [self setting2TableView:tableView cellForRowAtIndexPath:indexPath];
        }
            break;
        case 2:
        {
            return [self quitTableView:tableView cellForRowAtIndexPath:indexPath];
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
        {
            [self showActionView];
        }
            break;
            
        default:
            break;
    }
}


- (void)showActionView{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"确定退出?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [[AEUserInfo shareAEUserInfo] removeLocationUserInfo];
    }
}


- (UITableViewCell *)setting1TableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1= @"cellID1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID1];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 20, 20)];
        imgView.tag =11;
        [cell.contentView addSubview:imgView];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+5, 11, 150, 20)];
        nameLabel.tag = 12;
        nameLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:nameLabel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;

    }
    if (indexPath.row < self.imgArray.count) {
        UIImageView *imgView = [cell.contentView viewWithTag:11];
        if (imgView) {
            imgView.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
        }
        
        UILabel *nameLabel = [cell.contentView viewWithTag:12];
        if (nameLabel) {
            nameLabel.text = self.titleArray[indexPath.row];
        }
    }
    
    return cell;
}

- (UITableViewCell *)setting2TableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID2= @"cellID2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID2];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 20, 20)];
        imgView.tag =13;
        [cell.contentView addSubview:imgView];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+5, 11, 150, 20)];;
        nameLabel.tag = 14;
        nameLabel.font = [UIFont systemFontOfSize:15];

        [cell.contentView addSubview:nameLabel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;

    }
        UIImageView *imgView = [cell.contentView viewWithTag:13];
        if (imgView) {
            imgView.image = [UIImage imageNamed:@"系统设置_03-04.png"];
        }
        
        UILabel *nameLabel = [cell.contentView viewWithTag:14];
        if (nameLabel) {
            nameLabel.text = [NSString stringWithFormat:@"推荐应用给好友"];
        }
    
    
    return cell;
}

- (UITableViewCell *)quitTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID3 = @"cellID3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID3];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 200, 20)];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.center = CGPointMake(SCREEN_WIDTH/2.0f, 20);
        nameLabel.textColor = [UIColor redColor];
        nameLabel.tag = 15;
        nameLabel.font = [UIFont systemFontOfSize:15];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:nameLabel];
    }
    
    UILabel *nameLabel = [cell.contentView viewWithTag:15];
    nameLabel.text = @"退出登录";
    
    return cell;
}


#pragma mark -- setter and getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) ];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)imgArray
{
    if (!_imgArray) {
        _imgArray =@[@"系统设置_03.png",@"系统设置_03-02.png",@"系统设置_03-03.png"];
    }
    return _imgArray;
}
- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"报考地区",@"我的题库",@"上报新题"];
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
