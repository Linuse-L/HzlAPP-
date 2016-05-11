//
//  CollectionCell.h
//  NewApp
//
//  Created by L on 15/10/13.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsViewController.h"

@interface CollectionCell : UITableViewCell
{
    NSString *positionID;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *productImageView;
- (void)data:(NSDictionary *)dic;

@end
