//
//  AENavigationController.m
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AENavigationController.h"

@interface AENavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation AENavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self=[super initWithRootViewController:rootViewController];
    if (self)
    {
        self.navigationBar.barTintColor = COLOR_NAV;
        self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
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
