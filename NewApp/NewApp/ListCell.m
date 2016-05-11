//
//  ListCell.m
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "ListCell.h"
#define HIGHT_CELL 200
@implementation ListCell
@synthesize imageView,priceLabel,oldPriceLabel,countdownLabel;

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {

        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 12, self.frame.size.width-4,HIGHT_CELL - 50  )];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.freshsneakers.top/images/141217/Jordan-1/Authentic-Air-Jordan-1-High-Black-Sport-Red-White-Cement-Grey-017.jpg"] placeholderImage:[UIImage imageNamed:LoadingImage]];
        [self.contentView addSubview:imageView];
        
        self.loadImageView = [[UIImageView alloc]init];
        self.loadImageView.frame = CGRectMake(2, 2, self.frame.size.width-4, 35);
        [self addSubview:self.loadImageView];

        self.giftImageView = [[UIImageView alloc]init];
        self.giftImageView.frame = CGRectMake(2, 12, 40, 25);
        [self addSubview:self.giftImageView];
        countdownLabel = [[LCountdownLabel alloc]init];
        countdownLabel.font = [UIFont systemFontOfSize:11];
        countdownLabel.textColor = Btn_Color;
        countdownLabel.textAlignment = NSTextAlignmentLeft;
        countdownLabel.frame = CGRectMake(42, 9, 150, 20);

        
        priceLabel = [[UILabel alloc]init];
        priceLabel.frame = CGRectMake(10, HIGHT_CELL - 30, 100, 30);
        priceLabel.textColor = Btn_Color;
        priceLabel.text = @"$222.22";
        priceLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:priceLabel];
        
        
        
        UIView *linView = [[UIView alloc]initWithFrame:CGRectMake(70, HIGHT_CELL - 12, 40, .5)];
        linView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:linView];
        
        oldPriceLabel = [[UILabel alloc]init];
        oldPriceLabel.frame = CGRectMake(70, HIGHT_CELL - 25, 100, 25);
        oldPriceLabel.textAlignment = NSTextAlignmentLeft;
        oldPriceLabel.textColor = [UIColor grayColor];
        oldPriceLabel.text = @"$111.11";
        oldPriceLabel.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:oldPriceLabel];
        
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.frame = RECT(10, HIGHT_CELL - 45, CURRENT_CONTENT_WIDTH/2-20, 25);
//        _titlelabel.textAlignment = ;
        _titlelabel.textColor = [UIColor grayColor];
//        _titlelabel.numberOfLines = 0;
        _titlelabel.text = @"Air Jordan 1 High(Black-Sport Red-White-Cement Grey)";
        _titlelabel.font = [UIFont systemFontOfSize:9];
        [self addSubview:_titlelabel];

        
    }
    return self;

}

- (void)setData:(NSDictionary *)dic
{
    NSString *price =[dic objectForKey:@"Price"];
    priceLabel.text = price;
    
    NSString *oldprice =[dic objectForKey:@"PriceHistory"];
        oldPriceLabel.text = oldprice;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"Image"]]placeholderImage:[UIImage imageNamed:LoadingImage]];

    _titlelabel.text = [dic objectForKey:@"Title"];

}





@end
