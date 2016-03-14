//
//  HistoryTableViewCell.h
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/18.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel     *lab_orderNo;
@property (nonatomic ,strong)UILabel     *lab_orderStatus;
@property (nonatomic ,strong)UIImageView *img_headPic;
@property (nonatomic ,strong)UILabel     *lab_name;
@property (nonatomic ,strong)UILabel     *lab_orderType;
@property (nonatomic ,strong)UILabel     *lab_hospitalAddress;
@property (nonatomic ,strong)UILabel     *lab_orderTime;

@end
