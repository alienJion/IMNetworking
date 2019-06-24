//
//  ShopClassCollectionViewCell.m
//  HappyShopping
//
//  Created by Alien on 2018/10/24.
//  Copyright © 2018 alien. All rights reserved.
//

#import "ShopClassCollectionViewCell.h"//商店类型cell

@implementation ShopClassCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = XJWhiteColor;
    self.iconImageView.userInteractionEnabled = YES;
}
@end
