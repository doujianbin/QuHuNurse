//
//  RootDetailTableViewCell.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "RootDetailTableViewCell.h"

@implementation RootDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_left = [[UILabel alloc]initWithFrame:CGRectMake(15, 19.5, 80, 18)];
        [self addSubview:self.lab_left];
        [self.lab_left setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        self.lab_left.alpha = 0.6;
        self.lab_left.font = [UIFont systemFontOfSize:17];
        
        self.lab_right = [[UILabel alloc]initWithFrame:CGRectMake(100, 19.5, SCREEN_WIDTH - 115, 18)];
        [self addSubview:self.lab_right];
        [self.lab_right setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        self.lab_right.font = [UIFont systemFontOfSize:17];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
