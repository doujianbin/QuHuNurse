//
//  HistoryTableViewCell.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/18.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(7.5, 8, SCREEN_WIDTH - 15, 166.5)];
        [self addSubview:backView];
        [backView setBackgroundColor:[UIColor whiteColor]];
        //        backView.layer.cornerRadius = 3.0;
        //        backView.layer.masksToBounds = YES;
        backView.layer.shadowColor = [UIColor colorWithHexString:@"#000000" alpha:0.2].CGColor;//阴影颜色
        backView.layer.shadowOffset = CGSizeMake(0, 1.5);//偏移距离
        backView.layer.shadowOpacity = 0.5;//不透明度
        backView.layer.shadowRadius = 2.0;//半径
        
        self.lab_orderNo = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, 220, 14.5)];
        [backView addSubview:self.lab_orderNo];
        [self.lab_orderNo setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_orderNo setFont:[UIFont systemFontOfSize:14]];
        
        self.lab_orderStatus = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 99, 12, 70, 18)];
        [backView addSubview:self.lab_orderStatus];
        [self.lab_orderStatus setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
        [self.lab_orderStatus setFont:[UIFont boldSystemFontOfSize:17]];
        [self.lab_orderStatus setTextAlignment:NSTextAlignmentRight];
        
        UIImageView *imgheng = [[UIImageView alloc]initWithFrame:CGRectMake(0, 38.5, SCREEN_WIDTH - 15, 0.5)];
        [backView addSubview:imgheng];
        [imgheng setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
        
        self.img_headPic = [[UIImageView alloc]initWithFrame:CGRectMake(12, 49.5, 37, 37)];
        [backView addSubview:self.img_headPic];
        
        self.lab_name = [[UILabel alloc]initWithFrame:CGRectMake(59, 60, 90, 16.5)];
        [backView addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_name setFont:[UIFont systemFontOfSize:16]];

        self.lab_orderType = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 104.5, 58.5, 80, 19)];
        [backView addSubview:self.lab_orderType];
        [self.lab_orderType setTextColor:[UIColor colorWithHexString:@"#000000"]];
        self.lab_orderType.alpha = 0.8;
        [self.lab_orderType setFont:[UIFont systemFontOfSize:18]];
        [self.lab_orderType setTextAlignment:NSTextAlignmentRight];
        
        UIImageView *imgheng2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 96.5, SCREEN_WIDTH - 15, 0.5)];
        [backView addSubview:imgheng2];
        [imgheng2 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
        
        self.lab_hospitalAddress = [[UILabel alloc]initWithFrame:CGRectMake(12, 112.5, SCREEN_WIDTH - 24 - 15, 14.5)];
        [backView addSubview:self.lab_hospitalAddress];
        [self.lab_hospitalAddress setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_hospitalAddress setFont:[UIFont systemFontOfSize:14]];
        self.lab_hospitalAddress.alpha = 0.8;
        
        self.lab_orderTime = [[UILabel alloc]initWithFrame:CGRectMake(12, 137, 280, 14.5)];
        [backView addSubview:self.lab_orderTime];
        [self.lab_orderTime setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_orderTime setFont:[UIFont systemFontOfSize:14]];
        self.lab_orderTime.alpha = 0.8;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
