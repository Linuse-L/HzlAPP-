//
//  HomeCategortyCell.h
//  NewApp
//
//  Created by L on 16/4/25.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCategortyCell : UITableViewCell
{
    NSDictionary *allDic;
}
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)allImageWith:(NSDictionary *)dic;

@end
