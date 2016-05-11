//
//  NewProductViewController.h
//  NewApp
//
//  Created by L on 16/4/26.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "BaseVC.h"
#import "ListCell.h"
#import "ScreeningView.h"
#import "NewBanCell.h"
#import "DetailsViewController.h"
#import "My_FlowLayout.h"
#import "H_ReusableView.h"
#import "ReusableView.h"
@interface NewProductViewController : BaseVC<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *allDicArray;
    //筛选数组源数据
    NSString *apiLink;
    NSArray *sortbyArr;
    NSArray *taglistArr;
    NSArray *classListArr;
    NSString *sendVal;
    NSString *tag_id;
    NSInteger page;
    BOOL panduan;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSString *linkUrlStr;
@property (nonatomic, strong)NSString *classid;

@end
