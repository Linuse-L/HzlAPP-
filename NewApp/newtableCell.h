//
//  newtableCell.h
//  Dragon
//
//  Created by 黄权浩 on 15-1-16.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newtableCell : UITableViewCell
//第一个cell改变坐标
@property (weak, nonatomic) IBOutlet UIImageView *dian;
@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;

//用于接收数据
- (void)setdic:(NSDictionary *)dic setvalue:(int)value;
@end
