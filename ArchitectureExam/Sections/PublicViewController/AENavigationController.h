//
//  AENavigationController.h
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDrawerViewController.h"
@interface AENavigationController : UINavigationController<LDrawerChild>

@property (nonatomic,weak) LDrawerViewController *drawer;

@end
