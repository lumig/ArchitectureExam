//
//  AEBaseViewController.m
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AEBaseViewController.h"

@interface AEBaseViewController ()

@end

@implementation AEBaseViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    AENavigationController *aeNav = (AENavigationController *)self.navigationController;
    
    if (aeNav.viewControllers.count > 1) {
        aeNav.drawer.isForbitMove = YES;
    }else
    {
        aeNav.drawer.isForbitMove = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUD;
    
    if (self.navigationController && self.navigationController.viewControllers.count > 1)
    {
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 15.6, 24)];
        backBtn.backgroundColor = [UIColor clearColor];
        [backBtn setImage:[UIImage imageNamed:@"Back.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backButtonItem;
    }
}


- (void)backClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
