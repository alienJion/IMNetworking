//
//  BaseCollectionViewController.m
//  HappyShopping
//
//  Created by Alien on 2018/10/26.
//  Copyright © 2018 alien. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "ShopClassCollectionViewCell.h"

@interface BaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
}
/**
 获取偏移量
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
/**
 分区数
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
/**
 定义展示的UICollectionViewCell的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 1;
}
/**
 定义每个UICollectionView 的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 100);
}
////这个方法是返回 Header的大小 size
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(YScreenWidth, 0);
//}
////展示header和footer界面的内容
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        
////        InformationCollectionViewCell *headerView = (InformationCollectionViewCell *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"InformationCollectionViewCell" forIndexPath:indexPath];
////        headerView.backgroundColor = [UIColor clearColor];
////        headerView.hidden = YES;
////        return headerView;
//    }
//    return nil;
//}
/**
 UICollectionView展示的内容
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopClassCollectionViewCell *shopClassCell = (ShopClassCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ShopClassCollectionViewCell" forIndexPath:indexPath];
    
    return shopClassCell;
}
/**
 设置section视图和边界的上下左右间距
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/**
设置item之前的垂直间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

/**
 UICollectionView被选中时调用的方法
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark-----------UI------------------
-(void)setSubViews{
    [self.view addSubview:[self baseCollectionView]];
    [self.baseCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(YTopNavHight);
        make.left.right.bottom.offset(0);
    }];

}
-(UICollectionViewFlowLayout *)layout{
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.sectionHeadersPinToVisibleBoundsAll = YES;
        _layout.minimumInteritemSpacing = 0.0f;
        _layout.minimumLineSpacing = 0.0f;
        
    }
    return _layout;
}
#pragma mark --------------------DZNEmptyData Delegate---------------------
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    self.baseCollectionView.mj_footer.hidden = YES;
    return [UIImage imageNamed:@"emptyData"];
}
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
//    NSString *text = @"暂无数据";
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
//                                 NSForegroundColorAttributeName: YGrayTextColor};
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -(self.baseCollectionView.frame.size.height/6);
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
//    [self getProducts];
}
-(UICollectionView *)baseCollectionView{
    if (_baseCollectionView == nil) {
        _baseCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:[self layout]];
        _baseCollectionView.alwaysBounceVertical = YES;
        _baseCollectionView.backgroundColor = [UIColor clearColor];
        _baseCollectionView.showsVerticalScrollIndicator = NO;
        _baseCollectionView.dataSource = self;
        _baseCollectionView.delegate = self;
        _baseCollectionView.emptyDataSetSource = self;
        _baseCollectionView.emptyDataSetDelegate = self;
//        注册header
//        [_baseCollectionView registerNib:[UINib nibWithNibName:@"BoutiqueContentCollectionViewCell" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BoutiqueContentCollectionViewCell"];

        //        // 轮播
        //        [_selectionCollectionView registerClass:[YABannerCollectionViewCell getCellName]
        //                     forCellWithReuseIdentifier:[YABannerCollectionViewCell getCellIdentifier]];
        //        //    播报
        //        [_selectionCollectionView registerNib:[UINib nibWithNibName:@"NewsMessageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NewsMessageCollectionViewCell"];
        //        //  商店类型
                [_baseCollectionView registerNib:[UINib nibWithNibName:@"ShopClassCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ShopClassCollectionViewCell"];
        //        //9.9购
        //        [_selectionCollectionView registerNib:[UINib nibWithNibName:@"DiscountsCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"DiscountsCollectionViewCell"];
        //        //精选宝贝标题
        //        [_selectionCollectionView registerNib:[UINib nibWithNibName:@"BoutiqueTitleCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"BoutiqueTitleCollectionViewCell"];
        //        //精选宝贝内容
        //        [_selectionCollectionView registerNib:[UINib nibWithNibName:@"BoutiqueContentCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"BoutiqueContentCollectionViewCell"];
        //
        //        WeakSelf(refreshSelf)
        //        MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //            [refreshSelf.baseCollectionView.mj_header endRefreshing];
        //            //            [self getHomeBannerRequest];
        //        }];
        //        refreshHeader.lastUpdatedTimeLabel.hidden = YES;
        //        refreshHeader.stateLabel.hidden = YES;
        //        refreshHeader.hidden = NO;
        //        _selectionCollectionView.mj_header = refreshHeader;
        //        [_selectionCollectionView.mj_header beginRefreshing];
        //UICollectionView默认20像素偏移量问题
        if (@available(iOS 11.0, *)) {
            _baseCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _baseCollectionView;
}
-(MJRefreshNormalHeader *)refreshHeader{
    if (_refreshHeader == nil) {
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self refreshData];
        }];
    }
    return _refreshHeader;
}
-(MJRefreshAutoNormalFooter *)refreshFooter{
    if (_refreshFooter == nil) {
        _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreData];
        }];
        _refreshFooter.automaticallyHidden = YES;//解决DZNEmptyDataSet冲突的问题
        [_refreshFooter setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
        
    }
    return _refreshFooter;
}
#pragma mark-----------Action--------------
/**
 下拉刷新
 */
-(void)refreshData{
    
}
/**
 上滑加载更多
 */
-(void)loadMoreData{
    
}
#pragma mark-----------Func----------------

@end
