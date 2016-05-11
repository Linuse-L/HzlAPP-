//
//  LInfoCell.m
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "LInfoCell.h"

@implementation LInfoCell
@synthesize nameLabel,phoneLabel,addressLabel,selectImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _isSelect = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        selectImageView = [[UIImageView alloc]init];
        selectImageView.frame = CGRectMake(10, 35, 20, 20);
        [self addSubview:selectImageView];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(40, 10, 110, 30);
        nameLabel.text = @"KIMI";
        nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:nameLabel];
        
        
        phoneLabel = [[UILabel alloc]init];
        phoneLabel.frame = CGRectMake(150, 10, 150, 30);
        phoneLabel.text = @"138****3333";
        phoneLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:phoneLabel];
        
        
        
        addressLabel = [[UILabel alloc]init];
        addressLabel.frame = CGRectMake(40, 40, CURRENT_CONTENT_WIDTH-50, 30)
        ;
        addressLabel.numberOfLines = 0;
        addressLabel.text = @"zhongguo gugong dizhi  beijing sanlit dongchengqu youyiku";
        addressLabel.textColor = [UIColor grayColor];
        addressLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:addressLabel];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(10, 10, 20, 20);
        imageView.image = [UIImage imageNamed:@"editImage"];
        
        
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        editBtn.frame = CGRectMake(CURRENT_CONTENT_WIDTH - 50, 25, 50, 50);
//        [editBtn setBackgroundImage:[UIImage imageNamed:@"editImage"] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editAddress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:editBtn];
        
        [editBtn addSubview:imageView];
        
    }
    
    return self;
}
- (void)setData:(NSDictionary *)dic
{
    nameLabel.text = [NSString stringWithFormat:@"%@·%@",[dic objectForKey:@"entry_firstname"],[dic objectForKey:@"entry_lastname"]];
    addressLabel.text=[NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"entry_state"],[dic objectForKey:@"entry_street_address"]];
    phoneLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"entry_phone"]];
    selectDic = dic;
}
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        selectImageView.image = [UIImage imageNamed:@"selectImage"];
    }else{
        selectImageView.image = [UIImage imageNamed:@"noSelect"];
    }
}
- (void)editAddress
{
    NSLog(@"修改地址");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"editAddress" object:selectDic];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
