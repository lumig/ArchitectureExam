//
//  LDrawerViewController.h
//  LDrawerViewController
//
//  Created by 林海 on 15/12/2.
//  Copyright © 2015年 林海. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LDrawerState){
    LDrawerStateClose = 0,
    LDrawerStateOpen,
    LDrawerStateClosing,
    LDrawerStateOpening
};

@protocol LDrawerChild;

@interface LDrawerViewController : UIViewController

@property (nonatomic,strong,readonly) UIViewController <LDrawerChild>  *leftController;

@property (nonatomic,strong,readonly) UIViewController <LDrawerChild> *centerController;

- (instancetype)initWithCenterController:(UIViewController <LDrawerChild>*)centerController leftController:(UIViewController <LDrawerChild> *)leftController;

@property (nonatomic,assign) LDrawerState drawerState;


@property (assign,nonatomic)BOOL isForbitMove;

-(void)open;

-(void)close;

@end


//子协议
@protocol LDrawerChild <NSObject>

@property (nonatomic, weak) LDrawerViewController *drawer;

@end
