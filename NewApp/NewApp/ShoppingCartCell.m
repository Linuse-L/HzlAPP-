//
//  ShoppingCartCell.m
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "DetailsViewController.h"
#import "AppDelegate.h"

#define X 110
@implementation ShoppingCartCell
@synthesize priceLabel,titleLabel,productImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        productImageView = [[UIImageView alloc]init];
//        productImageView.contentMode = UIViewContentModeScaleAspectFit;
        productImageView.frame = RECT(5, 10, 100, 100);
        productImageView.image = [UIImage imageNamed:@"1.jpg"];
        productImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:productImageView];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.frame = RECT(X, 0, CURRENT_CONTENT_WIDTH-40, 30);
        titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:titleLabel];
        
        _sizeLabel = [[UILabel alloc]init];
        _sizeLabel.frame = RECT(X, 45, CURRENT_CONTENT_WIDTH-150, 30);
        _sizeLabel.textColor = [UIColor grayColor];
        _sizeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_sizeLabel];
        
        priceLabel = [[UILabel alloc]init];
        priceLabel.frame = RECT(X, 25, 90, 30);
        priceLabel.textColor = Btn_Color;
//        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:priceLabel];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"cartAdd_image"];
        imageView.frame = RECT(X, 80, 93, 23);
        [self addSubview:imageView];
        for (int i = 0; i<2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = RECT(X+60*i,80,30,20);
            btn.tag = i;
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(editCart:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = RECT(CURRENT_CONTENT_WIDTH-30,82,30,30);
//        [btn setBackgroundImage:[UIImage imageNamed:@"remove"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        UIImageView *removeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 13)];
        removeImageView.image =[UIImage imageNamed:@"remove"];
        [btn addSubview:removeImageView];
        
        _numLabel = [[UILabel alloc]init];
        _numLabel.frame = RECT(X, 82, 90, 20);
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.text = [NSString stringWithFormat:@"%d",num];
        _numLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_numLabel];
  
        UIButton *pushdetailBt = [UIButton buttonWithType:UIButtonTypeCustom];
        pushdetailBt.frame = productImageView.frame;
        [pushdetailBt addTarget:self action:@selector(pushDetail) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:pushdetailBt];
    }
        return self;
}


- (void)editCart:(UIButton *)btn
{
    if (btn.tag == 0) {
        NSLog(@"-");
        if (num == 1) {
            num =1;
        }else{
            num--;
        }
        _numLabel.text = [NSString stringWithFormat:@"%d",num];
    }else{
        NSLog(@"+");
        num++;
        _numLabel.text = [NSString stringWithFormat:@"%d",num];
    }
    
    if (self.changenumber != nil) {
        if ([_hascolor isEqualToString:@"OK"]) {
            NSDictionary *dic = @{@"productnumber": [NSString stringWithFormat:@"%d", num], @"productid":_productid,@"sizecanshu":_sizeCanshu,@"sizeZhi":_sizeZhi,@"hascolor":_hascolor,@"colorcanshu":_colorCanshu, @"colorZhi":_colorZhi};
            self.changenumber(dic);
        }else {
            NSDictionary *dic = @{@"productnumber": [NSString stringWithFormat:@"%d", num], @"productid":_productid,@"sizecanshu":_sizeCanshu,@"sizeZhi":_sizeZhi,@"hascolor":_hascolor};
            self.changenumber(dic);
        }
    }
}

- (void)pushDetail
{
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    detailsVC.positionID = _newproductid;
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.naVC pushViewController:detailsVC animated:YES];
}

- (void)changeNumber:(changeNumber)block
{
    self.changenumber = block;
}

- (void)setValue:(NSDictionary *)dic
{
    cartInfoDic =dic;
    _hascolor = [dic objectForKey:@"ishascolor"];
    _hassize  = [dic objectForKey:@"ishassize"];
    _hasgift  = [dic objectForKey:@"isGift"];
    NSDictionary *sizeInfoDic = [dic objectForKey:@"sizeInfo"];
    NSDictionary *sizedic     = [[NSDictionary alloc] init];
    NSDictionary *colordic     = [[NSDictionary alloc] init];
    if ([_hassize isEqualToString:@"OK"]) {
        sizedic = [sizeInfoDic objectForKey:@"size"];
        _sizeLabel.text = [NSString stringWithFormat:@"%@",[sizedic objectForKey:@"selectOptionDisplay"]];
    }else {
        _sizeLabel.text = @"";
    }
    if ([_hascolor isEqualToString:@"OK"]) {
        colordic = [sizeInfoDic objectForKey:@"color"];
        _colorCanshu = [NSString stringWithFormat:@"%@",[colordic objectForKey:@"selectOptionNameForForm"]];
        _colorZhi =[NSString stringWithFormat:@"%@",[colordic objectForKey:@"selectOptionValue"]];
    }
    [productImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"productImage"]]];
    titleLabel.text = [dic objectForKey:@"productName"];
    priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"productPrice"]];
    _numLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"qty"]] ;
    NSString *numStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"qty"]];
    num = [numStr intValue];
    _productid = [NSString stringWithFormat:@"%@", [dic objectForKey:@"productID"]];
    _newproductid = [NSString stringWithFormat:@"%@", [dic objectForKey:@"pid"]];
    _sizeCanshu = [NSString stringWithFormat:@"%@",[sizedic objectForKey:@"selectOptionNameForForm"]];
    _sizeZhi =[NSString stringWithFormat:@"%@",[sizedic objectForKey:@"selectOptionValue"]];
}

- (void)remove
{
    NSLog(@"删除");
//    LAlertView *alerView = [[LAlertView alloc]initWithTitle:@"Are you sure?" icon:nil message:@"Do you want to remove this from your shopping cart" delegate:self buttonTitles:@"NO",@"YES", nil];
//    [alerView show];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"Do you want to remove this from your shopping cart" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex == 1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"deleteProduct" object:cartInfoDic];
    }
}
//
//- (void)alertView:(LAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"%ld",(long)buttonIndex);
//    if (buttonIndex == 1) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"deleteProduct" object:cartInfoDic];
//    }
//}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
