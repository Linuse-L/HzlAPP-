//
//  LoginCell.m
//  NewApp
//
//  Created by L on 15/9/21.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "LoginCell.h"

@implementation LoginCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIImageView *headerImageView = [[UIImageView alloc]init];
        headerImageView.frame = RECT(10, 5, 50, 50);
        headerImageView.clipsToBounds = YES;
        headerImageView.layer.cornerRadius = 25;
        headerImageView.image = [UIImage imageNamed:@"headerImage"];
        [self addSubview:headerImageView];
    }
    
    return self;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
