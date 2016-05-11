//
//  SelectView.h
//  NewApp
//
//  Created by L on 15/9/23.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SizeInfoBlock)(NSDictionary *dic);

@interface SelectView : UIView
{
    UIScrollView *scrollView;
    NSDictionary *sizeDic;
    NSDictionary *colorDic;
    UIScrollView *btnView;
    UIScrollView *colorViewl;
    UIImageView  *colorselectImage;
    NSArray *selectOptionArray;
    NSMutableArray *imageArray;
    NSMutableArray *productsIDArray;
    NSString *productsID;
    NSMutableArray *priceArray;
    NSMutableArray *sizeArray;
    UILabel * priceLabel;
    BOOL chooseSize;
}
@property (strong, nonatomic) UIButton * tmpBtn;
@property (nonatomic, strong) NSArray * sizeArray;
@property (nonatomic, strong) SizeInfoBlock sizeinfoblock;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, assign) BOOL colorbool;
@property (nonatomic, assign) BOOL sizebool;
@property (nonatomic, strong) NSArray *sizeinfoArray;
//修改通知问题
- (void)sizeInfo:(SizeInfoBlock)block;
- (void)show;
- (void)close;
- (void)setBtn;

@end
