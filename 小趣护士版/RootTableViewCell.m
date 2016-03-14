//
//  RootTableViewCell.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "RootTableViewCell.h"

@implementation RootTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(7.5, 8, SCREEN_WIDTH - 15, 176.5)];
        [self addSubview:backView];
        [backView setBackgroundColor:[UIColor whiteColor]];
//        backView.layer.cornerRadius = 3.0;
//        backView.layer.masksToBounds = YES;
        backView.layer.shadowColor = [UIColor colorWithHexString:@"#000000" alpha:0.2].CGColor;//阴影颜色
        backView.layer.shadowOffset = CGSizeMake(0, 1.5);//偏移距离
        backView.layer.shadowOpacity = 0.5;//不透明度
        backView.layer.shadowRadius = 2.0;//半径
        
        self.lab_orderType = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, 56, 14.5)];
        [backView addSubview:self.lab_orderType];
        [self.lab_orderType setAlpha:0.8];
        self.lab_orderType.font = [UIFont systemFontOfSize:14];
        [self.lab_orderType setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
        
        self.lab_orderCreateTime = [[UILabel alloc]initWithFrame:CGRectMake(77, 12, 100,14.5)];
        [backView addSubview:self.lab_orderCreateTime];
        self.lab_orderCreateTime.alpha = 0.8;
        self.lab_orderCreateTime.font = [UIFont systemFontOfSize:14];
        self.lab_orderCreateTime.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        
        UIImageView *heng = [[UIImageView alloc]initWithFrame:CGRectMake(0, 38.5, SCREEN_WIDTH - 15, 0.5)];
        [backView addSubview:heng];
        [heng setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
        
        self.lab_hospital = [[UILabel alloc]initWithFrame:CGRectMake(12, 54.5, SCREEN_WIDTH - 35, 19)];
        [backView addSubview:self.lab_hospital];
        self.lab_hospital.alpha = 0.8;
        [self.lab_hospital setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_hospital setFont:[UIFont systemFontOfSize:18]];
        
        self.lab_orderTime = [[UILabel alloc]initWithFrame:CGRectMake(12, 83.5, 260, 19)];
        [backView addSubview:self.lab_orderTime];
        [self.lab_orderTime setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
        self.lab_orderTime.alpha = 0.8;
        self.lab_orderTime.font = [UIFont systemFontOfSize:18];
        
        self.btn_qiangdan = [[UIButton alloc]initWithFrame:CGRectMake(12, 117.5, SCREEN_WIDTH - 15 - 24, 44)];
        [backView addSubview:self.btn_qiangdan];
        [self.btn_qiangdan setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
        self.btn_qiangdan.layer.cornerRadius = 3.0;
        self.btn_qiangdan.layer.masksToBounds = YES;
        [self.btn_qiangdan setTitle:@"抢单" forState:UIControlStateNormal];
        self.btn_qiangdan.titleLabel.font = [UIFont systemFontOfSize:18];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
