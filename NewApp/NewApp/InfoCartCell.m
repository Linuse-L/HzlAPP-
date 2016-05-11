//
//  InfoCartCell.m
//  NewApp
//
//  Created by L on 15/9/24.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "InfoCartCell.h"

@implementation InfoCartCell
@synthesize titleLabel,orderNumLabel,sizeLabel,productImageView,priceLabel,qtyLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        productImageView = [[UIImageView alloc]init];
        productImageView.frame = CGRectMake(10, 10, 100*iphone_WIDTH, 100*iphone_HIGHT);
        productImageView.contentMode = UIViewContentModeScaleAspectFit;
        productImageView.image = [UIImage imageNamed:@"3.jpg"];
        [self addSubview:productImageView];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.numberOfLines = 1;
        titleLabel.frame = CGRectMake(120*iphone_WIDTH, 0, CURRENT_DEVICE_WIDTH - 140, 30);
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLabel];
        
        sizeLabel = [[UILabel alloc]init];
        sizeLabel.numberOfLines = 0;
        sizeLabel.textColor = [UIColor blackColor];
        sizeLabel.frame = CGRectMake(120*iphone_WIDTH, 60, 150, 30);
        sizeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:sizeLabel];
        
        priceLabel = [[UILabel alloc]init];
        priceLabel.text = @"$100.00";
        priceLabel.numberOfLines = 0;
        priceLabel.textColor = [UIColor blackColor];
        priceLabel.frame = CGRectMake(120*iphone_WIDTH, 30, CURRENT_DEVICE_WIDTH - 200, 30);
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:priceLabel];

        qtyLabel = [[UILabel alloc]init];
        qtyLabel.numberOfLines = 0;
        qtyLabel.textColor = [UIColor blackColor];
        qtyLabel.frame = RECT(120, 90, 90, 30);
        qtyLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:qtyLabel];
    }
    return  self;
}

- (void)setData:(NSDictionary *)dic
{
    NSString *hascolor = [dic objectForKey:@"ishascolor"];
    NSString *hassize  = [dic objectForKey:@"ishassize"];
    NSString *hasgift  = [dic objectForKey:@"isGift"];
    [productImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"productImage"]]placeholderImage:[UIImage imageNamed:LoadingImage]];
    titleLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]];
    qtyLabel.text = [NSString stringWithFormat:@"x%@",[dic objectForKey:@"qty"]];
    NSDictionary *sizeInfoDic = [dic objectForKey:@"sizeInfo"];
    NSDictionary *sizedic = [sizeInfoDic objectForKey:@"size"];
    if ([hassize isEqualToString:@"OK"]) {
        sizeLabel.text = [NSString stringWithFormat:@"%@",[sizedic objectForKey:@"selectOptionDisplay"]];
    }else {
        sizeLabel.text = @"";
    }
    if (sizeInfoDic) {
        
        
    }else{
        sizeLabel.text = @" ";
        
    }
    priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"productPrice"]];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
