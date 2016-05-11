//
//  SelectView.m
//  NewApp
//
//  Created by L on 15/9/23.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "SelectView.h"
#import "CartViewController.h"
@implementation SelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setBtn
{
    chooseSize = NO;
    //数据处理
    imageArray = [NSMutableArray array];
    priceArray = [NSMutableArray array];
    sizeArray  = [NSMutableArray array];
    productsIDArray = [NSMutableArray array];
    for (int i = 0; i<_sizeinfoArray.count; i++) {
        NSDictionary *dic = _sizeinfoArray[i];
        [imageArray addObject:[dic objectForKey:@"productsImage"]];
        [priceArray addObject:[dic objectForKey:@"productsPrice"]];
        [sizeArray addObject:[dic objectForKey:@"sizeInfo"]];
        [productsIDArray addObject:[dic objectForKey:@"productsID"]];
        if ([[dic objectForKey:@"isHasSize"]isEqualToString:@"OK"]) {
            _sizebool = YES;
        }else {
            _sizebool = NO;
        }
    }
    productsID = productsIDArray[0];
    UIView *gestView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    gestView.backgroundColor = [UIColor clearColor];
    [self addSubview:gestView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
    [gestView addGestureRecognizer:tap];
    
    if (_sizebool) {
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CURRENT_CONTENT_HEIGHT - 300, CURRENT_CONTENT_WIDTH, 300)];
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"Price:";
        titleLabel.numberOfLines = 0;
        titleLabel.frame = CGRectMake(10, 10, CURRENT_DEVICE_WIDTH - 20, 20);
        titleLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:titleLabel];
        
        priceLabel = [[UILabel alloc]init];
        priceLabel.text = priceArray[0];
        priceLabel.numberOfLines = 0;
        priceLabel.textColor = Btn_Color;
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.frame = CGRectMake(CURRENT_DEVICE_WIDTH - 220, 10, 200, 20);
        priceLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:priceLabel];
        
        UILabel *colorLabel = [[UILabel alloc]init];
        colorLabel.text = @"Color:";
        colorLabel.numberOfLines = 0;
        colorLabel.frame = CGRectMake(10, 60, CURRENT_DEVICE_WIDTH - 20, 20);
        colorLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:colorLabel];
        
        UILabel *sizeLabel = [[UILabel alloc]init];
        sizeLabel.text = @"Size:";
        sizeLabel.numberOfLines = 0;
        sizeLabel.backgroundColor = [UIColor clearColor];
        sizeLabel.frame = CGRectMake(10, 160, CURRENT_DEVICE_WIDTH - 20, 20);
        sizeLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:sizeLabel];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        addBtn.frame = CGRectMake(10, scrollView.frame.size.height - 60, CURRENT_CONTENT_WIDTH-20, 40);
        [addBtn setTitle:[NSString stringWithFormat:@"BUY NOW"] forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addBtn.layer.cornerRadius = 3;
        addBtn.backgroundColor = AllBtn_Color;
        [addBtn addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:addBtn];
    }else {
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CURRENT_CONTENT_HEIGHT - 200, CURRENT_CONTENT_WIDTH, 200)];
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"Price:";
        titleLabel.numberOfLines = 0;
        titleLabel.frame = CGRectMake(10, 10, CURRENT_DEVICE_WIDTH - 20, 20);
        titleLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:titleLabel];
        
        priceLabel = [[UILabel alloc]init];
        priceLabel.text = priceArray[0];
        priceLabel.textColor = Btn_Color;
        priceLabel.numberOfLines = 0;
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.frame = CGRectMake(CURRENT_DEVICE_WIDTH - 220, 10, 200, 20);
        priceLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:priceLabel];
        
        UILabel *colorLabel = [[UILabel alloc]init];
        colorLabel.text = @"Color:";
        colorLabel.numberOfLines = 0;
        colorLabel.frame = CGRectMake(10, 60, CURRENT_DEVICE_WIDTH - 20, 20);
        colorLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:colorLabel];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        addBtn.frame = CGRectMake(10, scrollView.frame.size.height - 60, CURRENT_CONTENT_WIDTH-20, 40);
        [addBtn setTitle:[NSString stringWithFormat:@"BUY NOW"] forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addBtn.layer.cornerRadius = 3;
        addBtn.backgroundColor = AllBtn_Color;
        [addBtn addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:addBtn];
    }

    if (_sizebool) {
        //尺码数组
        btnView = [[UIScrollView alloc]init];
        btnView.frame = RECT(10, 190, CURRENT_CONTENT_WIDTH, 40);
        btnView.showsHorizontalScrollIndicator = NO;
        [scrollView addSubview:btnView];
        UIFont *font = [UIFont systemFontOfSize:12];
        CGSize sizeName = CGSizeMake(0, 0);
        //默认第一组size
        NSArray *sizearr = sizeArray[0];
        NSDictionary *sizedic = sizearr[0];
        selectOptionArray = [sizedic objectForKey:@"selectOption"];
        if (selectOptionArray.count != 0) {
            sizeName = [[selectOptionArray[selectOptionArray.count-1] objectForKey:@"selectOptionName"] sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 0.0) lineBreakMode:NSLineBreakByWordWrapping];
        }
        btnView.contentSize = CGSizeMake((sizeName.width+40)*iphone_WIDTH*selectOptionArray.count, 40*iphone_HIGHT);
        for (int i = 0; i <selectOptionArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = RECT((sizeName.width+40) *i, 5, sizeName.width+20, 30);
            [btn setTitle:[NSString stringWithFormat:@"%@",[selectOptionArray[i] objectForKey:@"selectOptionName"]] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setTitleColor:Btn_Color forState:UIControlStateSelected];
            btn.backgroundColor = nav_Color;
            btn.userInteractionEnabled = YES;
            //标记
            btn.tag = i+100;
            [btn addTarget:self action:@selector(selectSize:) forControlEvents:UIControlEventTouchUpInside];
            [btnView addSubview:btn];
        }
        
        //颜色数组
        colorViewl = [[UIScrollView alloc]init];
        colorViewl.frame = RECT(10, 90, CURRENT_CONTENT_WIDTH, 55);
        colorViewl.showsHorizontalScrollIndicator = NO;
        colorViewl.backgroundColor = [UIColor clearColor];
        colorViewl.contentSize = CGSizeMake(65*imageArray.count,0);
        [scrollView addSubview:colorViewl];
        
        if (imageArray.count != 0) {
            for (int i = 0; i<imageArray.count; i++) {
                //颜色字典
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.frame = CGRectMake(65*i, 0, 40, 40);
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:[UIImage imageNamed:LoadingImage]];
                [colorViewl addSubview:imageView];

                //按钮
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = RECT(65*i, 0, 40, 55);
                btn.userInteractionEnabled = YES;
                //标记
                btn.tag = i+10;
                [btn addTarget:self action:@selector(selectColor:) forControlEvents:UIControlEventTouchUpInside];
                [colorViewl addSubview:btn];
            }
            
            colorselectImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40-12, 12, 12)];
            colorselectImage.image = [UIImage imageNamed:@"colorselect"];
            colorselectImage.hidden = NO;
            [colorViewl addSubview:colorselectImage];
        }
        
    }else {
        //颜色数组
        colorViewl = [[UIScrollView alloc]init];
        colorViewl.frame = RECT(10, 85, CURRENT_CONTENT_WIDTH, 55);
        colorViewl.showsHorizontalScrollIndicator = NO;
        colorViewl.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:colorViewl];
        
        if (imageArray.count != 0) {
            for (int i = 0; i<imageArray.count; i++) {
                //颜色字典
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.frame = CGRectMake(65*i, 0, 40, 40);
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:[UIImage imageNamed:LoadingImage]];
                [colorViewl addSubview:imageView];
                
                //按钮
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = RECT(65*i, 0, 40, 55);
                btn.userInteractionEnabled = YES;
                //标记
                btn.tag = i+10;
                [btn addTarget:self action:@selector(selectColor:) forControlEvents:UIControlEventTouchUpInside];
                [colorViewl addSubview:btn];
            }
            
            colorselectImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40-12, 12, 12)];
            colorselectImage.image = [UIImage imageNamed:@"colorselect"];
            colorselectImage.hidden = NO;
            [colorViewl addSubview:colorselectImage];
        }
        
    }

    
}

-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.50;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [scrollView.layer addAnimation:animation forKey:nil];
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    NSArray *windowViews = [window subviews];
    if(windowViews && [windowViews count] > 0){
        UIView *subView = [windowViews objectAtIndex:[windowViews count]-1];
        for(UIView *aSubView in subView.subviews)
        {
            [aSubView.layer removeAllAnimations];
        }
        [subView addSubview:self];
        [self showAlertAnimation];
    }
}

- (void)close
{
    [self removeFromSuperview];
}

- (void)addToCart
{
    if (_sizebool) {
        if (!chooseSize) {
            [SVProgressHUD showErrorWithStatus:@"please select size" duration:1];
            return;
        }else if (!productsID){
            [SVProgressHUD showErrorWithStatus:@"please select color" duration:1];
            return;
        }else {
            [self removeFromSuperview];
            if (self.sizeinfoblock != nil) {
                
                NSDictionary *dic = @{@"color":productsID, @"size":sizeDic ,@"sizebool":@"1"};
                self.sizeinfoblock(dic);
            }
        }

    }else {
        if (!productsID){
            [SVProgressHUD showErrorWithStatus:@"please select color" duration:1];
            return;
        }else {
            [self removeFromSuperview];
            if (self.sizeinfoblock != nil) {
                NSDictionary *dic = @{@"color":productsID,@"sizebool":@"0"};
                self.sizeinfoblock(dic);
            }
        }
    }
}

- (void)sizeInfo:(SizeInfoBlock)block
{
    self.sizeinfoblock = block;
}

- (void)selectColor:(UIButton *)sender
{
    chooseSize = NO;
    //换算价格
    priceLabel.text = priceArray[sender.tag-10];
    productsID = productsIDArray[sender.tag-10];
    //重建size模型
    if (_sizebool) {
        for(UIView *subv in [btnView subviews])
        {
            [subv removeFromSuperview];
        }
        UIFont *font = [UIFont systemFontOfSize:12];
        CGSize sizeName = CGSizeMake(0, 0);
        
        NSArray *sizearr = sizeArray[sender.tag-10];
        NSDictionary *sizedic = sizearr[0];
        selectOptionArray = [sizedic objectForKey:@"selectOption"];
        if (selectOptionArray.count != 0) {
            sizeName = [[selectOptionArray[selectOptionArray.count-1] objectForKey:@"selectOptionName"] sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 0.0) lineBreakMode:NSLineBreakByWordWrapping];
        }
        btnView.contentSize = CGSizeMake((sizeName.width+40)*iphone_WIDTH*selectOptionArray.count, 40*iphone_HIGHT);
        for (int i = 0; i <selectOptionArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = RECT((sizeName.width+40) *i, 5, sizeName.width+20, 30);
            [btn setTitle:[NSString stringWithFormat:@"%@",[selectOptionArray[i] objectForKey:@"selectOptionName"]] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setTitleColor:Btn_Color forState:UIControlStateSelected];
            btn.backgroundColor = nav_Color;
            btn.userInteractionEnabled = YES;
            //标记
            btn.tag = i+100;
            [btn addTarget:self action:@selector(selectSize:) forControlEvents:UIControlEventTouchUpInside];
            [btnView addSubview:btn];
        }

    }else {
        //不做模型重建
    }
    colorDic = _colorArray[sender.tag -10];
    colorselectImage.hidden = NO;
    colorselectImage.frame = CGRectMake(65*(sender.tag-10), 40-12, 12, 12);
}

- (void)selectSize:(UIButton *)btn
{
    chooseSize = YES;
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize sizeName = [[selectOptionArray[0] objectForKey:@"selectOptionName"] sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 0.0) lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"%ld",(long)btn.tag);
    sizeDic = [selectOptionArray objectAtIndex:btn.tag-100];
    for (int i = 0; i<selectOptionArray.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+100];
        button.backgroundColor = nav_Color;
    }
    NSLog(@"%@",sizeDic);
    btn.backgroundColor = Btn_Color;
    if (_tmpBtn == nil){
//        btn.selected = YES;
        _tmpBtn = btn;

    }
    else if (_tmpBtn !=nil && _tmpBtn == btn){
//        btn.selected = YES;
        
    }
    else if (_tmpBtn!= btn && _tmpBtn!=nil){
//        _tmpBtn.selected = NO;
//        btn.selected = YES;
        _tmpBtn = btn;
    }
    
    if ((sizeName.width+40)*iphone_WIDTH*selectOptionArray.count>[UIScreen mainScreen].bounds.size.width) {
        if (btn.tag-100 == 0) {
            [btnView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if (btn.tag-100 == selectOptionArray.count-1) {
            [btnView setContentOffset:CGPointMake(btn.frame.origin.x - [UIScreen mainScreen].bounds.size.width + btn.frame.size.width, 0) animated:YES];
        }else {
            [btnView setContentOffset:CGPointMake(btn.frame.origin.x - [UIScreen mainScreen].bounds.size.width/2 + btn.frame.size.width/2, 0) animated:YES];
        }
    }else {
        
    }
    
    
}
- (void)removeView
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
