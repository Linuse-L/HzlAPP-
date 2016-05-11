//
//  newtableCell.m
//  Dragon
//
//  Created by 黄权浩 on 15-1-16.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import "newtableCell.h"

@implementation newtableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setdic:(NSDictionary *)dic setvalue:(int)value
{
    if (value == 0) {
        _dian.image = [UIImage imageNamed:@"sneak_query_red"];
        _name.text = [dic objectForKey:@"context"];
        NSString *data = [dic objectForKey:@"time"];
        _time.text = [NSString stringWithFormat:@"%@", data];
        _name.textColor = [UIColor darkGrayColor];
        _time.textColor = [UIColor darkGrayColor];
    }else{
        NSLog(@"dic%@", dic);
        _name.text = [dic objectForKey:@"context"];
        NSString *data = [dic objectForKey:@"time"];
        _time.text = [NSString stringWithFormat:@"%@ ",data];
    }
}

@end
