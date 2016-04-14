//
//  AEExamDetailCollectionViewCell.h
//  ExamDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 lifevc_longlz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kQeustionSelectedAnswer @"qeustionSelectedAnswer"
#define kQeustionSaveRouterEvent @"kQeustionSaveRouterEvent"

@protocol AEExamDetailCollectionViewCellDelegate <NSObject>

@optional
- (void)collectionViewWithPath:(NSString *)path indexPath:(NSIndexPath *)indexPath;

//- (void)collectionViewWithQeustion:(NSMutableDictionary *)dic indexPath:(NSIndexPath *)indexPath;


@end

@interface AEExamDetailCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic)NSIndexPath  *indexPath;
@property (strong,nonatomic)NSDictionary *examDic;
@property (strong,nonatomic)NSMutableDictionary *qeustionDic;
@property (assign,nonatomic)id<AEExamDetailCollectionViewCellDelegate> delegate;


- (void)startShare;

@end
