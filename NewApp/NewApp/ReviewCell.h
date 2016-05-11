//
//  ReviewCell.h
//  NewApp
//
//  Created by L on 15/9/24.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell
{
    NSArray *reviews_images;
    UIImageView *backImageView;
}
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *ratingLabel;
@property (nonatomic, strong) UILabel *textViewLabel;
@property (nonatomic, strong) UIImageView *ratingView;

@property (nonatomic, strong) UILabel *backText;
@property (nonatomic, strong) UILabel *reviews_back;

- (void)setdata:(NSDictionary *)dic;

+ (CGFloat)heightForStudent:(NSDictionary *)dic;

@end
