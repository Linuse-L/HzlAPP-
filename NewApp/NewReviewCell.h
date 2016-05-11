//
//  NewReviewCell.h
//  NewApp
//
//  Created by L on 16/4/11.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJPhotoBrowser.h"

@interface NewReviewCell : UITableViewCell
{
    NSArray *reviews_images;
    UIImageView *backImageView;
    UIImageView *reviewImageView;
}
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *ratingLabel;
@property (nonatomic, strong) UILabel *textViewLabel;
@property (nonatomic, strong) UIImageView *ratingView;

@property (nonatomic, strong) UILabel *backText;
@property (nonatomic, strong) UILabel *reviews_back;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *fistLabel;
@property (nonatomic, strong) UILabel *twolabel;
@property (nonatomic, strong) UILabel *reviewsLabel;
@property (nonatomic, strong) UIImageView *shipImageView ;

@property (nonatomic, strong) UILabel *allNumLabel;

- (void)setdata:(NSDictionary *)dic;

+ (CGFloat)heightForStudent:(NSDictionary *)dic;

@end
