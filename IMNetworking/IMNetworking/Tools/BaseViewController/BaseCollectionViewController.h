//
//  BaseCollectionViewController.h
//  HappyShopping
//
//  Created by Alien on 2018/10/26.
//  Copyright © 2018 alien. All rights reserved.
//

#import "BaseViewController.h"
#import "UICollectionViewFlowLayout+Add.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewController : BaseViewController
@property (nonatomic, strong)UICollectionView *baseCollectionView;
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)MJRefreshNormalHeader *refreshHeader;
@property(nonatomic,strong)MJRefreshAutoNormalFooter *refreshFooter;
@end

NS_ASSUME_NONNULL_END
