//
//  OrderListTableViewCell.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/17.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "OrderListTableViewCell.h"

@implementation OrderListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(7.5, 8, SCREEN_WIDTH - 15, 234.5)];
        [self addSubview:backView];
        backView.layer.cornerRadius = 3;
         [backView setBackgroundColor:[UIColor whiteColor]];
        backView.layer.shadowColor = [UIColor colorWithHexString:@"#000000" alpha:0.2].CGColor;//阴影颜色
        backView.layer.shadowOffset = CGSizeMake(0, 1.5);//偏移距离
        backView.layer.shadowOpacity = 0.5;//不透明度
        backView.layer.shadowRadius = 2.0;//半径
        
        self.lab_orderType = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, 56, 14.5)];
        [backView addSubview:self.lab_orderType];
        [self.lab_orderType setAlpha:0.8];
        self.lab_orderType.font = [UIFont systemFontOfSize:14];
        
        self.lab_orderCreateTime = [[UILabel alloc]initWithFrame:CGRectMake(77, 12, 100,14.5)];
        [backView addSubview:self.lab_orderCreateTime];
        self.lab_orderCreateTime.alpha = 0.8;
        self.lab_orderCreateTime.font = [UIFont systemFontOfSize:14];
        self.lab_orderCreateTime.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        
        self.img_paidan = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 77.5, 6.5, 50, 34.8)];
        [self addSubview:self.img_paidan];
        
        UIImageView *imgheng = [[UIImageView alloc]initWithFrame:CGRectMake(0, 38.5, SCREEN_WIDTH - 15, 0.5)];
        [backView addSubview:imgheng];
        [imgheng setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
        
        self.img_headPic = [[UIImageView alloc]initWithFrame:CGRectMake(12, 49.5, 37, 37)];
        [backView addSubview:self.img_headPic];
        
        self.lab_name = [[UILabel alloc]initWithFrame:CGRectMake(59, 51.5, 80, 16.5)];
        [backView addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_name setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_genderAndAge = [[UILabel alloc]initWithFrame:CGRectMake(59, 72, 100, 12.5)];
        [backView addSubview:self.lab_genderAndAge];
        [self.lab_genderAndAge setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_genderAndAge setAlpha:0.7];
        [self.lab_genderAndAge setFont:[UIFont systemFontOfSize:12]];
        
        self.btn_phone = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 102.5, 50.5, 80, 35)];
        [backView addSubview:self.btn_phone];
        [self.btn_phone setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
        self.btn_phone.layer.cornerRadius = 3;
        self.btn_phone.layer.masksToBounds = YES;
        [self.btn_phone setTitle:@"拨打电话" forState:UIControlStateNormal];
        self.btn_phone.titleLabel.font = [UIFont systemFontOfSize:16];
        
        UIImageView *imgheng1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 96.5, SCREEN_WIDTH - 15, 0.5)];
        [backView addSubview:imgheng1];
        [imgheng1 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
        
        self.lab_hospitalName = [[UILabel alloc]initWithFrame:CGRectMake(12, 112.5, SCREEN_WIDTH - 39, 19)];
        [backView addSubview:self.lab_hospitalName];
        [self.lab_hospitalName setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_hospitalName setAlpha:0.8];
        [self.lab_hospitalName setFont:[UIFont systemFontOfSize:18]];
        
        self.lab_orderTime = [[UILabel alloc]initWithFrame:CGRectMake(12, 141.5, SCREEN_WIDTH - 39, 19)];
        [backView addSubview:self.lab_orderTime];
        [self.lab_orderTime setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_orderTime setFont:[UIFont systemFontOfSize:18]];
        
        self.btn_xiangqing = [[UIButton alloc]initWithFrame:CGRectMake(12, 175.5, SCREEN_WIDTH - 39, 44)];
        [backView addSubview:self.btn_xiangqing];
        [self.btn_xiangqing setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
        [self.btn_xiangqing.titleLabel setFont:[UIFont systemFontOfSize:18]];
        self.btn_xiangqing.layer.cornerRadius = 3.0;
        self.btn_xiangqing.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
