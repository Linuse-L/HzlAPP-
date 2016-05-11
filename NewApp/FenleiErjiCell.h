//
//  FenleiErjiCell.h
//  Dragon
//
//  Created by 黄权浩 on 15/8/18.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FenleiErjiCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
- (void)name:(NSDictionary *)dic;

@end
