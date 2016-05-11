//
//  ClassCell.m
//  NewApp
//
//  Created by L on 15/9/23.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "ClassCell.h"

@implementation ClassCell
@synthesize titleLabel,productImageView,productLabel,bigImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"New SHOES";
        titleLabel.numberOfLines = 0;
        titleLabel.frame = CGRectMake(10, 0, CURRENT_DEVICE_WIDTH - 20, 30);
        titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:titleLabel];
        
        bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, CURRENT_CONTENT_WIDTH, 130*iphone_HIGHT)];
        bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        bigImageView.image = [UIImage imageNamed:@"banner3"];
        [self addSubview:bigImageView];
        
        for (int i = 0; i<3; i++) {
            UIImageView *ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5+(CURRENT_DEVICE_WIDTH/3)*i, bigImageView.frame.size.height + 40, CURRENT_DEVICE_WIDTH/3-15,80*iphone_HIGHT)];
            ImageView.image = [UIImage imageNamed:@"banner3"];
            ImageView.tag = 10+i;
            ImageView.contentMode = UIViewContentModeScaleAspectFit;

            [self addSubview:ImageView];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame =CGRectMake(5+(CURRENT_DEVICE_WIDTH/3)*i, bigImageView.frame.size.height + 25, CURRENT_DEVICE_WIDTH/3-15,110);
//            button.layer.borderWidth = .5;
            button.layer.borderColor = [nav_Color CGColor];
            button.tag = i;
            [button addTarget:self action:@selector(pushDetail:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
        }
        
    }
    
    
    return self;
}

- (void)requestData:(NSDictionary *)dic
{
    [MobClick event:@"homecategorybanner"];
    NSArray *listArray = [[dic objectForKey:@"list"] objectForKey:@"data"];
    dataArray = listArray;
    [bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:LoadingImage]];
    titleLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
    for (int i = 0; i<listArray.count; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:i+10];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[listArray objectAtIndex:i] objectForKey:@"Image"]]] placeholderImage:[UIImage imageNamed:LoadingImage]];

    }
}

- (void)pushDetail:(UIButton *)btn
{
    NSLog(@"%ld",(long)btn.tag);
    [MobClick event:@"homecategoryproduct"];
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    detailsVC.positionID =[[dataArray objectAtIndex:btn.tag] objectForKey:@"positionID"];
//    detailsVC.positionID = @"19487";
    [appdelegate.naVC pushViewController:detailsVC animated:YES];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
