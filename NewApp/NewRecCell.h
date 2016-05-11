//
//  NewRecCell.h
//  NewApp
//
//  Created by L on 16/4/26.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PushDetailsBlock) (NSString *a);

@interface NewRecCell : UITableViewCell
{
    NSDictionary *allDic;
}
@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, copy) PushDetailsBlock detailsBlock;
- (void)setDataWith:(NSDictionary *)dic;
- (void)Block:(PushDetailsBlock)block;

@end
