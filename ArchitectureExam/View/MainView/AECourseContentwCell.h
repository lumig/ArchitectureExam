//
//  AECourseContentwCell.h
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCourseContentRouterEvent @"kCourseContentRouterEvent"

@interface AECourseContentwCell : UITableViewCell


@property (strong,nonatomic)NSString *titleStr;
@property (strong,nonatomic)NSString *contentStr;

@property (strong,nonatomic)NSArray *contentArr;
@property (strong,nonatomic)NSIndexPath *indexPath;

+ (CGFloat)defaultHeight;

@end
