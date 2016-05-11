//
//  DetailsImageCell.m
//  NewApp
//
//  Created by L on 15/9/18.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "DetailsImageCell.h"
#import "MJPhotoBrowser.h"
#define CELL_HIGHT CURRENT_CONTENT_HEIGHT-64
#define SCROLLVIEW_HIGHT 350
#define TITLE_COLOR RGB_Color(105,105,105)
@implementation DetailsImageCell
@synthesize titleLabel,priceLabel,oldPriceLabel,allOrderLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        self.backgroundColor = [UIColor blackColor];
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_DEVICE_WIDTH, SCROLLVIEW_HIGHT)];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator=NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        page = [[UIPageControl alloc]init];
        page.frame = RECT(0, 280, 320, 5);
        
        page.currentPage = 0;
        page.currentPageIndicatorTintColor = RGB_Color(0, 0, 0);
        page.pageIndicatorTintColor = RGB_Color(141, 141, 141);
        //        [self addSubview:page];
        
        
        collectionImageView = [[UIImageView alloc]init];
        collectionImageView.frame = RECT(270, 20, 50, 45);
        collectionImageView.image  = [UIImage imageNamed:@"collection"];
        //        [self addSubview:collectionImageView];
        UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        collectionBtn.frame =RECT(270, 20, 50, 45);
        collectionBtn.tag =12;
        [collectionBtn addTarget:self action:@selector(btnPush:) forControlEvents:UIControlEventTouchUpInside];
        //        [self addSubview:collectionBtn];
        //  名称
        titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"Eagleyes RB3025 Aviator Sunglasses Gold Frame Brown Lens";
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.frame = CGRectMake(10, SCROLLVIEW_HIGHT+5, CURRENT_DEVICE_WIDTH - 20, 40);
        titleLabel.textColor = TITLE_COLOR;
        titleLabel.font = [UIFont systemFontOfSize:10];
        //        titleLabel.backgroundColor = [UIColor blackColor];
        [self addSubview:titleLabel];
        
        //价钱
        priceLabel = [[UILabel alloc]init];
        priceLabel.text = @"$22.22";
        priceLabel.numberOfLines = 0;
        priceLabel.frame = CGRectMake(10, SCROLLVIEW_HIGHT +55, 160, 30);
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:13];
        priceLabel.textColor = YellowColor;
        [self addSubview:priceLabel];
        
        //原价
        oldPriceLabel = [[UILabel alloc]init];
        oldPriceLabel.text = @"$11.11";
        oldPriceLabel.numberOfLines = 0;
        oldPriceLabel.frame = CGRectMake(65, priceLabel.frame.origin.y , CURRENT_DEVICE_WIDTH - 20, 30);
        oldPriceLabel.font = [UIFont systemFontOfSize:13];
        oldPriceLabel.textColor = [UIColor grayColor];
        [self addSubview:oldPriceLabel];
        
        UIImageView *lineOldPriceImageView = [[UIImageView alloc]init];
        lineOldPriceImageView.frame = RECT(65, priceLabel.frame.origin.y + 15, 50, .5);
        lineOldPriceImageView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineOldPriceImageView];
        
        //原价
        allOrderLabel = [[UILabel alloc]init];
        allOrderLabel.text = @"12321";
        allOrderLabel.frame = CGRectMake(CURRENT_DEVICE_WIDTH - 160, priceLabel.frame.origin.y , 100, 20);
        allOrderLabel.font = [UIFont systemFontOfSize:13];
        allOrderLabel.textColor = [UIColor redColor];
        allOrderLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:allOrderLabel];

        UILabel * orderLabel = [[UILabel alloc]init];
        orderLabel.text = @"Orders";
        orderLabel.frame = CGRectMake(CURRENT_DEVICE_WIDTH - 58, priceLabel.frame.origin.y , 58, 20);
        orderLabel.textAlignment = NSTextAlignmentLeft;
        orderLabel.font = [UIFont systemFontOfSize:13];
        orderLabel.textColor = [UIColor blackColor];
        [self addSubview:orderLabel];
        
    }
    
    
    
    
    return self;
}


- (void)setData:(NSDictionary *)dic
{
    NSString *price =[dic objectForKey:@"Price"];
    
    priceLabel.text = price;
    
    titleLabel.text = [dic objectForKey:@"products_name"];
    NSString *oldprice =[dic objectForKey:@"PriceHistory"];
    
    //    CGRect bounds = [oldprice boundingRectWithSize:CGSizeMake(300, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:10] forKey:NSFontAttributeName] context:nil];
    //    oldPriceLabel.frame = CGRectMake(160, priceLabel.frame.origin.y+3 , bounds.size.width, 30);
    oldPriceLabel.text = oldprice;
    
    otherImages = [dic objectForKey:@"otherImage"];
    self.scrollView.contentSize = CGSizeMake(CURRENT_DEVICE_WIDTH*otherImages.count, SCROLLVIEW_HIGHT);
    
    for (int i = 0; i < otherImages.count; i++) {
        
        UIImageView *imageView1 = [[UIImageView alloc]init];
        imageView1.frame = CGRectMake(CURRENT_DEVICE_WIDTH*i, 0, CURRENT_DEVICE_WIDTH, SCROLLVIEW_HIGHT);
        imageView1.image = [UIImage imageNamed:@"imageBackGrou"];
        //        [_scrollView addSubview:imageView1];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(CURRENT_DEVICE_WIDTH*i, 20, CURRENT_DEVICE_WIDTH, SCROLLVIEW_HIGHT);
        imageView.tag =i;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView sd_setImageWithURL:[NSURL URLWithString:otherImages[i]]placeholderImage:[UIImage imageNamed:LoadingImage]];
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
    }
    
    reviewsLabel.text = [NSString stringWithFormat:@"REVIEWS(%@)",[dic objectForKey:@"reviews_count"]];
    page.numberOfPages = otherImages.count;
    NSString *isGift = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isGift"]];
    if ([isGift isEqualToString:@"OK"]) {
        self.giftImageView.image = [UIImage imageNamed:@"gift"];
        
    }else{
        self.giftImageView.image = [UIImage imageNamed:@""];
        
    }
    allOrderLabel.text = [dic objectForKey:@"products_ordered"];
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    int count = (int)otherImages.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [otherImages[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //        photo.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
// called when scroll view grinds to a halt
{
    //    NSLog(@"%f", self.scrollView.contentOffset.x/CURRENT_CONTENT_WIDTH);
    page.currentPage = self.scrollView.contentOffset.x/CURRENT_CONTENT_WIDTH;
}

- (void)change:(id)sender
{
    self.scrollView.contentOffset = CGPointMake(CURRENT_CONTENT_WIDTH *page.currentPage, 0);
}
- (void)buy:(UIButton *)btn
{
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"setSizeView" object:nil];
    [MobClick event:@"buy"];
    [FBSDKAppEvents logEvent:@"buy"];
    if (self.buyBlock != nil) {
        self.buyBlock();
    }
}

- (void)buyBlock:(BuyBlock)block
{
    self.buyBlock = block;
}

- (void)PushIndex:(PushIndex)block
{
    self.PushIndex = block;
}

- (void)btnPush:(UIButton *)btn
{
    NSString * sender = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"Push" object:sender];
    if (self.PushIndex != nil) {
        self.PushIndex(sender);
    }
    if (btn.tag == 12) {
        collectionImageView.image  = [UIImage imageNamed:@"SelectHighImage"];
        [btn setUserInteractionEnabled:NO];
        
    }
}
- (void)collection
{
    NSLog(@"收藏");
    collectionImageView.image  = [UIImage imageNamed:@"SelectHighImage"];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)pushReview
{
    NSLog(@"跳转评论页面");
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
