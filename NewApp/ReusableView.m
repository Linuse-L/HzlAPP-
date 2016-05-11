//
//  ReusableView.m
//  NewApp
//
//  Created by L on 16/5/6.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "ReusableView.h"

@implementation ReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:self.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

@end
