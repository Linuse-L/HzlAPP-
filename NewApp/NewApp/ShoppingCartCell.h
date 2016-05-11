//
//  ShoppingCartCell.h
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAlertView.h"

typedef void(^changeNumber)(NSDictionary *number);

@interface ShoppingCartCell : UITableViewCell<LAlertViewDelegate, UIAlertViewDelegate>
{
    int num;
    NSDictionary *cartInfoDic;
    
}

@property (nonatomic, copy) changeNumber changenumber;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *productImageView;;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, copy) NSString *productid;
@property (nonatomic, copy) NSString *newproductid;
@property (nonatomic, copy) NSString *sizeCanshu;
@property (nonatomic, copy) NSString *sizeZhi;
@property (nonatomic, copy) NSString *colorCanshu;
@property (nonatomic, copy) NSString *colorZhi;
@property (nonatomic, copy) NSString *hascolor;
@property (nonatomic, copy) NSString *hassize;
@property (nonatomic, copy) NSString *hasgift;
- (void)setValue:(NSDictionary *)dic;
- (void)changeNumber:(changeNumber)block;

@end
