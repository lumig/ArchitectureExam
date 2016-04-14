//
//  AEExamViewController.m
//  ArchitectureExam
//
//  Created by abc on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AEExamViewController.h"

#import "AEExamDetailCollectionViewCell.h"
#import "AEExamRightNavButton.h"
#import "AEExamPresentView.h"

@interface AEExamViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AEExamDetailCollectionViewCellDelegate,AEExamPresentViewDelegate>

@property (assign,nonatomic)NSInteger                   currentIndex;

@property (strong,nonatomic)NSArray                     *chapterArr;

@property (strong,nonatomic)NSMutableArray              *qeustionArr;

@property (strong,nonatomic)UICollectionView            *collectionView;

@property (strong,nonatomic)UICollectionViewFlowLayout *flowLayout;

@property (strong,nonatomic)AEExamRightNavButton       *numButton;
@property (strong,nonatomic)AEExamRightNavButton       *collectionButton;

@property (assign,nonatomic)NSInteger                   currentOffIndex;

@end

@implementation AEExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = 0;
    [self loadData];
    
    [self.view addSubview:self.collectionView];
    [self addRightNav];
}

- (void)addRightNav{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:
            {
                UIImage *image = [UIImage imageNamed:@"章节练习界面_分享.png"];
                NSString *title = @"考考同学";
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
                UIImage *image = [UIImage imageNamed:@"章节练习界面_题库.png"];
                NSString *title = @"0/0";
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
        self.numButton = button;
        w = 60;
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
            [self shareClick];
            break;
        case 1:
            [self modifyCollection];
            break;
        case 2:
            [self presentExamView];
            break;
            
        default:
            break;
    }
}


- (void)shareClick{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentOffIndex inSection:0];
    
    AEExamDetailCollectionViewCell *cell = (AEExamDetailCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        [cell startShare];
    }
}


- (void)modifyCollection{
    if (self.qeustionArr.count > self.currentOffIndex) {
        NSMutableDictionary *dic = self.qeustionArr[self.currentOffIndex];
        if (self.collectionButton.selected) {
            [self.collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
            [self.collectionButton setImage:[UIImage imageNamed:@"模拟考试_收藏.png"] forState:UIControlStateNormal];
            self.collectionButton.selected = NO;
            [[AEUserInfo shareAEUserInfo]removeCollectionQestionDic:dic];
        }else{
            [self.collectionButton setTitle:@"取消收藏" forState:UIControlStateNormal];
            [self.collectionButton setImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
            [[AEUserInfo shareAEUserInfo]addCollectionQestionDic:dic];
            self.collectionButton.selected = YES;
        }
    }
}

- (void)presentExamView{
    AEExamPresentView *examView = [[AEExamPresentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.2, SCREEN_WIDTH, SCREEN_HEIGHT * 0.8)];
    examView.qeustionArr = self.qeustionArr;
    examView.delegate = self;
    [examView showInView];
}

#pragma mark - 加载章节
- (void)loadData{
    [[AERequestManger shareAERequestManger] getListCourseDetail:self.view courseId:self.courseModel.courseId success:^(id obj) {
        self.chapterArr = obj;
        [self loadQeustionIndex];
    }];
}

- (void)loadQeustionIndex{
    if (self.chapterArr.count > self.currentIndex) {
        NSDictionary *dic = self.chapterArr[self.currentIndex];
        [[AERequestManger shareAERequestManger] getloadQeustionIndexList:self.view chapterId:dic[@"id"] courseId:self.courseModel.courseId examType:@"ORDER" success:^(id obj) {
            [self.qeustionArr addObjectsFromArray:obj];
            self.currentIndex++;
            [self loadQeustionIndex];
        }];
    }else{
        [self.collectionView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[AEUserInfo shareAEUserInfo].lastExamIndex inSection:0];
        [self scrollToItemWithIndexPath:indexPath];
    }
}

//@"8baaebb4-fc68-45f9-94ac-cb621954e7cf"
- (void)loadQeustionDetailIndex:(NSInteger)index complete:(void(^)(id obj))complete{
    if (self.qeustionArr.count > index) {
        NSDictionary *dic = self.qeustionArr[index];
        [[AERequestManger shareAERequestManger] getQeustionDetail:self.view questionId:dic[@"questionId"] success:^(id obj) {
            if (complete) {
                complete(obj);
            }
        }];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.qeustionArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AEExamDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AEExamDetailCollectionViewCellId" forIndexPath:indexPath];
    
    if (self.qeustionArr.count > indexPath.row) {
        NSMutableDictionary *dic = self.qeustionArr[indexPath.row];
        [self isCollectionWith:dic];
        cell.qeustionDic = dic;
    }
    
    cell.indexPath = indexPath;
    self.currentOffIndex = indexPath.row;
    [self.numButton setTitle:[NSString stringWithFormat:@"%d/%d",(int)indexPath.row + 1,(int)self.qeustionArr.count] forState:UIControlStateNormal];
    cell.delegate = self;
    
    return cell;
}

- (void)isCollectionWith:(NSMutableDictionary *)dic{
    if ([[AEUserInfo shareAEUserInfo] isJudgeCollectionDic:dic]) {
        [self.collectionButton setTitle:@"取消收藏" forState:UIControlStateNormal];
        [self.collectionButton setImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
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
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < self.qeustionArr.count; i++) {
        NSDictionary *dic = self.qeustionArr[i];
        if ([dic[@"savePath"] isEqualToString:path]) {
            [arr addObject:dic];
        }
    }
    
    if (arr.count > 0) {
        [AESaveManager saveCacheWithPath:path value:arr];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AEUserInfo shareAEUserInfo].lastExamIndex = row;
        [self scrollToItemWithIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    });
}


- (void)scrollToItemWithIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionView numberOfItemsInSection:0] > indexPath.row) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}


- (void)examPresentView:(NSIndexPath *)indexPath{
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - 清除所有数据
- (void)examCleanAllData{
    for (NSDictionary *dic in self.chapterArr) {
        NSString *path = [NSString stringWithFormat:@"CourseDetailList%@%@%@",dic[@"id"],self.courseModel.courseId,@"ORDER"];
        [AESaveManager removeCacheWithPath:path];
    }
    
    self.currentIndex = 0;
    [self.qeustionArr removeAllObjects];
    [self loadQeustionIndex];
}


#pragma mark - getter
- (NSMutableArray *)qeustionArr
{
    if (_qeustionArr == nil) {
        _qeustionArr = [[NSMutableArray alloc]init];
    }
    return _qeustionArr;
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
