//
//  AddressInfoCell.m
//  NewApp
//
//  Created by L on 15/9/28.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "AddressInfoCell.h"

@implementation AddressInfoCell
@synthesize nameLabel,addressLabel,phoneLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *topImageView = [[UIImageView alloc]init];
        topImageView.image = [UIImage imageNamed:@"line_Address"];
        topImageView.frame = RECT(0, 0, CURRENT_CONTENT_WIDTH, 2);
        [self addSubview:topImageView];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(25, 10, 150, 30);
        nameLabel.text = @"KIMI";
        nameLabel.font = [UIFont systemFontOfSize:15];
        [nameLabel sizeToFit];
        [self.contentView addSubview:nameLabel];
        
        phoneLabel = [[UILabel alloc]init];
        phoneLabel.frame = CGRectMake(25, 40, 150, 30);
        phoneLabel.text = @"138****3333";
        phoneLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:phoneLabel];
        
        addressLabel = [[UILabel alloc]init];
        addressLabel.frame = CGRectMake(25, 70, CURRENT_CONTENT_WIDTH-50, 30)
        ;
        addressLabel.numberOfLines = 0;
        addressLabel.text = @"zhongguo gugong dizhi  beijing sanlit dongchengqu youyiku";
        addressLabel.textColor = [UIColor blackColor];
        addressLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:addressLabel];
        
        UIImageView *footImageView = [[UIImageView alloc]init];
        footImageView.image = [UIImage imageNamed:@"line_Address"];
        footImageView.frame = RECT(0, 98, CURRENT_CONTENT_WIDTH, 2);
        [self addSubview:footImageView];
        UIImageView *dingweiImageView = [[UIImageView alloc]init];
        dingweiImageView.image = [UIImage imageNamed:@"dingwei"];
        dingweiImageView.frame = RECT(7, 21, 10, 13);
        [self addSubview:dingweiImageView];
    }
    return  self;
}

- (void)setDic:(NSDictionary *)dic
{
//    "address_book_id" = 2698;
//    "customers_email_address" = "12321@qq.com";
//    "entry_city" = momono;
//    "entry_country_id" = 113;
//    "entry_firstname" = wzwoj;
//    "entry_gender" = C;
//    "entry_lastname" = jllll;
//    "entry_phone" = 88555565;
//    "entry_postcode" = wutut;
//    "entry_state" = lllooo;
//    "entry_street_address" = looolo;
    nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"entry_firstname"]];
    addressLabel.text=[NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"entry_state"],[dic objectForKey:@"entry_street_address"]];
    phoneLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"entry_phone"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
