//
//  ProductViewController.h
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"

@interface ProductViewController : BaseVC<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSString *classid;
@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, strong) NSArray *searchArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *dataUrl;
@property (nonatomic, strong) NSString *ishome;

@end
