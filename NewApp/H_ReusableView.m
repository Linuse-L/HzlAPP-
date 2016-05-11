//
//  H_ReusableView.m
//  NewApp
//
//  Created by L on 16/5/6.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "H_ReusableView.h"

@implementation H_ReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setLabel];
    }
    return self;
}

- (void)setLabel
{
    
    UIView *view = [[UIView alloc]init];
    view.frame = RECT(0, 0, 320, 30);
    view.backgroundColor = [UIColor blackColor];
    [self addSubview:view];
    UIImageView *viewImageView = [[UIImageView alloc]init];
    
    viewImageView.image = [UIImage imageNamed:@"saixuanbeijing"];
    viewImageView.frame = RECT(0, 0, 320, 30);
    [view addSubview:viewImageView];
    NSArray *array = @[@"Sort",@"Category",@"Filter"];
    for (int i = 0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame =CGRectMake((CURRENT_DEVICE_WIDTH/3)*i, 0, CURRENT_DEVICE_WIDTH/3,30);
        button.tag = i;
        //        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTintColor:[UIColor blackColor]];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button addTarget:self action:@selector(shaixuan:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        
        //    标题
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = array[i];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.tag = 10+i;
        titleLabel.frame = CGRectMake((CURRENT_DEVICE_WIDTH/3)*i +30, 0, 100, 30);
        titleLabel.font = [UIFont systemFontOfSize:10];
        if (i == 0) {
            titleLabel.textColor = [UIColor redColor];
        }
        [viewImageView addSubview:titleLabel];
        
        
    }

}

- (void)shaixuan:(UIButton *)b
{
    NSString *sender = [NSString stringWithFormat:@"%ld",(long)b.tag];
    for (int i = 0; i < 3; i++) {
        UILabel * titleLabel = [self viewWithTag:10+i];
        if (i == b.tag) {
            titleLabel.textColor = [UIColor redColor];
        }else{
            titleLabel.textColor = [UIColor blackColor];
            
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"screenView" object:sender];

}

@end
