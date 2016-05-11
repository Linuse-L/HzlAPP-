//
//  ListCell.h
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCountdownLabel.h"

@interface ListCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oldPriceLabel;
@property (nonatomic, strong) UILabel *discountLabel;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIImageView *loadImageView;
@property (nonatomic, strong) LCountdownLabel *countdownLabel;
@property (nonatomic, strong) UIImageView *giftImageView;
- (void)setData:(NSDictionary *)dic;


@end
