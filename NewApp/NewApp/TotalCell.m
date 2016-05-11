//
//  TotalCell.m
//  NewApp
//
//  Created by L on 15/9/28.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "TotalCell.h"
#define TextFont 12
@implementation TotalCell
@synthesize nameLabel,addressLabel,phoneLabel,changeShippingPriceBt,shippingScr,shippingLb,rightImg;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        nameLabel = [[UILabel alloc]init];
        nameLabel.frame = RECT(10, 5, 90, 20);
        nameLabel.text = @"Shipping:";
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:nameLabel];
        
        shippingLb = [[UILabel alloc] init];
        shippingLb.frame = RECT(75, 5, 300, 20);
        shippingLb.text = @"Free shipping";
        shippingLb.font = [UIFont systemFontOfSize:13];
        shippingLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:shippingLb];
        
        rightImg = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-27, 7, 17, 17)];
        rightImg.image = [UIImage imageNamed:@"rightBackBt"];
        [self.contentView addSubview:rightImg];
        
        changeShippingPriceBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 20)];
        changeShippingPriceBt.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:changeShippingPriceBt];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(10, nameLabel.frame.size.height +10, CURRENT_CONTENT_HEIGHT - 20, .5)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
    
        UILabel *subtotalLabel = [[UILabel alloc]init];
        subtotalLabel.frame = RECT(10, 30, 150, 30);
        subtotalLabel.text = @"Subtotal:";
        subtotalLabel.font = [UIFont systemFontOfSize:TextFont];
        subtotalLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:subtotalLabel];
        
        
        phoneLabel = [[UILabel alloc]init];
        phoneLabel.frame = RECT(CURRENT_CONTENT_WIDTH - 100, 30, 90, 30);
        phoneLabel.textColor = [UIColor blackColor];
        phoneLabel.text = @"0.00";
        phoneLabel.font = [UIFont systemFontOfSize:TextFont];
        phoneLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:phoneLabel];
        
        UILabel *shippingLabel = [[UILabel alloc]init];
        shippingLabel.frame = RECT(10, 55, 150, 30);
        shippingLabel.text = @"Shipping:";
        shippingLabel.font = [UIFont systemFontOfSize:TextFont];
        shippingLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:shippingLabel];
        
        addressLabel = [[UILabel alloc]init];
        addressLabel.frame = RECT(CURRENT_CONTENT_WIDTH - 100, 55, 90, 30);
        addressLabel.text = @"$0.00";
        addressLabel.textAlignment = NSTextAlignmentRight;
        addressLabel.textColor = [UIColor blackColor];
        addressLabel.font = [UIFont systemFontOfSize:TextFont];
        [self.contentView addSubview:addressLabel];
        
        UILabel *totalLabel = [[UILabel alloc]init];
        totalLabel.frame = RECT(10, 80, 150, 30);
        totalLabel.text = @"Total:";
        totalLabel.font = [UIFont systemFontOfSize:TextFont];
        totalLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:totalLabel];
        
        _totalLabel = [[UILabel alloc]init];
        _totalLabel.frame = RECT(CURRENT_CONTENT_WIDTH - 100, 80, 90, 30);
        _totalLabel.text = @"111.11";
        _totalLabel.textAlignment = NSTextAlignmentRight;
        _totalLabel.textColor = [UIColor blackColor];
        _totalLabel.font = [UIFont systemFontOfSize:TextFont];
        [self.contentView addSubview:_totalLabel];

        shippingScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 32, [UIScreen mainScreen].bounds.size.width, 90)];
        shippingScr.hidden = YES;
        shippingScr.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:shippingScr];
        
    }
    return  self;
}

- (void)setData:(NSDictionary *)dic
{
    phoneLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cartSubTotal"]];
//    addressLabel.text = [NSString stringWithFormat:@"$%@",[dic objectForKey:@"cartSubTotal"]];
    _totalLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cartTotal"]];

}

- (void)changeRightbtstatu:(BOOL)statu
{
    if (statu) {
        rightImg.transform = CGAffineTransformMakeRotation(90*M_PI / 180.0);
    }else {
        rightImg.transform = CGAffineTransformMakeRotation(0*M_PI / 180.0);
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
