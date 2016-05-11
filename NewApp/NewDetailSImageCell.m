//
//  NewDetailSImageCell.m
//  NewApp
//
//  Created by L on 16/3/17.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "NewDetailSImageCell.h"
#import "WebVC.h"
@implementation NewDetailSImageCell
@synthesize titleLabel,twolabel,fistLabel,shipImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = RECT(0, 5, 320, 90);
        imageView.image = [UIImage imageNamed:@"lineDetail"];
        [self addSubview:imageView];
        
        shipImageView = [[UIImageView alloc]init];
        shipImageView.frame = RECT(5, 10, 100, 80);
        shipImageView.image = [UIImage imageNamed:@"1122"];
        shipImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:shipImageView];
        
        //title
        titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"Eagleyes RB3025 Aviator Sunglasses Gold Frame Brown Lens";
        titleLabel.numberOfLines = 0;
        titleLabel.frame = CGRectMake(110, 20, 200, 30);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:10];
        titleLabel.textColor = RGB_Color(105, 105, 105);
        [self addSubview:titleLabel];
        
        //现价
        fistLabel = [[UILabel alloc]init];
        fistLabel.text = @"$173.00";
        fistLabel.frame = CGRectMake(110, titleLabel.frame.origin.y +30, 100, 30);
        fistLabel.font = [UIFont systemFontOfSize:10];
        fistLabel.textColor = [UIColor blackColor];
        [self addSubview:fistLabel];
        
        //原价
        twolabel = [[UILabel alloc]init];
        twolabel.frame = CGRectMake(150, fistLabel.frame.origin.y, 100, 30);
        twolabel.text= @"$375.00";
        twolabel.textAlignment = NSTextAlignmentLeft;
        twolabel.font = [UIFont systemFontOfSize:9];
        twolabel.textColor = [UIColor grayColor];
        [self addSubview:twolabel];

        moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [moreBtn setTitle:[NSString stringWithFormat:@"More>>"] forState:UIControlStateNormal];
        [moreBtn setTitleColor:RGB_Color(230, 181, 104) forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [moreBtn addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
        
        moreLabel = [[UILabel alloc]init];
        moreLabel.textAlignment = NSTextAlignmentLeft;
        moreLabel.text = @"More>>";
        moreLabel.frame = CGRectMake(0, 5, 60, 20);
        moreLabel.font = [UIFont systemFontOfSize:10];
        moreLabel.textColor = YellowColor;
        [moreBtn addSubview:moreLabel];
         webView = [[UIWebView alloc]initWithFrame:RECT(0, 100, 320, 300)];
        [webView setUserInteractionEnabled:NO];//是否支持交互
        [webView setOpaque:NO];//opaque是不透明的意思
        [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
        
        [self addSubview:webView];
        //加载网页的方式
        //1.创建并加载远程网页
        
       
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)reviewWith:(NSDictionary *)dic
{

    [shipImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Image"]]] placeholderImage:[UIImage imageNamed:LoadingImage]];
    self.titleLabel.text = [dic objectForKey:@"products_name"];
    self.fistLabel.text = [dic objectForKey:@"Price"];
    self.twolabel.text = [dic objectForKey:@"PriceHistory"];
    NSURL *url1 = [NSURL URLWithString:[dic objectForKey:@"products_description_url"]];
    [webView loadRequest:[NSURLRequest requestWithURL:url1]];

    
}

- (void)more:(UIButton*)btn
{
    NSLog(@"%ld",(long)btn.tag);
    if (btn.tag == 1) {
        WebVC *webVC = [[WebVC alloc]init];
        webVC.url = detailUrl;
        webVC.title = @"Details Description";
        [[AppDelegate getAppDelegate].naVC pushViewController:webVC animated:YES];

    }else if (btn.tag ==2)
    {
        ReviewVC *reviewVC = [[ReviewVC alloc]init];
        reviewVC.positionID = producy_id;
        [[AppDelegate getAppDelegate].naVC pushViewController:reviewVC animated:YES];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
