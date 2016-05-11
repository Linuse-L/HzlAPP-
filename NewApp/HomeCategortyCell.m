//
//  HomeCategortyCell.m
//  NewApp
//
//  Created by L on 16/4/25.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "HomeCategortyCell.h"

@implementation HomeCategortyCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UIImageView *lineImage1 = [[UIImageView alloc]init];
        lineImage1.backgroundColor = [UIColor redColor];
        lineImage1.frame = RECT(5, 8, 1, 15);
        [self addSubview:lineImage1];

        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"Bags";
        _nameLabel.frame = RECT(10, 5, 300, 20);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nameLabel];
        
        
        UIImageView *lineImage = [[UIImageView alloc]init];
        lineImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
        lineImage.frame = RECT(10, 30, 310, .5);
        [self addSubview:lineImage];
        
        
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = RECT(0, 30, 320, 120);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
//        for (int i = 0; i< 6; i++) {
//            UIImageView *imageView = [[UIImageView alloc]init];
//            imageView.frame = RECT(5 + 95*i, 10, 90, 90);
//            imageView.image = [UIImage imageNamed:@"bagsImage"];
//            [_scrollView addSubview:imageView];
//            
//        }
//        _scrollView.contentSize = CGSizeMake(95*6, 120);

    }
    return self;
}

- (void)allImageWith:(NSDictionary *)dic
{
    allDic = dic;
    NSArray *array = [dic objectForKey:@"sonList"];
    for (int i = 0; i< array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = RECT(5 + 95*i, 10, 90, 90);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[array[i] objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:LoadingImage]];
        [_scrollView addSubview:imageView];
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
        b.frame =RECT(5 + 95*i, 10, 90, 90);
        b.tag = i;
        [b addTarget:self action:@selector(PushAllCategory:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:b];
        
    }
    _scrollView.contentSize = CGSizeMake(95*array.count +10, 120);
    _nameLabel.text = [dic objectForKey:@"name"];

}


- (void)PushAllCategory:(UIButton *)b
{
    NSArray *array = [allDic objectForKey:@"sonList"];

    NSDictionary *dictionary = array[b.tag];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushCategory" object:dictionary];

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
