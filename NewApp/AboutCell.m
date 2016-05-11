//
//  AboutCell.m
//  NewApp
//
//  Created by 黄权浩 on 15/12/12.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "AboutCell.h"

@implementation AboutCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonMethod:(id)sender {
    NSString *allString = [NSString stringWithFormat:@"tel:0019718080999"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}
@end
