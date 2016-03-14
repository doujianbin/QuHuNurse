//
//  BankTableViewCell.m
//  小趣医生端
//
//  Created by 窦建斌 on 15/12/24.
//  Copyright © 2015年 窦建斌. All rights reserved.
//

#import "BankTableViewCell.h"

@implementation BankTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
        self.lab_home = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH -  24, 122.5)];
        [self.contentView addSubview:self.lab_home];
        self.lab_home.layer.cornerRadius = 3.0f;
        self.lab_home.layer.masksToBounds = YES;
        self.lab_home.layer.borderWidth = 0.5f;
        self.lab_home.layer.borderColor = [[UIColor colorWithHexString:@"#DBDCDD"] CGColor];
        [self.lab_home setUserInteractionEnabled:NO];
        
        self.lab_header = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.lab_home.frame.size.width, 44)];
        [self.lab_home addSubview:self.lab_header];
        [self.lab_header setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
        
        self.lab_bankName = [[UILabel alloc]initWithFrame:CGRectMake(20, 9.5, 200, 25)];
        [self.lab_home addSubview:self.lab_bankName];
        self.lab_bankName.font = [UIFont systemFontOfSize:18];
        [self.lab_bankName setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
//        [self.lab_bankName setText:@"招商银行"];
//        [self.lab_bankName setBackgroundColor:[UIColor yellowColor]];
        
        self.btn_delete = [[UIButton alloc]initWithFrame:CGRectMake(self.lab_home.frame.size.width - 30, 23, 30, 21)];
        [self.contentView addSubview:self.btn_delete];
        [self.btn_delete setTitle:@"删除" forState:UIControlStateNormal];
        [self.btn_delete setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        self.btn_delete.titleLabel.font = [UIFont systemFontOfSize:15];
        
        self.lab_cardNum = [[UILabel alloc]initWithFrame:CGRectMake(37, 70.5, 280, 25)];
        [self.lab_home addSubview:self.lab_cardNum];
        self.lab_cardNum.font = [UIFont systemFontOfSize:18];
        self.lab_cardNum.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
