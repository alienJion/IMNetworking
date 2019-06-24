//
//  ShopClassCollectionViewCell.h
//  HappyShopping
//
//  Created by Alien on 2018/10/24.
//  Copyright © 2018 alien. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopClassCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelSpac;

@property (weak, nonatomic) IBOutlet UILabel *icontitleLabel;


@end

NS_ASSUME_NONNULL_END
