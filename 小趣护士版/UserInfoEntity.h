//
//  UserInfoEntity.h
//  小趣医生端
//
//  Created by 窦建斌 on 16/1/26.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoEntity : NSObject

@property (nonatomic ,strong)NSString *deptName;
@property (nonatomic ,strong)NSString *account;   // 余额
@property (nonatomic ,strong)NSString *hospitalName;
@property (nonatomic ,strong)NSString *photo;   // 头像地址
@property (nonatomic ,strong)NSString *title;    // 职称
@property (nonatomic ,strong)NSString *userId;
@property (nonatomic ,strong)NSString *name;   // 姓名
@property (nonatomic)int recommendFlag; // 显示有奖推荐 1->显示; 0->不显示

+ (UserInfoEntity *)parseUserInfoEntityWithJson:(id)json;

@end
