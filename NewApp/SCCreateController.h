//
//  SCCreateController.h
//  Dragon
//
//  Created by 黄权浩 on 15/8/17.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import "BaseVC.h"
#import "FenleiErjiCell.h"

@interface SCCreateController : BaseVC<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *yijifenlei;
@property (nonatomic, assign) NSInteger index;

@end
