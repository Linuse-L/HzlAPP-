//
//  GiftCell.h
//  NewApp
//
//  Created by L on 15/10/23.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oldPriceLabel;
@property (nonatomic, strong) UILabel *discountLabel;
@property (nonatomic, strong) UIImageView *loadImageView;
//@property (nonatomic, strong) LCountdownLabel *countdownLabel;
- (void)setData:(NSDictionary *)dic;
@end
