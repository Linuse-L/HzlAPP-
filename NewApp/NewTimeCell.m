//
//  NewTimeCell.m
//  NewApp
//
//  Created by L on 16/4/26.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "NewTimeCell.h"
#define Cell_Hight 180
#define LABEL_X 153
@implementation NewTimeCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initFrame];
    }
    return self;
}
- (void)initFrame
{
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = RECT(0, 0, 320, Cell_Hight);
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    
    
}

- (void)dataWith:(NSArray *)array
{
    allArray = array;
    for (int i = 0; i<array.count; i++) {

        NSDictionary *dic = array[i];
        NSDictionary *limitTimeDic = [dic objectForKey:@"limitTime"];
       UIImageView* productImageView = [[UIImageView alloc]init];
        productImageView.frame = RECT(CURRENT_DEVICE_WIDTH *i+10, 10, 120, Cell_Hight - 30);
        productImageView.contentMode = UIViewContentModeScaleAspectFit;
        [productImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"Image"]] placeholderImage:[UIImage imageNamed:LoadingImage]];
        [scrollView addSubview:productImageView];
        
        UILabel* saleLabel = [[UILabel alloc]init];
        saleLabel.text = @"SALE";
        saleLabel.frame = CGRectMake(CURRENT_DEVICE_WIDTH *i+LABEL_X, 20, 150, 30);
        saleLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:saleLabel];
        
        
        UIImageView * timeImageView = [[UIImageView alloc]init];
        timeImageView.frame = RECT(CURRENT_DEVICE_WIDTH *i+LABEL_X, 50, 83, 20);
        timeImageView.contentMode = UIViewContentModeScaleAspectFit;
        timeImageView.image = [UIImage imageNamed:@"timeLoading"];
        [scrollView addSubview:timeImageView];
        
        //  倒计时
        LCountdownLabel* timeLabel = [[LCountdownLabel alloc]init];
        timeLabel.font = [UIFont systemFontOfSize:11];
        timeLabel.textColor = [UIColor whiteColor];
        //    timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.frame = CGRectMake(CURRENT_DEVICE_WIDTH *i+LABEL_X+3, 50, 150, 20);
        timeLabel.year = [limitTimeDic objectForKey:@"y"];
        timeLabel.month = [limitTimeDic objectForKey:@"m"];
        timeLabel.day = [limitTimeDic objectForKey:@"d"];
        [scrollView addSubview:timeLabel];
        
        
        
        //    标题
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = [dic objectForKey:@"Title"];
        titleLabel.numberOfLines = 0;
        titleLabel.frame = CGRectMake(CURRENT_DEVICE_WIDTH *i+LABEL_X, 80, 150, 30);
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:10];
        [scrollView addSubview:titleLabel];
        //价钱
        UILabel* priceLabel = [[UILabel alloc]init];
        priceLabel.text = [dic objectForKey:@"Price"];
        priceLabel.frame = CGRectMake(CURRENT_DEVICE_WIDTH *i+LABEL_X, 110, 150, 30);
        priceLabel.font = [UIFont systemFontOfSize:13];
        [scrollView addSubview:priceLabel];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = RECT(320*i, 0, 320, Cell_Hight);
        btn.tag = i;
        [btn addTarget:self action:@selector(timePushDetails:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];


    }
    scrollView.contentSize = CGSizeMake(CURRENT_DEVICE_WIDTH *array.count, Cell_Hight);

}
- (void)timePushDetails:(UIButton *)b
{
    NSDictionary *dic = allArray[b.tag];
    NSString *positionID = [dic objectForKey:@"positionID"];
    self.time_Block(positionID);
}

- (void)Block:(PushDetailsBlock)block
{
    self.time_Block = block;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
