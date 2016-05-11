//
//  WalletCell.h
//  NewApp
//
//  Created by L on 15/9/28.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnStringBlock)(NSString *boolstr);

@interface WalletCell : UITableViewCell
{
    BOOL isSelect;
    UILabel *subtotalLabel;
    NSString *couponStr;
}

@property (nonatomic, copy) ReturnStringBlock returnTextBlock;
- (void)returnText:(ReturnStringBlock)block;

@end
