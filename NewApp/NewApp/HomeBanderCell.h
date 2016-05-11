//
//  HomeBanderCell.h
//  NewApp
//
//  Created by L on 15/9/23.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"
@interface HomeBanderCell : UITableViewCell<UISearchBarDelegate>
{
    NSArray *BannerArray;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *productLabel;
@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISearchBar *searchBarView;
- (void)bannerData:(NSDictionary *)dataDic;
@end
