//
//  AELoginViewController.m
//  ArchitectureExam
//
//  Created by Lumig on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AELoginViewController.h"

#define kUserInfoNameKey @"kUserInfoNameKey"
#define kUserInfoPwdKey  @"kUserInfoPwdKey"

@interface AELoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation AELoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.cornerRadius  = 6;
    self.loginBtn.layer.masksToBounds = YES;
    self.title = @"登录";
    [self addNavBack];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userNameTextField.text = [defaults objectForKey:kUserInfoNameKey];
    self.pwdTextField.text = [defaults objectForKey:kUserInfoPwdKey];
}

- (void)addNavBack
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 30);
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
}

- (void)backDidClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginBtnClick:(id)sender {
    if ([self.userNameTextField.text length] > 0 && [self.pwdTextField.text length] > 0) {
    [[AENetworkingManager shareAENetworkingManager]loginWithName:self.userNameTextField.text password:self.pwdTextField.text view:self.view success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
             [self parsingWithDic:responseObject[@"currentUser"]];
             [self saveAccount];
             [self backDidClick];
         }
            
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self showHint:@"网络异常!"];
    }];
    }
}

- (void)saveAccount{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.userNameTextField.text forKey:kUserInfoNameKey];
    [defaults setValue:self.pwdTextField.text forKey:kUserInfoPwdKey];
    [defaults synchronize];
}


- (void)parsingWithDic:(NSDictionary *)dic{
    NSMutableDictionary *parsingDic = [[NSMutableDictionary alloc]init];
    for (NSString *key in dic.allKeys) {
        if ([key isEqualToString:@"id"] ||
            [key isEqualToString:@"idCardNo"] ||
            [key isEqualToString:@"isDel"] ||
            [key isEqualToString:@"major"] ||
            [key isEqualToString:@"name"] ||
            [key isEqualToString:@"passWord"] ||
            [key isEqualToString:@"sex"] ||
            [key isEqualToString:@"sexText"] ||
            [key isEqualToString:@"studentNo"] ||
            [key isEqualToString:@"studentType"] ||
            [key isEqualToString:@"userName"] ||
            [key isEqualToString:@"userType"]) {
            [parsingDic setValue:[NSString stringWithFormat:@"%@",dic[key]] forKey:key];
        }else if ([key isEqualToString:@"classes"]){
            NSDictionary *classesDic = dic[key];
            NSMutableDictionary *classMutableDic = [[NSMutableDictionary alloc]init];
            for (NSString *cKey in classesDic.allKeys) {
                if ([cKey isEqualToString:@"id"] ||
                    [cKey isEqualToString:@"isDel"] ||
                    [cKey isEqualToString:@"name"]) {
                    [classMutableDic setValue:classesDic[cKey] forKey:cKey];
                }
            }
            [parsingDic setValue:classMutableDic forKey:key];
        }
    }
    
    [[AEUserInfo shareAEUserInfo] saveLocationUserInfo:parsingDic];
}



+ (AENavigationController *)showLoginView
{
    AELoginViewController *loginVC = [[AELoginViewController alloc]init];
    AENavigationController *nav = [[AENavigationController alloc]initWithRootViewController:loginVC];
    return nav;
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
