//
//  NewtableheaderView.m
//  Dragon
//
//  Created by 黄权浩 on 15-1-16.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import "NewtableheaderView.h"

@implementation NewtableheaderView

//重写init方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"headerView" owner:self options:nil];
        self = [nib objectAtIndex:0];
        self.frame = CGRectMake(0, 0, 320, 70);
    }
    return self;
}

- (void)setdic:(NSString *)str
{
    _yundanhao.text = str;
}

@end
