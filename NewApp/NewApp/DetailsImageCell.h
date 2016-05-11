//
//  DetailsImageCell.h
//  NewApp
//
//  Created by L on 15/9/18.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BuyBlock) (void);
typedef void (^PushIndex) (NSString *a);

@interface DetailsImageCell : UITableViewCell<UIScrollViewDelegate>
{
    UIPageControl *page;
    NSArray *otherImages;
    UIView *linView ;
    UIImageView *collectionImageView;
    UILabel * reviewsLabel ;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oldPriceLabel;
@property (nonatomic, strong) UILabel *allOrderLabel;
@property (nonatomic, strong) UIImageView *giftImageView;
@property (nonatomic, strong) BuyBlock buyBlock;
@property (nonatomic, strong) PushIndex PushIndex;
- (void)PushIndex:(PushIndex)block;
- (void)buyBlock:(BuyBlock)block;
- (void)setData:(NSDictionary *)dic;

@end
