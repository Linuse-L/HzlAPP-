//
//  LAlertView.h
//  StudyAbroad
//
//  Created by L on 15/6/21.
//  Copyright (c) 2015年 Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LAlertViewDelegate;

@interface LAlertView : UIView
{
    CGFloat contentViewWidth;
    CGFloat contentViewHeight;
}
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (weak, nonatomic) id<LAlertViewDelegate> delegate;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *buttonTitleArray;
- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message delegate:(id<LAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (void)show;

- (void)hide;

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size;

- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index;

@end
//代理
@protocol LAlertViewDelegate <NSObject>

- (void)alertView:(LAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end