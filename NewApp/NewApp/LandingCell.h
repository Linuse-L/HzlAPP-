//
//  LandingCell.h
//  NewApp
//
//  Created by L on 15/9/27.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnStringBlock)();

@interface LandingCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) ReturnStringBlock returnTextBlock;
- (void)returnText:(ReturnStringBlock)block;
- (void)setData:(NSDictionary *)dic;

@end
