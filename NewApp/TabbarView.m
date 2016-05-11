//
//  TabbarView.m
//  NewApp
//
//  Created by L on 16/4/25.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "TabbarView.h"
#define Name_xNUM 25
#define ACTION_XNUM 142.5
#define NUM_Y 5
#define Color_LabelText [UIColor blackColor]
@implementation TabbarView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *backgroupImageView = [[UIImageView alloc]init];
        backgroupImageView.frame = RECT(0, -10, 320, 50);
        backgroupImageView.image = [UIImage imageNamed:@"roundTabbar"];
        [self addSubview:backgroupImageView];
        [self layoutView];
    }
    return self;
}
- (void)layoutView
{
    
    
    
    homeImageView = [[UIImageView alloc]init];
    homeImageView.image = [UIImage imageNamed:@"homeHightImage"];
    homeImageView.frame = RECT(30, NUM_Y, 20, 20);
    [self addSubview:homeImageView];
    
    UILabel * _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"HOME";
    _nameLabel.frame = RECT(30, Name_xNUM, 20, 20);
    _nameLabel.textColor = Color_LabelText;
    _nameLabel.font = [UIFont systemFontOfSize:6];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    
    
    
    UIImageView *actionImageView = [[UIImageView alloc]init];
    actionImageView.image = [UIImage imageNamed:@"actionImage"];
    actionImageView.frame = RECT(ACTION_XNUM, -8, 35, 35);
    [self addSubview:actionImageView];
    
    UILabel * action_nameLabel = [[UILabel alloc]init];
    action_nameLabel.text = @"ACTIVITY";
    action_nameLabel.frame = RECT(ACTION_XNUM, Name_xNUM, 35, 20);
    action_nameLabel.textColor = Color_LabelText;
    action_nameLabel.font = [UIFont systemFontOfSize:6];
    action_nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:action_nameLabel];
    
    
    meImageView = [[UIImageView alloc]init];
    meImageView.image = [UIImage imageNamed:@"meImage"];
    meImageView.frame = RECT(270, NUM_Y, 20, 20);
    [self addSubview:meImageView];
    
    UILabel * me_NameLabel = [[UILabel alloc]init];
    me_NameLabel.text = @"ME";
    me_NameLabel.frame = RECT(270, Name_xNUM, 20, 20);
    me_NameLabel.textColor = Color_LabelText;
    me_NameLabel.font = [UIFont systemFontOfSize:6];
    me_NameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:me_NameLabel];
    
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    homeBtn.frame = RECT(30, NUM_Y, 40, 40);
    homeBtn.layer.borderColor = [nav_Color CGColor];
    homeBtn.tag = 1;
    [homeBtn addTarget:self action:@selector(pushOtherVC:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:homeBtn];
    
    
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    actionBtn.frame = RECT(ACTION_XNUM, -5, 40, 40);
    actionBtn.layer.borderColor = [nav_Color CGColor];
    actionBtn.tag = 2;
    [actionBtn addTarget:self action:@selector(pushOtherVC:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:actionBtn];
    
    
    UIButton *meBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    meBtn.frame = RECT(270, NUM_Y, 40, 40);
    meBtn.layer.borderColor = [nav_Color CGColor];
    meBtn.tag = 3;
    [meBtn addTarget:self action:@selector(pushOtherVC:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:meBtn];
        

}



- (void)pushOtherVC:(UIButton *)b
{
    NSLog(@"%ld",(long)b.tag);
    [self.delegate touchBtnAtIndex:b.tag];
    if (b.tag == 3) {
        meImageView.image = [UIImage imageNamed:@"meHightImage"];
        homeImageView.image = [UIImage imageNamed:@"homeImage"];

    }else if(b.tag == 1){
        meImageView.image = [UIImage imageNamed:@"meImage"];
        homeImageView.image = [UIImage imageNamed:@"homeHightImage"];

    }else{
        homeImageView.image = [UIImage imageNamed:@"homeImage"];
        meImageView.image = [UIImage imageNamed:@"meImage"];

    }
}

-(void)touchBtnAtIndex:(NSInteger)index
{
    
}

- (void)remove
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
