//
//  IncomeStatementTableViewCell.m
//  小趣医生端
//
//  Created by 窦建斌 on 16/2/3.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "IncomeStatementTableViewCell.h"

@implementation IncomeStatementTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_title = [[UILabel alloc]initWithFrame:CGRectMake(15, 9, SCREEN_WIDTH / 3 * 2, 19)];
        [self.contentView addSubview:self.lab_title];
        self.lab_title.font = [UIFont systemFontOfSize:18];
        self.lab_title.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        
        self.lab_detail = [[UILabel alloc]initWithFrame:CGRectMake(15, 31.5, SCREEN_WIDTH - 15 - 115, 16.5)];
        [self.contentView addSubview:self.lab_detail];
        self.lab_detail.font = [UIFont systemFontOfSize:12];
        self.lab_detail.textColor = [UIColor colorWithHexString:@"#969696"];
        
        self.lab_price = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 115, 16, 100, 25)];
        [self.contentView addSubview:self.lab_price];
        self.lab_price.font = [UIFont systemFontOfSize:18];
        self.lab_price.textColor = [UIColor colorWithHexString:@"#FA6262"];
        self.lab_price.textAlignment = NSTextAlignmentRight;
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5, SCREEN_WIDTH, 0.5)];
        [self addSubview:img];
        [img setBackgroundColor:[UIColor colorWithHexString:@"#DBDCDD"]];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
