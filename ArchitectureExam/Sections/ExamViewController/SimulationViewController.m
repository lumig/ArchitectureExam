//
//  SimulationViewController.m
//  ArchitectureExam
//
//  Created by Lumig on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "SimulationViewController.h"
#import "AELoginViewController.h"

@interface SimulationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *standardLabel;
@property (weak, nonatomic) IBOutlet UIButton *exeamBtn;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@end

@implementation SimulationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self subviewUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginChanged) name:kUserInfoDefaultCenter object:nil];
    [self loginChanged];
    
    self.exeamBtn.layer.cornerRadius  = 6;
    self.exeamBtn.layer.masksToBounds = YES;    
}

- (void)loginChanged
{
    if ([AEUserInfo shareAEUserInfo].userInfo) {
        [self.nameButton setTitle:[[AEUserInfo shareAEUserInfo].userInfo objectForKey:@"name"] forState:UIControlStateNormal];
        self.nameButton.enabled = NO;
        self.hintLabel.hidden = YES;
    }else{
        [self.nameButton setTitle:@"点击登录" forState:UIControlStateNormal];
        self.nameButton.enabled = YES;
        self.hintLabel.hidden = NO;
    }
}

- (void)subviewUI
{
    self.title = @"模拟考试";
    NSString *countStr = @"50题";
    NSMutableAttributedString *countAttributes = [[NSMutableAttributedString alloc] initWithString:countStr];
    [countAttributes addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:210/255.0f green:100/255.0f blue:15/255.0f alpha:1.0f] range:NSMakeRange(0, 2)];
    _countTitleLabel.attributedText = countAttributes;
    NSString *timeStr = @"30分钟";
    NSMutableAttributedString *timeAttributes = [[NSMutableAttributedString alloc] initWithString:timeStr];
    [timeAttributes addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:210/255.0f green:100/255.0f blue:15/255.0f alpha:1.0f] range:NSMakeRange(0, timeStr.length - 2)];
    _timeLabel.attributedText = timeAttributes;
    NSString *standardStr = @"满分100分，60分及格";
    NSMutableAttributedString *standardAttributes = [[NSMutableAttributedString alloc] initWithString:standardStr];
    [standardAttributes addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:210/255.0f green:100/255.0f blue:15/255.0f alpha:1.0f] range:NSMakeRange(2, 3)];
    [standardAttributes addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:210/255.0f green:100/255.0f blue:15/255.0f alpha:1.0f] range:NSMakeRange(7, 2)];
    _standardLabel.attributedText = standardAttributes;
    
    _exeamBtn.highlighted = NO;
}
- (IBAction)loginBtnDidClick:(UIButton *)sender {
    
    [self presentViewController:[AELoginViewController showLoginView] animated:YES completion:nil];

}


- (IBAction)examBtnDidClick:(id)sender {
    
    AESimulateExamViewController *simulateExamVC = [[AESimulateExamViewController alloc]init];
    [self.navigationController pushViewController:simulateExamVC animated:YES];
    simulateExamVC.courseModel = self.courseModel;
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
