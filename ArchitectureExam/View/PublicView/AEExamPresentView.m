//
//  AEExamPresentView.m
//  ArchitectureExam
//
//  Created by abc on 16/1/17.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEExamPresentView.h"
#import "AEPresentCollectionViewCell.h"
#import "AEBaseView.h"

@interface AEExamPresentView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AEBaseViewDelegate,UIActionSheetDelegate>

@property (strong,nonatomic)UIImageView *packUpButton;

@property (strong,nonatomic)UILabel  *showLabel;

@property (strong,nonatomic)UIButton *cleanButton;

@property (strong,nonatomic)UICollectionView *collectionView;

@end

@implementation AEExamPresentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.packUpButton];
        [self addSubview:self.showLabel];
        [self addSubview:self.cleanButton];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 54, self.frame.size.width, 1)];
        view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        [self addSubview:view];
        [self addSubview:self.collectionView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)showInView{
    UIWindow *window = [AEUtilsManager getSystemWindow];
    AEBaseView *baseView = [[AEBaseView alloc]initWithFrame:window.bounds];
    baseView.deleagate = self;
    baseView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [window addSubview:baseView];
    
    [baseView addSubview:self];
    
    CGRect frame = self.frame;
    frame.origin.y = window.frame.size.height;
    self.frame = frame;
    
    [self showText];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)showText{
    int rightCount = 0;
    int errorCount = 0;
    
    for (NSDictionary *dic in self.qeustionArr) {
        if ([dic[@"qeustionExamComplete"] boolValue]) {
            if ([dic[@"qeustionExamAnswer"] boolValue]) {
                rightCount++;
            }else{
                errorCount++;
            }
        }
    }
    
    NSString *str = [NSString stringWithFormat:@"对 %d 错 %d 未答 %d",rightCount,errorCount,(int)self.qeustionArr.count - rightCount - errorCount];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSRange range = [str rangeOfString:@"错"];
    NSRange sRange = [str rangeOfString:@"未"];
    
    NSRange rightRange = NSMakeRange(1, range.location - 1);
    NSRange errorRange = NSMakeRange(range.location + 1, sRange.location - range.location - 1);
    NSRange nRange = NSMakeRange(sRange.location + 3, str.length - sRange.location - 3);
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:AERGB(150, 220, 91) range:rightRange];
    [attrStr addAttribute:NSForegroundColorAttributeName value:AERGB(210, 112, 113) range:errorRange];
    [attrStr addAttribute:NSForegroundColorAttributeName value:AERGB(186, 186, 186) range:nRange];
    self.showLabel.attributedText = attrStr;
    
}

- (void)touchBegin{
    [self packUp];
}

- (void)packUp{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];
}

#pragma mark - 清除
- (void)cleanDidClick{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"清空顺序联系的答题记录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空记录" otherButtonTitles:nil, nil];
    [actionSheet showInView:[AEUtilsManager getSystemWindow]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self packUp];
        if ([self.delegate respondsToSelector:@selector(examCleanAllData)]) {
            [self.delegate examCleanAllData];
        }
    }
}


- (void)setQeustionArr:(NSMutableArray *)qeustionArr{
    _qeustionArr = qeustionArr;
    [self.collectionView reloadData];
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.qeustionArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AEPresentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AEPresentCollectionViewCell" forIndexPath:indexPath];
    
    
    if (self.qeustionArr.count > indexPath.row) {
        NSDictionary *dic = self.qeustionArr[indexPath.row];
        cell.isExamComplete = [dic[@"qeustionExamComplete"] boolValue];
        cell.isRightAnswer = [dic[@"qeustionExamAnswer"] boolValue];
    }
    
    cell.indexPath = indexPath;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(examPresentView:)]) {
        [self.delegate examPresentView:indexPath];
    }
    [self packUp];
}


#pragma mark - getter
- (UIImageView *)packUpButton{
    if (_packUpButton == nil) {
        _packUpButton = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 20)* 0.5, 6, 20, 8)];
        _packUpButton.image = [UIImage imageNamed:@"章节练习界面_03-01.png"];
    }
    return _packUpButton;
}

- (UILabel *)showLabel{
    if (_showLabel == nil) {
        _showLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, self.frame.size.width - 115, 25)];
        _showLabel.font = [UIFont systemFontOfSize:14];
    }
    return _showLabel;
}

- (UIButton *)cleanButton{
    if (_cleanButton == nil) {
        _cleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cleanButton.frame = CGRectMake(self.frame.size.width - 90, 20, 75, 25);
        _cleanButton.layer.cornerRadius = 6;
        _cleanButton.layer.masksToBounds = YES;
        _cleanButton.layer.borderColor = AERGB(112, 166, 223).CGColor;
        [_cleanButton setTitle:@"清空记录" forState:UIControlStateNormal];
        _cleanButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cleanButton setTitleColor:AERGB(112, 166, 223) forState:UIControlStateNormal];
        _cleanButton.layer.borderWidth = 1.0f;
        [_cleanButton addTarget:self action:@selector(cleanDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cleanButton;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.minimumLineSpacing = 15;
        
        int w = (int)((self.frame.size.width - 7 * 15) / 6);
        
        flowLayout.itemSize = CGSizeMake(w, w);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 55, self.frame.size.width, self.frame.size.height - 60) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[AEPresentCollectionViewCell class] forCellWithReuseIdentifier:@"AEPresentCollectionViewCell"];
    }
    return _collectionView;
}


@end
