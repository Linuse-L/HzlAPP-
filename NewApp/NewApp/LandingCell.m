//
//  LandingCell.m
//  NewApp
//
//  Created by L on 15/9/27.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "LandingCell.h"

@implementation LandingCell

{
    @private
    UIImageView *headerImageView;
}

@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        headerImageView = [[UIImageView alloc]init];
        headerImageView.frame = RECT(10, 5, 50, 50);
        headerImageView.clipsToBounds = YES;
        headerImageView.layer.cornerRadius = 25;
        headerImageView.contentMode = UIViewContentModeScaleAspectFit;
        headerImageView.image = [UIImage imageNamed:@"headerImage"];
        
        [self addSubview:headerImageView];
        
        // 头像按钮
        UIButton *headerImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        headerImageButton.frame = RECT(10, 5, 50, 50);
        [headerImageButton addTarget:self action:@selector(headerBtClick) forControlEvents:UIControlEventTouchUpInside];
        headerImageButton.backgroundColor = [UIColor clearColor];
        [self addSubview:headerImageButton];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.numberOfLines = 0;
        titleLabel.frame = RECT(70, 0, CURRENT_CONTENT_WIDTH - 60, 60);
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)returnText:(ReturnStringBlock)block
{
    self.returnTextBlock = block;
}

- (void)headerBtClick
{
    if (headerImageView != nil) {
        if (self.returnTextBlock != nil) {
            self.returnTextBlock();
        }
    }
}

- (void)signout
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"signOut" object:nil];

}
- (void)setData:(NSDictionary *)dic
{
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    NSString *str = [d objectForKey:@"image"];
    [d synchronize];
    if (str != nil) {
        NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:str];
        UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
        headerImageView.image = _decodedImage;
    }
    titleLabel.text = [dic objectForKey:@"useremail"];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
