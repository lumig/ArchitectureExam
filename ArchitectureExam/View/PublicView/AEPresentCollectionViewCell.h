//
//  AEPresentCollectionViewCell.h
//  ArchitectureExam
//
//  Created by abc on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEPresentCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic)NSIndexPath *indexPath;

@property (assign,nonatomic)BOOL        isExamComplete;

@property (assign,nonatomic)BOOL        isRightAnswer;

@end
