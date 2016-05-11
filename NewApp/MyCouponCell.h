//
//  MyCouponCell.h
//  NewApp
//
//  Created by 黄权浩 on 15/12/11.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCouponCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *couponlittleTitle;
@property (weak, nonatomic) IBOutlet UIImageView *couponImg;
@property (weak, nonatomic) IBOutlet UILabel *couponValue;
@property (weak, nonatomic) IBOutlet UILabel *couponTitle;
@property (nonatomic, strong) NSString *panduan;
- (void)setDic:(NSDictionary *)dic;

@end
