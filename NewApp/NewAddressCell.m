//
//  NewAddressCell.m
//  NewApp
//
//  Created by 黄权浩 on 15/10/20.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "NewAddressCell.h"

@implementation NewAddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDic:(NSDictionary *)dic
{
    _name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"entry_firstname"]];
    _address.text=[NSString stringWithFormat:@"%@ %@ %@",[dic objectForKey:@"entry_city"],[dic objectForKey:@"entry_state"],[dic objectForKey:@"entry_street_address"]];
    _phone.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"entry_phone"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
