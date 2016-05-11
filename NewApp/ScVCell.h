//
//  ScVCell.h
//  NewApp
//
//  Created by 黄权浩 on 15/12/2.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb;
- (void)setDic:(NSDictionary *)dic;

@end
