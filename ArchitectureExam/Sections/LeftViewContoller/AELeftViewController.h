//
//  AELeftViewController.h
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AEBaseViewController.h"
#import "LDrawerViewController.h"

@interface AELeftViewController : AEBaseViewController<LDrawerChild>

@property (nonatomic,weak) LDrawerViewController *drawer;

@end
