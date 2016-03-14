//
//  MyBankCardViewController.h
//  小趣医生端
//
//  Created by 窦建斌 on 15/12/24.
//  Copyright © 2015年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankEntity.h"

@protocol MyBankCardViewControllerDegelate <NSObject>

- (void)didSelectedBankWithEntity:(BankEntity *)bankEntity;

@end

@interface MyBankCardViewController : UIViewController

@property (nonatomic ,assign)int FromType;  // 为2 的时候为从提现按钮进入

@property (nonatomic ,retain)id<MyBankCardViewControllerDegelate>delegate;

@end
