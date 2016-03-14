//
//  BankTableViewCell.h
//  小趣医生端
//
//  Created by 窦建斌 on 15/12/24.
//  Copyright © 2015年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankTableViewCell : UITableViewCell

@property (nonatomic ,retain)UILabel *lab_home;
@property (nonatomic ,retain)UILabel *lab_header;
@property (nonatomic ,retain)UILabel *lab_bankName;
@property (nonatomic ,retain)UIButton *btn_delete;
@property (nonatomic ,retain)UILabel *lab_cardNum;

@end
