//
//  CurrencyCell.m
//  NewApp
//
//  Created by 黄权浩 on 15/10/19.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "CurrencyCell.h"

@implementation CurrencyCell

- (void)setDic:(NSDictionary *)dic
{
    self.title.text = [dic objectForKey:@"code"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
