//
//  OrderListTableViewCell.h
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/17.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel        *lab_orderType;
@property (nonatomic ,strong)UILabel        *lab_orderCreateTime;
@property (nonatomic ,strong)UIImageView    *img_paidan;
@property (nonatomic ,strong)UIImageView    *img_headPic;
@property (nonatomic ,strong)UILabel        *lab_name;
@property (nonatomic ,strong)UILabel        *lab_genderAndAge;
@property (nonatomic ,strong)UIButton       *btn_phone;
@property (nonatomic ,strong)UILabel        *lab_hospitalName;
@property (nonatomic ,strong)UILabel        *lab_orderTime;
@property (nonatomic ,strong)UIButton       *btn_xiangqing;

@end
