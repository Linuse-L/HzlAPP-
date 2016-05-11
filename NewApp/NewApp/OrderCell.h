//
//  OrderCell.h
//  NewApp
//
//  Created by L on 15/9/23.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property (nonatomic, strong) UILabel *qtyLabel;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *productImageView;

- (void)setData:(NSDictionary *)dic;

@end
