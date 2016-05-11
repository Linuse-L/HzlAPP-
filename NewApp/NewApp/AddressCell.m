//
//  AddressCell.m
//  NewApp
//
//  Created by L on 15/9/24.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"backgrod_image"];
        imageView.frame = CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, 45*iphone_HIGHT);
        [self addSubview:imageView];

        UILabel *label = [[UILabel alloc]init];
        label.frame = RECT(30, 10,260, 25);
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"Please Add Shipping Address";
        [self addSubview:label];
        
    }
    return  self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
