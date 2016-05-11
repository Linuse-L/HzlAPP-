//
//  LCountdownLabel.m
//  TimeLabel
//
//  Created by L on 15-2-3.
//  Copyright (c) 2015年 TimeLabel. All rights reserved.
//

#import "LCountdownLabel.h"

@implementation LCountdownLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _timeLabel = self;
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];    // Do any additional setup after loading the view.
    
    
    
}

- (void)timerFireMethod:(NSTimer *)timer
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:[_year intValue]];
    [components setMonth:[_month intValue]];
    [components setDay:[_day intValue]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    NSDate *fireDate = [calendar dateFromComponents:components];//目标时间
    
    NSDate *today = [NSDate date];//当前时间
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:fireDate options:0];//计算时间差
    if ([d second] < 0 || [d hour] < 0 ||[d minute] < 0 || [d day] < 0) {
        
//        _timeLabel.text = @" 00    00    00";//倒计时显示
        _timeLabel.text =@"";
        
    }else{
        
        //        _timeLabel.text =  [NSString stringWithFormat:@"%.2ld days %.2ld:%.2ld:%.2ld", (long)[d day], (long)[d hour], (long)[d minute], (long)[d second]];//倒计时显示
        _timeLabel.text = [NSString stringWithFormat:@" %.2ld     %.2ld    %.2ld", (long)[d hour]+((long)[d day]*24), (long)[d minute],(long)[d second]];//倒计时显示
        
        
        
    }
    
}









@end
