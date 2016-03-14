//
//  AddBandTableViewCell.m
//  小趣医生端
//
//  Created by 窦建斌 on 15/12/24.
//  Copyright © 2015年 窦建斌. All rights reserved.
//

#import "AddBandTableViewCell.h"

@implementation AddBandTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        self.lab_left = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 90, 25)];
        [self.contentView addSubview:self.lab_left];
        [self.lab_left setFont:[UIFont systemFontOfSize:18]];
        [self.lab_left setTextColor:[UIColor colorWithHexString:@"#969696"]];
        
//        self.tef_right = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 219, 25, 190, 25)];
//        [self.contentView addSubview:self.tef_right];
//        [self.tef_right setFont:[UIFont systemFontOfSize:18]];
//        [self.tef_right setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
//        self.tef_right.textAlignment = NSTextAlignmentRight;
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
