//
//  MyCouponCell.m
//  NewApp
//
//  Created by 黄权浩 on 15/12/11.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "MyCouponCell.h"

@implementation MyCouponCell

- (void)setDic:(NSDictionary *)dic
{
//    {
//        amount = "$10.00";
//        canUse = false;
//        code = reg10;
//        id = 8;
//        notice = "Shpping Cart Minimum Amount is $100.00";
//        num = 3;
//    }
    if ([self.panduan isEqualToString:@"1"]) {
        self.couponImg.image = [UIImage imageNamed:@"nocoupon"];
    }else{
        if ([[dic objectForKey:@"canUse"]isEqualToString:@"false"]) {
            self.couponImg.image = [UIImage imageNamed:@"iscoupon"];
        }else {
            self.couponImg.image = [UIImage imageNamed:@"nocoupon"];
        }
    }
    self.couponlittleTitle.text = [dic objectForKey:@"amount"];
    self.couponValue.text = [dic objectForKey:@"amount"];
    self.couponTitle.text = [dic objectForKey:@"notice"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
