//
//  ClassCell.h
//  NewApp
//
//  Created by L on 15/9/23.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsViewController.h"
@interface ClassCell : UITableViewCell
{
    NSArray *dataArray;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *productLabel;
@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UIImageView *productImageView;
- (void)requestData:(NSDictionary *)dic;

@end
