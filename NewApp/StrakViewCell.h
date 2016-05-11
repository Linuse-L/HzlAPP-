//
//  StrakViewCell.h
//  Dragon
//
//  Created by 黄权浩 on 15-1-15.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrakViewCell : UITableViewCell
//图片
@property (weak, nonatomic) IBOutlet UIImageView *img;
//名字
@property (weak, nonatomic) IBOutlet UILabel *name;
//数量
@property (weak, nonatomic) IBOutlet UILabel *number;
//价格
@property (weak, nonatomic) IBOutlet UILabel *price;

- (void)setdic:(NSDictionary *)arr;

@end
