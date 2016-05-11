//
//  TotalCell.h
//  NewApp
//
//  Created by L on 15/9/28.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *shippingLb;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UIButton *changeShippingPriceBt;
@property (nonatomic, strong) UIScrollView *shippingScr;
@property (nonatomic, strong) UIImageView *rightImg;
- (void)setData:(NSDictionary *)dic;
- (void)changeRightbtstatu:(BOOL)statu;

@end
