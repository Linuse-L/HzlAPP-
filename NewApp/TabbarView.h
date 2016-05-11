//
//  TabbarView.h
//  NewApp
//
//  Created by L on 16/4/25.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol My_tabbarDelegete <NSObject>
-(void)touchBtnAtIndex:(NSInteger)index;
@end

@interface TabbarView : UIView<My_tabbarDelegete>
{
    UIImageView *homeImageView;
    UIImageView *meImageView ;
}
@property (nonatomic,assign) id<My_tabbarDelegete>delegate;

- (void)remove;

@end
