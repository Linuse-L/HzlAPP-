//
//  NewReviewCell.m
//  NewApp
//
//  Created by L on 16/4/11.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "NewReviewCell.h"

@implementation NewReviewCell
@synthesize nameLabel, timeLabel, ratingLabel, textViewLabel,ratingView,titleLabel,twolabel,fistLabel,shipImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *LineimageView = [[UIImageView alloc]init];
        LineimageView.frame = RECT(0, 5, 320, 90);
        LineimageView.image = [UIImage imageNamed:@"lineDetail"];
        [self addSubview:LineimageView];

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

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"12321@qq.com";
        nameLabel.frame = CGRectMake(10, 105, 300, 20);
        nameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:nameLabel];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 130*iphone_WIDTH, 310*iphone_WIDTH, .5)];
        imageView.image = [UIImage imageNamed:@"line"];
        imageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:imageView];
        
        timeLabel = [[UILabel alloc]init];
        timeLabel.frame = CGRectMake(CURRENT_CONTENT_WIDTH - 100, 140*iphone_HIGHT, 90, 20);
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.text = @"Apr 03 ,2016";
        [self.contentView addSubview:timeLabel];
        
        
        
        textViewLabel = [[UILabel alloc]init];
        textViewLabel.frame = RECT(15, 175, 290, 70);
        textViewLabel.font = [UIFont systemFontOfSize:12];
        textViewLabel.numberOfLines = 0;
        textViewLabel.text = @"It tells a story both beautiful and sad : a little prince who lives in a small planet alone has a proud rose who thinks itself is the only flower of that kind. After a quarrel with the rose the little prince decides to travel,trying to find a way to relief loneliness and sorrow. During his journey, he visited several planets, and had conversations with their inhabitants, including a king";
        [self.contentView addSubview:textViewLabel];
        ratingView = [[UIImageView alloc]initWithFrame:RECT(10, 140, 60, 10)];
        ratingView.image = [UIImage imageNamed:@"pinglunxing5"];
        ratingView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:ratingView];
        
        backImageView= [[UIImageView alloc]init];
        backImageView.image = [UIImage imageNamed:@"line"];
        backImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:backImageView];

        _backText = [[UILabel alloc]init];
        _backText.font = [UIFont systemFontOfSize:12];
        _backText.numberOfLines = 0;
        _backText.textColor = [UIColor grayColor];
        [self.contentView addSubview:_backText];


        UIImageView *imageView1 = [[UIImageView alloc]init];
        imageView1.frame = RECT(0, 400, 320, 40);
        imageView1.image = [UIImage imageNamed:@"lineDetail"];
        [self addSubview:imageView1];

        reviewImageView = [[UIImageView alloc]init];
        reviewImageView.frame = RECT(100, 405, 25, 25);
        reviewImageView.image = [UIImage imageNamed:@"review"];
        [self addSubview:reviewImageView];


        _allNumLabel = [[UILabel alloc]init];
        _allNumLabel.font = [UIFont systemFontOfSize:12];
        _allNumLabel.text = @"REVIEWS(123)";
        _allNumLabel.numberOfLines = 0;
        _allNumLabel.textColor = [UIColor blackColor];
        _allNumLabel.frame = RECT(135, 405, 180, 30);
        [self addSubview:_allNumLabel];
    }
    return self;
}
- (void)setdata:(NSDictionary *)dic
{
    [shipImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Image"]]] placeholderImage:[UIImage imageNamed:LoadingImage]];
    self.titleLabel.text = [dic objectForKey:@"products_name"];
    self.fistLabel.text = [dic objectForKey:@"Price"];
    self.twolabel.text = [dic objectForKey:@"PriceHistory"];
    
    NSDictionary *reviewDic = [dic objectForKey:@"lastReview"];
    NSString *isHasReviewsBack = [NSString stringWithFormat:@"%@",[reviewDic objectForKey:@"isHasReviewsBack"]];
    nameLabel.text  =  [reviewDic objectForKey:@"customers_name"];
    timeLabel.text = [reviewDic objectForKey:@"date_added"];
    NSString *str = [reviewDic objectForKey:@"reviews_text"];
    NSString *imageName = [NSString stringWithFormat:@"pinglunxing%@",[reviewDic objectForKey:@"reviews_rating"]];
    ratingView.image = [UIImage imageNamed:imageName];
    
    CGRect bounds = [str boundingRectWithSize:CGSizeMake(300, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    NSString *backStr = [reviewDic objectForKey:@"reviews_back"];
    
    CGRect backbounds = [backStr boundingRectWithSize:CGSizeMake(300, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    
    if (bounds.size.height > 100) {
        textViewLabel.frame = RECT(15, 160, 290, 100);

    }else{
        textViewLabel.frame = RECT(15, 160, 290, bounds.size.height);
    }
    textViewLabel.text =str;
    reviews_images = [reviewDic objectForKey:@"reviews_images"];
    if (reviews_images.count !=0) {
        
        for (int i = 0; i < reviews_images.count; i++) {
            
            UIImageView *   imView1= (UIImageView *)[self viewWithTag:10+i];
            if (bounds.size.height > 100) {
                imView1.frame = RECT(15+CURRENT_CONTENT_WIDTH/3*i, 270, 90, 90);

            }else{
                imView1.frame = RECT(15+CURRENT_CONTENT_WIDTH/3*i, bounds.size.height +170, 90, 90);

            }
            imView1.contentMode = UIViewContentModeScaleAspectFit;
            imView1.userInteractionEnabled = YES;
            [imView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            imView1.tag = i;
            [imView1 sd_setImageWithURL:[NSURL URLWithString:reviews_images[i]]placeholderImage:[UIImage imageNamed:LoadingImage]];
        }
        
        if ([isHasReviewsBack isEqualToString:@"OK"]) {
            if (bounds.size.height >100) {
                backImageView.frame = RECT(10, 370, CURRENT_CONTENT_WIDTH, 1);
                
                _backText.frame = RECT(15, 375, 290, 60);

            }else{
            backImageView.frame = RECT(10, bounds.size.height +270, CURRENT_CONTENT_WIDTH, 1);
            
            _backText.frame = RECT(15, bounds.size.height +275, 290, 60);
            }
            _backText.text = [NSString stringWithFormat:@"Reply:%@",backStr];
            
        }
        
        
        
    }else{
        
        if ([isHasReviewsBack isEqualToString:@"OK"]) {
            
            if (bounds.size.height >100) {
                backImageView.frame = RECT(10, 270, CURRENT_CONTENT_WIDTH, 1);
                
                _backText.frame = RECT(15, 375, 290, 60);
                
            }else{
                backImageView.frame = RECT(10, bounds.size.height +170, CURRENT_CONTENT_WIDTH, .5);
                _backText.frame = RECT(15, bounds.size.height +175, 290, 60);

            }

                _backText.text = [NSString stringWithFormat:@"Reply:%@",backStr];
            
        }
        
    }
    
    _allNumLabel.text = [NSString stringWithFormat:@"REVIEWS(%@)",[dic objectForKey:@"reviews_count"]];
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    int count = (int)reviews_images.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [reviews_images[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
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

- (void)awakeFromNib
{
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//定义cell高度
+ (CGFloat)heightForStudent:(NSDictionary *)dic
{
    NSString *isHasReviewsBack = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isHasReviewsBack"]];
    
    NSString *introduce = [dic objectForKey:@"reviews_text"];
    CGRect bounds = [introduce boundingRectWithSize:CGSizeMake(300, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    NSString *backStr = [dic objectForKey:@"reviews_back"];
    
    CGRect backbounds = [backStr boundingRectWithSize:CGSizeMake(300, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    
    NSArray *array = [dic objectForKey:@"reviews_images"];
    if (array.count !=0) {
        if ([isHasReviewsBack isEqualToString:@"OK"]) {
            return (180+ bounds.size.height + backbounds.size.height+10)*iphone_HIGHT;
            
        }else{
            return (180+ bounds.size.height )*iphone_HIGHT;
            
        }
        
    }else{
        
        if ([isHasReviewsBack isEqualToString:@"OK"]) {
            return (70+ bounds.size.height + backbounds.size.height+10)*iphone_HIGHT;
            
        }else{
            return (70+ bounds.size.height )*iphone_HIGHT;
        }
        
    }
}

@end
