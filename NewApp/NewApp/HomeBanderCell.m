//
//  HomeBanderCell.m
//  NewApp
//
//  Created by L on 15/9/23.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "HomeBanderCell.h"

@implementation HomeBanderCell

@synthesize titleLabel,productImageView,productLabel,bigImageView,searchBarView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_DEVICE_WIDTH, 180*iphone_HIGHT)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = YES;
        [self addSubview:self.scrollView];
        
        

        bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, self.scrollView.frame.size.height)];
        bigImageView.image = [UIImage imageNamed:@"29.jpg"];
        [self.scrollView addSubview:bigImageView];
            
}
    
    
    return self;
}


- (void)bannerData:(NSDictionary *)dataDic
{
//    BannerArray = dataArray;
//    self.scrollView.contentSize = CGSizeMake(CURRENT_DEVICE_WIDTH*dataArray.count, 130*iphone_HIGHT);
//    for (int i = 0; i<dataArray.count; i++) {
//        NSString *imageUrl =[NSString stringWithFormat:@"%@",[[dataArray objectAtIndex:i] objectForKey:@"imageUrl"]];
//      UIImageView *  bennerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CURRENT_DEVICE_WIDTH*i, 0, CURRENT_CONTENT_WIDTH, self.scrollView.frame.size.height)];
//        [bennerImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:LoadingImage]];
//        [self.scrollView addSubview:bennerImageView];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//        button.frame =CGRectMake(CURRENT_DEVICE_WIDTH*i, 0, CURRENT_CONTENT_WIDTH, self.scrollView.frame.size.height);
//        button.tag = i;
//        [button addTarget:self action:@selector(pushProduct:) forControlEvents:UIControlEventTouchUpInside];
//        [self.scrollView addSubview:button];
//    }
    [bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:LoadingImage]];
    

}
- (void)Category
{
    NSLog(@"分类");
    [MobClick event:@"homecategory"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushCategory" object:nil];
}
//搜索代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [MobClick event:@"homesearch"];
    if (![self isBlankString:searchBar.text]) {
        [searchBar resignFirstResponder];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
//        NSString *text = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
        [dic setObject:searchBar.text forKey:@"searchkeyword"];
        [dic setObject:@"0" forKey:@"page"];
        [LORequestManger POST:getSearchResult_URL params:dic URl:nil success:^(id response) {
            
            NSString *status = [response objectForKey:@"status"];
            if ([status isEqualToString:@"OK"]) {
                [SVProgressHUD dismiss];
                NSLog(@"%@",response);
                NSArray *array = [response objectForKey:@"data"];
                ProductViewController *productVC = [[ProductViewController alloc]init];
                productVC.searchArray = array;
                productVC.isSearch = YES;
                
                AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appdelegate.naVC pushViewController:productVC animated:YES];
            }else{
                NSString *data = [NSString stringWithFormat:@"%@",[response objectForKey:@"data"]];
                [SVProgressHUD dismissWithError:data];
                NSLog(@"%@",response);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }else {
        [SVProgressHUD showErrorWithStatus:@"Please enter the content"];
    }
}

- (BOOL)isBlankString:(NSString *)string{
    
    
    
    if (string == nil) {
        
        return YES;
        
    }
    
    
    
    if (string == NULL) {
        
        return YES;
        
    }
    
    
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

- (void)pushProduct:(UIButton *)btn
{
    NSLog(@"%ld",(long)btn.tag);
    [MobClick event:@"homebanner"];
    NSDictionary *dic = [BannerArray objectAtIndex:btn.tag];
    NSString *code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
    if (![code isEqualToString:@"false"]) {
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        ProductViewController *productVC = [[ProductViewController alloc]init];
            productVC.classid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"val"]];
            productVC.title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cname"]];
        [appdelegate.naVC pushViewController:productVC animated:YES];
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
