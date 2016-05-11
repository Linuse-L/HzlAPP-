//
//  InfoCartCell.h
//  NewApp
//
//  Created by L on 15/9/24.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCartCell : UITableViewCell
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *qtyLabel;

- (void)setData:(NSDictionary *)dic;

@end
