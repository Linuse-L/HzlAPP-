//
//  GiftCell.m
//  NewApp
//
//  Created by L on 15/10/23.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "GiftCell.h"
#define HIGHT_CELL 200

@implementation GiftCell
@synthesize imageView,priceLabel,oldPriceLabel;

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 12, self.frame.size.width-4,HIGHT_CELL - 50  )];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
        
        self.loadImageView = [[UIImageView alloc]init];
        self.loadImageView.frame = CGRectMake(2, 2, self.frame.size.width-4, 35);
        [self addSubview:self.loadImageView];

        
        priceLabel = [[UILabel alloc]init];
        priceLabel.frame = CGRectMake(0, HIGHT_CELL - 40, 100, 40);
        priceLabel.textColor = Btn_Color;
        priceLabel.text = @"$222.22";
        priceLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:priceLabel];
        
        
        
        UIView *linView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width - 48, HIGHT_CELL - 20, 40, .5)];
        linView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:linView];
        
        oldPriceLabel = [[UILabel alloc]init];
        oldPriceLabel.frame = CGRectMake(self.frame.size.width - 100, HIGHT_CELL - 40, 100, 40);
        oldPriceLabel.textAlignment = NSTextAlignmentRight;
        oldPriceLabel.textColor = [UIColor grayColor];
        oldPriceLabel.text = @"$111.11";
        oldPriceLabel.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:oldPriceLabel];
        
        _discountLabel = [[UILabel alloc]init];
        _discountLabel.frame = CGRectMake(-18, 4, 50, 40);
        _discountLabel.textAlignment = NSTextAlignmentRight;
        _discountLabel.textColor = [UIColor whiteColor];
        //        _discountLabel.text = @"$111.11";
        _discountLabel.font = [UIFont systemFontOfSize:9];
        _discountLabel.transform = CGAffineTransformMakeRotation(-45*M_PI / 180.0);
        [self addSubview:_discountLabel];
        
        
    }
    return self;
    
}

- (void)setData:(NSDictionary *)dic
{
    NSString *price =[dic objectForKey:@"Price"];
    priceLabel.text = [NSString stringWithFormat:@"%@",price];
    
    NSString *oldprice =[dic objectForKey:@"PriceHistory"];
    oldPriceLabel.text = [NSString stringWithFormat:@"%@",oldprice];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"Image"]]placeholderImage:[UIImage imageNamed:LoadingImage]];
    
    NSString *isLimitTime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isLimitTime"]];
    if ([isLimitTime isEqualToString:@"false"]) {
        self.loadImageView.image = [UIImage imageNamed:@""];
    }else{
        self.loadImageView.image = [UIImage imageNamed:@"timeLoading"];
               NSString *s = @"%";
        _discountLabel.text = [NSString stringWithFormat:@"-%@%@",[dic objectForKey:@"Discount"],s];
        //    self.countdownLabel.year = @"2015";
        //    self.countdownLabel.month = @"10";
        //    self.countdownLabel.day = @"22";
        
        
    }
}


@end
