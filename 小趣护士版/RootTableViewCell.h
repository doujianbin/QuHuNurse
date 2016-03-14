//
//  RootTableViewCell.h
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIView *v_backGround;
@property (nonatomic ,strong)UILabel *lab_orderType;
@property (nonatomic ,strong)UILabel *lab_orderCreateTime;
@property (nonatomic ,strong)UILabel *lab_hospital;
@property (nonatomic ,strong)UILabel *lab_orderTime;
@property (nonatomic ,strong)UIButton *btn_qiangdan;

@end
