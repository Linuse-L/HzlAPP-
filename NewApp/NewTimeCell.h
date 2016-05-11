//
//  NewTimeCell.h
//  NewApp
//
//  Created by L on 16/4/26.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCountdownLabel.h"
typedef void (^timePushDetailsBlock) (NSString *a);

@interface NewTimeCell : UITableViewCell
{
    UIScrollView *scrollView;
    NSArray *allArray;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *saleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) LCountdownLabel *timeLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, copy) timePushDetailsBlock time_Block;
- (void)dataWith:(NSArray *)array;
- (void)Block:(timePushDetailsBlock)block;

@end
