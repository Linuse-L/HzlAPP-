//
//  WalletCell.m
//  NewApp
//
//  Created by L on 15/9/28.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "WalletCell.h"

@implementation WalletCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        subtotalLabel = [[UILabel alloc]init];
        subtotalLabel.frame = RECT(10, 5, 150, 30);
        couponStr = @"$0.00";
        subtotalLabel.text = [NSString stringWithFormat:@"Account Wallet:%@",couponStr];
        subtotalLabel.font = [UIFont systemFontOfSize:13];
        subtotalLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:subtotalLabel];
        
        
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        editBtn.frame = RECT(CURRENT_CONTENT_WIDTH - 60, 5, 50, 30);
        [editBtn setBackgroundImage:[UIImage imageNamed:@"closeBtn"] forState:UIControlStateNormal];

        [editBtn addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
        isSelect = NO;
        [self addSubview:editBtn];
        }
    return  self;
}

- (void)returnText:(ReturnStringBlock)block
{
    self.returnTextBlock = block;
}

- (void)editAddress:(UIButton *)btn
{
    
    if (!isSelect) {
        [btn setBackgroundImage:[UIImage imageNamed:@"openBtn"] forState:UIControlStateNormal];
        isSelect = !isSelect;
        if (self.returnTextBlock != nil) {
            self.returnTextBlock(@"1");
        }
        NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [LORequestManger POST:coupon_url params:dic URl:nil success:^(id response) {
            [SVProgressHUD dismiss];
            NSString *status =[response objectForKey:@"status"];
            if ([status isEqualToString:@"OK"]) {
                NSDictionary *dic  = [response objectForKey:@"data"];
//                NSArray *couponarr = [dic objectForKey:@"couponList"];
                couponStr = [dic objectForKey:@"total"];
                subtotalLabel.text = [NSString stringWithFormat:@"Account Wallet:%@",couponStr];
            }else{
                couponStr = @"$0.00";
                subtotalLabel.text = [NSString stringWithFormat:@"Account Wallet:%@",couponStr];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"closeBtn"] forState:UIControlStateNormal];
        isSelect = !isSelect;
        if (self.returnTextBlock != nil) {
            self.returnTextBlock(@"0");
        }
    }
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
