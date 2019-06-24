//
//  GuideViewController.m
//  Utilities
//
//  Created by Alien on 2019/6/17.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "GuideViewController.h"//首页引导图
#import "GuideCollectionViewCell.h"
#import "AppDelegate.h"
#import "ELCVFlowLayout.h"
@interface GuideViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong)UICollectionView *guideCollectionView;
@end

@implementation GuideViewController
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
//使用FDFullscreenPopGesture库隐藏导航栏
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;//需要显示系统自带导航栏的时候重写该方法。返回YES
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = @[@"main_intro1",@"main_intro2",@"main_intro3",@"main_intro4"];
    [self guideCollectionView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(UICollectionView *)guideCollectionView{
    if(_guideCollectionView == nil){
        ELCVFlowLayout *horizontalLayout = [[ELCVFlowLayout alloc] init];
        horizontalLayout.itemSize = CGSizeMake(YScreenWidth, YScreenHeight);
        _guideCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:horizontalLayout];
        [self.view addSubview:_guideCollectionView];
        _guideCollectionView.backgroundColor = [UIColor orangeColor];
        _guideCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _guideCollectionView.alwaysBounceVertical = YES;
        [_guideCollectionView registerNib:[UINib nibWithNibName:@"GuideCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"GuideCollectionViewCell"];
        _guideCollectionView.pagingEnabled = YES;
        _guideCollectionView.dataSource = self;
        _guideCollectionView.delegate = self;
        _guideCollectionView.showsVerticalScrollIndicator = NO;
        _guideCollectionView.showsHorizontalScrollIndicator = NO;
        _guideCollectionView.bounces = NO;
        _guideCollectionView.pagingEnabled = YES;
    }
    return _guideCollectionView;
}


/**
 定义展示的UICollectionViewCell的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

/**
 定义每个UICollectionView 的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width,collectionView.frame.size.height);
}
/**
 UICollectionView展示的内容
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GuideCollectionViewCell *guideCell = (GuideCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"GuideCollectionViewCell" forIndexPath:indexPath];
    guideCell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]];
    return guideCell;
}

/**
 UICollectionView被选中时调用的方法
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.images.count - 1) {
       
    }
}
@end
