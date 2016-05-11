//
//  StrakViewCell.m
//  Dragon
//
//  Created by 黄权浩 on 15-1-15.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import "StrakViewCell.h"

@implementation StrakViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setdic:(NSDictionary *)arr
{
    [_img setImageWithURL:[NSURL URLWithString:[arr objectForKey:@"products_image"]]];
    _name.text = [arr objectForKey:@"products_name"];
    _price.text = [arr objectForKey:@"final_price"];
    _number.text = [arr objectForKey:@"products_quantity"];
}

@end
