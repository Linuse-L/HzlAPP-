//
//  NewDetailSImageCell.h
//  NewApp
//
//  Created by L on 16/3/17.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewVC.h"
@interface NewDetailSImageCell : UITableViewCell
{
    UIButton *moreBtn ;
    NSString *detailUrl;
    UIWebView * webView;
    UILabel * moreLabel;
    NSString *producy_id;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *fistLabel;
@property (nonatomic, strong) UILabel *twolabel;
@property (nonatomic, strong) UILabel *reviewsLabel;
@property (nonatomic, strong) UIImageView *shipImageView ;

- (void)reviewWith:(NSDictionary *)dic;


@end
