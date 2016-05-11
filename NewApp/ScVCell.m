//
//  ScVCell.m
//  NewApp
//
//  Created by 黄权浩 on 15/12/2.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "ScVCell.h"

@implementation ScVCell

- (void)setDic:(NSDictionary *)dic
{
    self.lb.text = [dic objectForKey:@"className"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
