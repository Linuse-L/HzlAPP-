//
//  FenleiErjiCell.m
//  Dragon
//
//  Created by 黄权浩 on 15/8/18.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import "FenleiErjiCell.h"

@implementation FenleiErjiCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)name:(NSDictionary *)dic
{
    self.name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:LoadingImage]];
}
@end
