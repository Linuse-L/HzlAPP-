//
//  LInfoCell.h
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LInfoCell : UITableViewCell
{
    NSDictionary *selectDic;
}
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, assign) BOOL isSelect;
- (void)setData:(NSDictionary *)dic;

@end
