//
//  ReviewCell.m
//  NewApp
//
//  Created by L on 15/9/24.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "ReviewCell.h"
#import "MJPhotoBrowser.h"
@implementation ReviewCell
@synthesize nameLabel, timeLabel, ratingLabel, textViewLabel,ratingView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(10, 5, 300, 20);
        nameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:nameLabel];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30*iphone_WIDTH, 310*iphone_WIDTH, .5)];
        imageView.image = [UIImage imageNamed:@"line"];
        imageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:imageView];
        
        timeLabel = [[UILabel alloc]init];
        timeLabel.frame = CGRectMake(CURRENT_CONTENT_WIDTH - 100, 40*iphone_HIGHT, 90, 20);
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:timeLabel];
        
        
        ratingLabel = [[UILabel alloc]init];
        ratingLabel.frame = RECT(30, 45, 100, 30);
        ratingLabel.font = [UIFont systemFontOfSize:12];
        //        [self.contentView addSubview:ratingLabel];
        
        
        textViewLabel = [[UILabel alloc]init];
        textViewLabel.frame = RECT(15, 75, 290, 70);
        textViewLabel.font = [UIFont systemFontOfSize:12];
        textViewLabel.numberOfLines = 0;
        [self.contentView addSubview:textViewLabel];
        ratingView = [[UIImageView alloc]initWithFrame:RECT(10, 40, 60, 10)];
        //        ratingView
        ratingView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:ratingView];
        for (int i = 0; i < 3; i++) {
            UIImageView *   imView = [[UIImageView alloc]init];
//            imView.frame = RECT(15+CURRENT_CONTENT_WIDTH/3*i, 100, 90, 90);
            imView.tag = 10+i;
          
            imView.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:imView];
        }
    }
    
    backImageView= [[UIImageView alloc]init];
    backImageView.image = [UIImage imageNamed:@"line"];
    backImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:backImageView];

    _backText = [[UILabel alloc]init];
    _backText.font = [UIFont systemFontOfSize:12];
    _backText.numberOfLines = 0;
    _backText.textColor = [UIColor grayColor];
    [self.contentView addSubview:_backText];

    
    return self;
}
- (void)setdata:(NSDictionary *)dic
{

    NSString *isHasReviewsBack = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isHasReviewsBack"]];
    nameLabel.text  =  [dic objectForKey:@"customers_name"];
    timeLabel.text = [dic objectForKey:@"date_added"];
    NSString *str = [dic objectForKey:@"reviews_text"];
    NSString *imageName = [NSString stringWithFormat:@"pinglunxing%@",[dic objectForKey:@"reviews_rating"]];
    ratingView.image = [UIImage imageNamed:imageName];

    CGRect bounds = [str boundingRectWithSize:CGSizeMake(300, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    NSString *backStr = [dic objectForKey:@"reviews_back"];

    CGRect backbounds = [backStr boundingRectWithSize:CGSizeMake(300, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];

    textViewLabel.frame = RECT(15, 60, 290, bounds.size.height);
    textViewLabel.text =str;
    reviews_images = [dic objectForKey:@"reviews_images"];
    if (reviews_images.count !=0) {
        for (int i = 0; i < reviews_images.count; i++) {
            UIImageView *   imView1= (UIImageView *)[self viewWithTag:10+i];
            imView1.frame = RECT(15+CURRENT_CONTENT_WIDTH/3*i, bounds.size.height +70, 90, 90);
            imView1.contentMode = UIViewContentModeScaleAspectFit;
             imView1.userInteractionEnabled = YES;
            [imView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            imView1.tag = i;
            [imView1 sd_setImageWithURL:[NSURL URLWithString:reviews_images[i]]placeholderImage:[UIImage imageNamed:LoadingImage]];
        }
        
        if ([isHasReviewsBack isEqualToString:@"OK"]) {
            backImageView.frame = RECT(10, bounds.size.height +170, CURRENT_CONTENT_WIDTH, 1);
            
            _backText.frame = RECT(15, bounds.size.height +175, 290, backbounds.size.height);
            _backText.text = [NSString stringWithFormat:@"Reply:%@",backStr];
        }
        
        

    }else{
        
        if ([isHasReviewsBack isEqualToString:@"OK"]) {
            backImageView.frame = RECT(10, bounds.size.height +70, CURRENT_CONTENT_WIDTH, .5);
            _backText.frame = RECT(15, bounds.size.height +75, 290, backbounds.size.height);
            _backText.text = [NSString stringWithFormat:@"Reply:%@",backStr];

        }
        
    }
    
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
