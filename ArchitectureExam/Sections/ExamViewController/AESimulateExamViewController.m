//
//  AESimulateExamViewController.m
//  ArchitectureExam
//
//  Created by abc on 16/1/19.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AESimulateExamViewController.h"
#import "AEExamDetailCollectionViewCell.h"
#import "AEExamRightNavButton.h"
#import "AESimulateExamPresentView.h"
#import "AEAlertView.h"
#import "ScoreViewController.h"

@interface AESimulateExamViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AEExamDetailCollectionViewCellDelegate,AESimulateExamPresentViewDelegate>
{
    NSTimer *_myTimer;
}
@property (strong,nonatomic)NSMutableArray              *qeustionArr;

@property (strong,nonatomic)UICollectionView            *collectionView;

@property (strong,nonatomic)UICollectionViewFlowLayout *flowLayout;
@property (strong,nonatomic)AEExamRightNavButton       *timeButton;
@property (strong,nonatomic)AEExamRightNavButton       *collectionButton;
@property (assign,nonatomic)NSInteger                   currentOffIndex;

@property (assign,nonatomic)int                   lastTime;

@property (strong,nonatomic)AESimulateExamPresentView   *examPresentView;

@end

@implementation AESimulateExamViewController

- (void)dealloc{
    [_myTimer invalidate];
    _myTimer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastTime = 30 * 60;
    [self loadData];
    [self.view addSubview:self.collectionView];
    [self addRightNav];
}

- (void)timeWithOn:(BOOL)on
{
    if (on){
        if (_myTimer){
            [_myTimer invalidate];
            _myTimer = nil;
        }
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
    }else{
        [_myTimer invalidate];
        _myTimer = nil;
    }
}

- (void)timeChanged{
    self.lastTime--;
    NSString *dateStr = [AEUtilsManager countDownDateFormartWithSecond:self.lastTime];
    self.timeButton.titleLabel.text = dateStr;
    [self.timeButton setTitle:dateStr forState:UIControlStateNormal];
    
    if (self.lastTime <= 0) {
        [self timeWithOn:NO];
    }
}

#pragma mark - 添加导航按钮
- (void)addRightNav{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:
            {
                UIImage *image = [UIImage imageNamed:@"模拟考试_交卷.png"];
                NSString *title = @"交卷";
                [arr addObject:[self createWithImage:image title:title tag:i]];
            }
                break;
            case 1:
            {
                UIImage *image = [UIImage imageNamed:@"模拟考试_收藏.png"];
                NSString *title = @"收藏";
                [arr addObject:[self createWithImage:image title:title tag:i]];
            }
                break;
            case 2:
            {
                UIImage *image = [UIImage imageNamed:@"模拟考试_时间.png"];
                NSString *title = @"30:00";
                [arr addObject:[self createWithImage:image title:title tag:i]];
                
            }
                break;
                
            default:
                break;
        }
    }
    
    self.navigationItem.rightBarButtonItems = arr;
}

- (UIBarButtonItem *)createWithImage:(UIImage *)image title:(NSString *)title tag:(NSInteger)tag{
    AEExamRightNavButton *button = [AEExamRightNavButton buttonWithType:UIButtonTypeCustom];
    CGFloat w = 50;
    
    if (tag == 1) {
        self.collectionButton = button;
    }
    if (tag == 2) {
        self.timeButton = button;
    }
    
    button.frame = CGRectMake(0, 0, w, 40);
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    return item;
}

- (void)buttonClick:(AEExamRightNavButton *)button{
    NSInteger tag = button.tag;
    
    switch (tag) {
        case 0:
        {
            int count = [self remainingTitle];
            if (count > 0) {
                [self showAlertViewTitle:@"温馨提示" msg:[NSString stringWithFormat:@"你还有%d道题未做,确定交卷吗?",count] cancel:@"继续答题" confirm:@"交卷" tag:1];
            }
        }
            break;
        case 1:
            [self modifyCollection];
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
}

//剩下的题目
- (int)remainingTitle{
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
    
    return (int)self.qeustionArr.count - rightCount - errorCount;
}




- (int)getRightCount{
    int rightCount = 0;
    for (NSDictionary *dic in self.qeustionArr) {
        if ([dic[@"qeustionExamComplete"] boolValue]) {
            if ([dic[@"qeustionExamAnswer"] boolValue]) {
                rightCount++;
            }
        }
    }
    return rightCount;
}


- (void)modifyCollection{
    if (self.qeustionArr.count > self.currentOffIndex) {
        NSMutableDictionary *dic = self.qeustionArr[self.currentOffIndex];
        if (self.collectionButton.selected) {
            [self.collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
            [self.collectionButton setImage:[UIImage imageNamed:@"模拟考试_收藏.png"] forState:UIControlStateNormal];
            self.collectionButton.selected = NO;
            [[AEUserInfo shareAEUserInfo] removeCollectionQestionDic:dic];
        }else{
            [self.collectionButton setTitle:@"取消收藏" forState:UIControlStateNormal];
            [self.collectionButton setImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
            [[AEUserInfo shareAEUserInfo] addCollectionQestionDic:dic];
            self.collectionButton.selected = YES;
        }
    }
}

- (void)showAlertViewTitle:(NSString *)title msg:(NSString *)msg cancel:(NSString *)cancel confirm:(NSString *)confirm tag:(NSInteger)tag{
    AEAlertView *alertView = [[AEAlertView alloc]initWithTitle:title message:msg cancelButtonTitle:cancel confirmButtonTitle:confirm complete:^(NSInteger index, NSInteger viewTag) {
        [self viewTag:viewTag index:index];
    }];
    alertView.tag = tag;
    [alertView show];
}

- (void)viewTag:(NSInteger)tag index:(NSInteger)index{
    switch (tag) {
        case 0:
            if (index == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        case 1://交卷
            if (index == 1) {
                [self saveExamRecord];
            }
            break;
            
        default:
            break;
    }
}


#pragma mark - 请求数据
- (void)loadData{
    [[AERequestManger shareAERequestManger] getloadQeustionIndexList:self.view chapterId:nil courseId:self.courseModel.courseId examType:@"MOCK" success:^(id obj)
    {
        [self.qeustionArr addObjectsFromArray:obj];
        [self.collectionView reloadData];
        
        [self.examPresentView showInView:self.view];
        self.examPresentView.qeustionArr = self.qeustionArr;
        
        [self timeWithOn:YES];
    }];
}


#pragma mark - collectionViewDelegate datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.qeustionArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AEExamDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AEExamDetailCollectionViewCellId" forIndexPath:indexPath];
    
    if (self.qeustionArr.count > indexPath.row) {
        NSMutableDictionary *dic = self.qeustionArr[indexPath.row];
        [self isCollectionWith:dic];
        cell.qeustionDic = dic;
    }
    
    cell.indexPath = indexPath;
    self.currentOffIndex = indexPath.row;
    self.examPresentView.currentIndexPath = indexPath;
    cell.delegate = self;
    
    return cell;
}

- (void)isCollectionWith:(NSMutableDictionary *)dic{
    if ([[AEUserInfo shareAEUserInfo] isJudgeCollectionDic:dic]) {
        [self.collectionButton setTitle:@"取消收藏" forState:UIControlStateNormal];
        [self.collectionButton setImage:[UIImage imageNamed:@"模拟考试_收藏.png"] forState:UIControlStateNormal];
        self.collectionButton.selected = YES;
    }else{
        [self.collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
        [self.collectionButton setImage:[UIImage imageNamed:@"模拟考试_收藏.png"] forState:UIControlStateNormal];
        self.collectionButton.selected = NO;
    }
}

#pragma mark - delegate

- (void)collectionViewWithPath:(NSString *)path indexPath:(NSIndexPath *)indexPath{
    NSInteger section   = indexPath.section;
    NSInteger row       = indexPath.row + 1;

    self.examPresentView.qeustionArr = self.qeustionArr;
    self.examPresentView.currentIndexPath = indexPath;
    
    [self isJudgeSubmit];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollToItemWithIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    });
}

- (void)isJudgeSubmit{
    int count = [self remainingTitle];
    if (count == 0) {
        [self saveExamRecord];
    }
}

- (void)saveExamRecord{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if (self.courseModel.courseId) {
        [dic setValue:@{@"id":self.courseModel.courseId,@"name":self.courseModel.name} forKey:@"course"];
    }
    
    [dic setValue:[NSNumber numberWithInt:(1800 - self.lastTime)] forKey:@"elapsedTime"];
    [dic setValue:[NSNumber numberWithInt:[self getRightCount] * 2] forKey:@"score"];
    [dic setValue:[AEUtilsManager getCurrentTime] forKey:@"DateTime"];
    [[AEUserInfo shareAEUserInfo] saveExamRecordWith:dic];
    
    [self gotoScorePageWithDic:dic];
}


- (void)gotoScorePageWithDic:(NSMutableDictionary *)dic{
    ScoreViewController *scoreVC = [[ScoreViewController alloc]init];
    [self.navigationController pushViewController:scoreVC animated:YES];
    scoreVC.scoreDic = dic;
    scoreVC.qeustionArr = self.qeustionArr;
}

- (void)scrollToItemWithIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionView numberOfItemsInSection:0] > indexPath.row) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

- (void)examPresentView:(NSIndexPath *)indexPath{
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - 退出
- (void)backClicked{
    int count = [self remainingTitle];
    if (count == self.qeustionArr.count) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self showAlertViewTitle:@"温馨提示" msg:[NSString stringWithFormat:@"您已回答了%d题,是否放弃本次考试?",(int)self.qeustionArr.count - count] cancel:@"继续考试" confirm:@"放弃" tag:0];
    }
}


#pragma mark - getter
- (NSMutableArray *)qeustionArr
{
    if (_qeustionArr == nil) {
        _qeustionArr = [[NSMutableArray alloc]init];
    }
    return _qeustionArr;
}

- (AESimulateExamPresentView *)examPresentView{
    if (_examPresentView == nil) {
        _examPresentView = [[AESimulateExamPresentView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        _examPresentView.delegate = self;
    }
    return _examPresentView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}


- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[AEExamDetailCollectionViewCell class] forCellWithReuseIdentifier:@"AEExamDetailCollectionViewCellId"];
    }
    return _collectionView;
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
