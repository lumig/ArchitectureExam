//
//  AESimulateExamPresentView.m
//  ArchitectureExam
//
//  Created by admin on 16/1/22.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AESimulateExamPresentView.h"
#import "AEPresentCollectionViewCell.h"
#import "AEBaseView.h"
#define kButtonHeight 30
#define kGap          15

@interface AESimulateExamPresentView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AEBaseViewDelegate,UIActionSheetDelegate>

@property (strong,nonatomic)UIImageView *packUpImage;

@property (strong,nonatomic)UIButton *packUpButton;

@property (strong,nonatomic)UILabel  *showLabel;

@property (strong,nonatomic)UICollectionView *collectionView;

@property (strong,nonatomic)AEBaseView       *baseView;

@end

@implementation AESimulateExamPresentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.showLabel];
        [self addSubview:self.packUpImage];
        [self addSubview:self.packUpButton];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kButtonHeight - 1, self.frame.size.width, 1)];
        view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        [self addSubview:view];
        [self addSubview:self.collectionView];
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


#pragma mark - 显示页面
- (void)showInView:(UIView *)view{
    self.baseView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    UIColor *backColor = self.baseView.backgroundColor;
    self.baseView.backgroundColor = [backColor colorWithAlphaComponent:0];
    self.baseView.deleagate = self;
    [view addSubview:self.baseView];
    
    [view addSubview:self];
    int w = (int)((self.baseView.frame.size.width - 7 * 15) / 6);
    
    self.frame = CGRectMake(0, self.baseView.frame.size.height - (kButtonHeight + 2 * kGap + w) + 3, self.baseView.frame.size.width, kButtonHeight + 2 * kGap + w);
}

- (void)backViewTapDidClick{
    [self packUpView];
}

- (void)touchBegin{
    [self packUpView];
}

#pragma mark - 按钮点击
- (void)packUpBtnClick{
    if (self.isPop) {
        [self packUpView];
    }else{
        [self popView];
    }
}

- (void)popView{
    if (self.isPop == YES) {
        return;
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        UIColor *backColor = self.baseView.backgroundColor;
        self.baseView.backgroundColor = [backColor colorWithAlphaComponent:0.7];
        self.frame = CGRectMake(0, self.baseView.frame.size.height * 0.2+3,self.frame.size.width, self.baseView.frame.size.height * 0.8);

    } completion:^(BOOL finished) {
        self.baseView.userInteractionEnabled = YES;
        self.isPop = YES;
        self.packUpImage.image = [UIImage imageNamed:@"模拟考试_50.png"];
    }];
}

- (void)packUpView{
    if (self.isPop == NO) {
        return;
    }
    int w = (int)((self.baseView.frame.size.width - 7 * 15) / 6);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        UIColor *backColor = self.baseView.backgroundColor;
        self.baseView.backgroundColor = [backColor colorWithAlphaComponent:0];
        self.frame = CGRectMake(0, self.baseView.frame.size.height - (kButtonHeight + 2 * kGap + w) + 3, self.baseView.frame.size.width, kButtonHeight + 2 * kGap + w);
        
    } completion:^(BOOL finished) {
        self.baseView.userInteractionEnabled = NO;
        self.isPop = NO;
        self.packUpImage.image = [UIImage imageNamed:@"章节练习界面_03-01.png"];
    }];
}


#pragma mark - 数据填充
- (void)setQeustionArr:(NSMutableArray *)qeustionArr{
    _qeustionArr = qeustionArr;
    [self.collectionView reloadData];
    [self showText];
}


- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath{
    _currentIndexPath = currentIndexPath;
    
    if ([self.collectionView numberOfItemsInSection:0] > currentIndexPath.row) {
        [self.collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    }
}

#pragma mark - 显示文本
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
    
    NSString *str = [NSString stringWithFormat:@"对 %d 错 %d",rightCount,errorCount];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSRange range = [str rangeOfString:@"错"];
    
    NSRange rightRange = NSMakeRange(1, range.location - 1);
    NSRange errorRange = NSMakeRange(range.location + 1, str.length - range.location - 1);
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:AERGB(150, 220, 91) range:rightRange];
    [attrStr addAttribute:NSForegroundColorAttributeName value:AERGB(210, 112, 113) range:errorRange];
    self.showLabel.attributedText = attrStr;
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
    
    self.currentIndexPath = indexPath;
    
    [self packUpView];
    
//    [self packUp];
}


#pragma mark - 重新设置frame
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect collectionRect = self.collectionView.frame;
    collectionRect.size.height = self.frame.size.height - kButtonHeight;
    self.collectionView.frame = collectionRect;
}

#pragma mark - getter
- (UIImageView *)packUpImage{
    if (_packUpButton == nil) {
        _packUpImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 20)* 0.5, (kButtonHeight - 8) * 0.5, 20, 8)];
        _packUpImage.image = [UIImage imageNamed:@"模拟考试_50.png"];
    }
    return _packUpImage;
}

- (UILabel *)showLabel{
    if (_showLabel == nil) {
        _showLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - 170, 0, 150, kButtonHeight)];
        _showLabel.textAlignment = NSTextAlignmentRight;
        _showLabel.font = [UIFont systemFontOfSize:14];
    }
    return _showLabel;
}

- (UIButton *)packUpButton{
    if (_packUpButton == nil) {
        _packUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _packUpButton.frame = CGRectMake(8, 8, self.frame.size.width, kButtonHeight);
        [_packUpButton addTarget:self action:@selector(packUpBtnClick) forControlEvents:UIControlEventTouchDown];
    }
    return _packUpButton;
}

- (AEBaseView *)baseView{
    if (_baseView == nil) {
        _baseView = [[AEBaseView alloc]initWithFrame:CGRectZero];
        _baseView.backgroundColor = [UIColor blackColor];
        _baseView.userInteractionEnabled = NO;
//        _baseView.isEable = NO;
    }
    return _baseView;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(kGap, kGap, kGap, kGap);
        flowLayout.minimumInteritemSpacing = kGap;
        flowLayout.minimumLineSpacing = kGap;
        
        int w = (int)((self.frame.size.width - 7 * 15) / 6);
        
        flowLayout.itemSize = CGSizeMake(w, w);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kButtonHeight, self.frame.size.width, self.frame.size.height - kButtonHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[AEPresentCollectionViewCell class] forCellWithReuseIdentifier:@"AEPresentCollectionViewCell"];
    }
    return _collectionView;
}

@end
