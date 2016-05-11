//
//  CurrencyCell.h
//  NewApp
//
//  Created by 黄权浩 on 15/10/19.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
- (void)setDic:(NSDictionary *)dic;

@end
