//
//  NewBanCell.m
//  NewApp
//
//  Created by L on 16/4/28.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "NewBanCell.h"
#define CELL_HIGHT 150
@implementation NewBanCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = RECT(0, 0, 320, CELL_HIGHT);
        [self addSubview:scrollView];
        UIImageView * ImageView = [[UIImageView alloc]init];
        ImageView.frame = RECT(0, 0, 320, 150);
        //    timeImageView.contentMode = UIViewContentModeScaleAspectFit;
        ImageView.image = [UIImage imageNamed:@"pbl"];
        [scrollView addSubview:ImageView];
        
        
        
    }
    return self;
}
@end
