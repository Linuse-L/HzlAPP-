//
//  NewRecCell.m
//  NewApp
//
//  Created by L on 16/4/26.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "NewRecCell.h"
#define BANDER_HIGHT 170
@implementation NewRecCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self viewInit];
    }
    return self;
}
- (void)viewInit
{
    _bannerImageView = [[UIImageView alloc]init];
    _bannerImageView.frame = RECT(0, 0, 320, BANDER_HIGHT);
    _bannerImageView.image = [UIImage imageNamed:@"tupian"];
    
    [self addSubview:_bannerImageView];
    
    
   }

- (void)setDataWith:(NSDictionary *)dic
{
    allDic = dic;
    [_bannerImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:LoadingImage]];
    NSArray *listArray = [[dic objectForKey:@"list"] objectForKey:@"data"];
    for (int i = 0; i< listArray.count; i++) {
        NSDictionary *dicList = listArray[i];
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[dicList objectForKey:@"Image"]] placeholderImage:[UIImage imageNamed:LoadingImage]];
        imageView.frame = RECT(10+100*i, BANDER_HIGHT + 30, 90, 90);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        UILabel *priceLabel = [[UILabel alloc]init];
        priceLabel.text = [dicList objectForKey:@"Price"];
        priceLabel.frame = RECT(10+100*i, BANDER_HIGHT+120, 90, 20);
        priceLabel.font = [UIFont systemFontOfSize:12];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:priceLabel];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = RECT(10+100*i, BANDER_HIGHT + 30, 90, 110);
        btn.tag = i;
        [btn addTarget:self action:@selector(pushDetails:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)pushDetails:(UIButton *)b
{
    NSLog(@"%ld",(long)b.tag);
    NSArray *listArray = [[allDic objectForKey:@"list"] objectForKey:@"data"];
    NSString *positionID = [listArray[b.tag] objectForKey:@"positionID"];
    self.detailsBlock(positionID);
    
}

- (void)Block:(PushDetailsBlock)block
{
    self.detailsBlock = block;
}
@end
