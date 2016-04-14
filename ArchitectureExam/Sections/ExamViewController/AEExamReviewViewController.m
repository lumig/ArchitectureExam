//
//  AEExamReviewViewController.m
//  ArchitectureExam
//
//  Created by abc on 16/1/24.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEExamReviewViewController.h"

@interface AEExamReviewViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AEExamDetailCollectionViewCellDelegate,AESimulateExamPresentViewDelegate>


@property (strong,nonatomic)AESimulateExamPresentView   *examPresentView;
@property (strong,nonatomic)UICollectionView            *collectionView;

@property (strong,nonatomic)UICollectionViewFlowLayout *flowLayout;
@end

@implementation AEExamReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"试题回顾";
    [self.view addSubview:self.collectionView];
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
        cell.qeustionDic = dic;
    }
    
    cell.indexPath = indexPath;
    self.examPresentView.currentIndexPath = indexPath;
    cell.delegate = self;
    
    return cell;
}



#pragma mark - delegate

- (void)collectionViewWithPath:(NSString *)path indexPath:(NSIndexPath *)indexPath{
    NSInteger section   = indexPath.section;
    NSInteger row       = indexPath.row + 1;
    
    self.examPresentView.qeustionArr = self.qeustionArr;
    self.examPresentView.currentIndexPath = indexPath;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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


#pragma mark - getter
- (AESimulateExamPresentView *)examPresentView{
    if (_examPresentView == nil) {
        _examPresentView = [[AESimulateExamPresentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
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
