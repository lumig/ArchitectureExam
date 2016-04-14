//
//  MyTestViewController.m
//  ArchitectureExam
//
//  Created by Lumig on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "MyTestViewController.h"

@interface MyTestViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *hintArray;
@property (nonatomic,strong)NSMutableArray *recordArray;


@end

@implementation MyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseUI];
}

- (void)baseUI
{
    self.title = @"我的考试";
    [self dataRequest];
    [self.view addSubview:self.tableView];
}

- (void)dataRequest
{
    [[AENetworkingManager shareAENetworkingManager] queryFormalExaminations:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSArray arrayWithObject:responseObject[@"upcomingExaminations"][0]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        for (NSDictionary *subDict in array) {
            
            NSString *startTime = [NSString stringWithFormat:@"%@",subDict[@"examTimeBegin"][@"time"]];
            if (startTime.length > 10) {
                startTime = [startTime substringWithRange:NSMakeRange(0, 10)];
            }
            NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:[startTime intValue]];
           startTime = [formatter stringFromDate:nowDate];
           
            NSString *endTime = [NSString stringWithFormat:@"%@",subDict[@"examTimeEnd"][@"time"]];
            if (endTime.length > 10) {
                endTime = [endTime substringWithRange:NSMakeRange(0, 10)];
            }
            NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:[endTime intValue]];
            endTime = [formatter stringFromDate:endDate];
            NSString *str1 =[startTime substringWithRange:NSMakeRange(0, 10)];
            NSString *str2 =[startTime substringWithRange:NSMakeRange(11, startTime.length -11)];
            NSString *str3 = [endTime substringWithRange:NSMakeRange(11, endTime.length -11)];

            NSString *str4 = subDict[@"name"];
                             
            NSString *str = [NSString stringWithFormat:@"%@(%@ - %@)%@",str1,str2,str3,str4];
            [self.hintArray addObject:str];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    [[AENetworkingManager shareAENetworkingManager] formalExamHistory:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"lumig------%@",responseObject);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSArray *array = [NSArray arrayWithObject:responseObject[@"rows"][0]];
        for (NSDictionary *subDict in array) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:subDict[@"score"] forKey:@"score"];
            [dict setObject:subDict[@"course"][@"name"] forKey:@"name"];
            NSString *time = [NSString stringWithFormat:@"%@",subDict[@"handleInTime"]];
            if (time.length > 10) {
                time = [time substringWithRange:NSMakeRange(0, 10)];
            }
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
            time = [formatter stringFromDate:date];
            [dict setObject:time forKey:@"time"];
            [self.recordArray addObject:dict];
        }
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];

}



#pragma mark -- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hintArray.count + 1;
    }
    else
    {
        return self.recordArray.count + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section== 0) {
        if (indexPath.row == 0) {
            return 44;
        }
        return 64;
    }
    else
    {
        return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row ==0) {
               return  [self sectionTableView:tableView cellForRowAtIndexPath:indexPath image:@"我的考试_03.png" title:@"近期考试提醒"];
            }
            if (indexPath.row > 0) {
                return [self attiontTableView:tableView cellForRowAtIndexPath:indexPath title:_hintArray[indexPath.row - 1]];
            }
            
        }
            
            break;
        case 1:
        {
            if (indexPath.row ==0) {
                return  [self sectionTableView:tableView cellForRowAtIndexPath:indexPath image:@"我的考试_06.png" title:@"历史考试记录"];
            }
            if (indexPath.row > 0) {
                return [self recordTableView:tableView cellForRowAtIndexPath:indexPath date:[NSString stringWithFormat:@"%@",_recordArray[indexPath.row -1][@"time"]]class:[NSString stringWithFormat:@"《%@》",_recordArray[indexPath.row -1][@"name"]] score:[NSString stringWithFormat:@"%@",_recordArray[indexPath.row -1][@"score"]]];
            }
            
            }
        
            break;
            
        default:
            break;
    }
    return nil;
}


- (UITableViewCell *)sectionTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath image:(NSString *) image
                                title:(NSString *)title
{
    static NSString *sectionCellID= @"sectionCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionCellID];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 20, 20)];
        imgView.tag =11;
        [cell.contentView addSubview:imgView];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+10, 11, 150, 20)];
        nameLabel.tag = 12;
        nameLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:nameLabel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
        UIImageView *imgView = [cell.contentView viewWithTag:11];
        if (imgView) {
            imgView.image = [UIImage imageNamed:image];
        }
        
        UILabel *nameLabel = [cell.contentView viewWithTag:12];
        if (nameLabel) {
            nameLabel.text = title;
        
    }
    
    return cell;
}

- (UITableViewCell *)attiontTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath title:(NSString *)title
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, SCREEN_WIDTH-30, 40)];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = [UIColor grayColor];
        nameLabel.numberOfLines = 0;
        nameLabel.tag = 13;
        [cell.contentView addSubview:nameLabel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *nameLabel = [cell.contentView viewWithTag:13];
    if (nameLabel) {
        nameLabel.text = title;
    }
    
    return cell;
}

- (UITableViewCell *)recordTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath date:(NSString *)date class:(NSString *)class score:(NSString *)score
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, 120, 20)];
        leftLabel.font = [UIFont systemFontOfSize:15];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.tag =14;
        [cell.contentView addSubview:leftLabel];
        UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 11, 200, 20)];
        middleLabel.font = [UIFont systemFontOfSize:15];
        middleLabel.textAlignment = NSTextAlignmentLeft;
        middleLabel.tag =15;
        [cell.contentView addSubview:middleLabel];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 11, 50, 20)];
        rightLabel.font = [UIFont systemFontOfSize:15];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.tag =16;
        [cell.contentView addSubview:rightLabel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    UILabel *leftLabel = [cell.contentView viewWithTag:14];
    if (leftLabel) {
        leftLabel.text = [NSString stringWithFormat:@"%@日",date];
    }
    UILabel *middleLabel = [cell.contentView viewWithTag:15];
    if (middleLabel) {
        middleLabel.text = [NSString stringWithFormat:@"%@",class];
    }
    UILabel *rightLabel = [cell.contentView viewWithTag:16];
    if (rightLabel) {
        rightLabel.text = [NSString stringWithFormat:@"%@分",score];
    }
    
    return cell;
}


+ (AENavigationController *)showNav
{
    MyTestViewController *test = [[MyTestViewController alloc] init];
    AENavigationController *nav = [[AENavigationController alloc] initWithRootViewController:test];
    return nav;
}

#pragma mark -- setter and getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)hintArray
{
    if (!_hintArray) {
        _hintArray = [NSMutableArray array];
    }
    return _hintArray;
}

- (NSMutableArray *)recordArray
{
    if (!_recordArray) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
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
