//
//  CollectionCell.m
//  NewApp
//
//  Created by L on 15/10/13.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell
@synthesize productImageView,titleLabel,priceLabel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        productImageView = [[UIImageView alloc]init];
        productImageView.frame = RECT(10, 5, 90, 90);
        productImageView.image = [UIImage imageNamed:@"3.jpg"];
        productImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:productImageView];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"qiaodan shoes";
        titleLabel.numberOfLines = 0;
        titleLabel.frame = RECT(120*iphone_WIDTH, 15, CURRENT_CONTENT_WIDTH - 140, 30);
        
        titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:titleLabel];
        priceLabel = [[UILabel alloc]init];
        priceLabel.text = @"$100.00";
        priceLabel.numberOfLines = 0;
        priceLabel.textColor = Btn_Color;
        priceLabel.frame =  RECT(120*iphone_WIDTH, 45, CURRENT_CONTENT_WIDTH - 140, 30);
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:priceLabel];
        
        
        
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];//serect@2x
        [buyBtn setFrame:RECT(CURRENT_CONTENT_WIDTH - 110, 60, 100, 30)];
        [buyBtn setTitle:@"To buy" forState:UIControlStateNormal];
        buyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        buyBtn.backgroundColor = Btn_Color;
        [buyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        buyBtn.layer.cornerRadius = 3.0;
        buyBtn.layer.borderColor = [[UIColor grayColor] CGColor];
        buyBtn.layer.borderWidth = .5;
        [buyBtn addTarget:self action:@selector(toBuy:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buyBtn];

        
        
    }
    return self;
}

- (void)data:(NSDictionary *)dic
{
    positionID = [dic objectForKey:@"positionID"];
    [productImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Image"]]] placeholderImage:[UIImage imageNamed:LoadingImage]];
    titleLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
    priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
    
}
- (void)toBuy:(UIButton *)btn
{
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    detailsVC.positionID = positionID;
    
    [[AppDelegate getAppDelegate].naVC pushViewController:detailsVC animated:YES];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
