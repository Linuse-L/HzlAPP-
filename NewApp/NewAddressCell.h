//
//  NewAddressCell.h
//  NewApp
//
//  Created by 黄权浩 on 15/10/20.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;
- (void)setDic:(NSDictionary *)dic;

@end
