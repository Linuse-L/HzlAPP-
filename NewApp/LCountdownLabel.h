//
//  LCountdownLabel.h
//  TimeLabel
//
//  Created by L on 15-2-3.
//  Copyright (c) 2015年 TimeLabel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCountdownLabel : UILabel

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *day;

@end
