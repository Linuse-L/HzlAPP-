//
//  OrderCell.m
//  NewApp
//
//  Created by L on 15/9/23.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "OrderCell.h"
#import "PayViewController.h"
#define CELL_HIGHT 130*iphone_HIGHT
@implementation OrderCell
@synthesize titleLabel,qtyLabel,sizeLabel,productImageView,priceLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        productImageView = [[UIImageView alloc]init];
        productImageView.frame = RECT(10, 10, 100, 100);
        productImageView.image = [UIImage imageNamed:@"3.jpg"];
        productImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:productImageView];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"qiaodan shoes";
        titleLabel.numberOfLines = 0;
        titleLabel.frame = RECT(120*iphone_WIDTH, 15, 190, 30);
        
        titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:titleLabel];
        
        sizeLabel = [[UILabel alloc]init];
        sizeLabel.text = @"Size:41";
        sizeLabel.numberOfLines = 0;
        sizeLabel.textColor = [UIColor grayColor];
        sizeLabel.frame = RECT(120*iphone_WIDTH, 70, 130, 30);
        sizeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:sizeLabel];
        
        priceLabel = [[UILabel alloc]init];
        priceLabel.text = @"$100.00";
        priceLabel.numberOfLines = 0;
        priceLabel.textColor = [UIColor grayColor];
        priceLabel.frame = RECT(CURRENT_DEVICE_WIDTH - 100*iphone_WIDTH, 70, 90, 30);
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:priceLabel];
        
        qtyLabel = [[UILabel alloc]init];
//        qtyLabel.text = @"$100.00";
        qtyLabel.numberOfLines = 0;
        qtyLabel.textColor = [UIColor grayColor];
        qtyLabel.frame = RECT(CURRENT_DEVICE_WIDTH - 100*iphone_WIDTH, 90, 90, 30);
        qtyLabel.textAlignment = NSTextAlignmentRight;
        qtyLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:qtyLabel];

    }
    return self;
}


- (void)setData:(NSDictionary *)dic
{
    [productImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"products_image"]]];
    priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"final_price"]];
    NSDictionary *dataDic = [[dic objectForKey:@"size"] objectAtIndex:0];
    if (dataDic) {
        sizeLabel.text = [NSString stringWithFormat:@"Size:%@",[[[dic objectForKey:@"size"] objectAtIndex:0] objectForKey:@"sizename"]];
        
    }else{
        sizeLabel.text = @"";
    }
    titleLabel.text = [dic objectForKey:@"products_name"];
    qtyLabel.text = [NSString stringWithFormat:@"x%@",[dic objectForKey:@"products_quantity"]];
    
}
- (void)btn:(UIButton *)btn
{
    if (btn.tag == 1) {
        NSLog(@"删除订单");
    }else{
        NSLog(@"去支付");
        PayViewController *payVC = [[PayViewController alloc]init];
        [[AppDelegate getAppDelegate].naVC pushViewController:payVC animated:YES];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
