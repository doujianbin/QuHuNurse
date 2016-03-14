//
//  RootOrderEntity.h
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootOrderEntity : NSObject

@property (nonatomic ,assign)int orderType;
@property (nonatomic ,strong)NSString *createTime;
@property (nonatomic ,strong)NSString *hospitalName;
@property (nonatomic ,strong)NSString *hospitalAddress;
@property (nonatomic ,strong)NSString *scheduleTime;
@property (nonatomic ,strong)NSString *orderId;
@property (nonatomic ,strong)NSString *doctorName;
@property (nonatomic ,strong)NSString *doctorTitle;
@property (nonatomic ,strong)NSString *patientName;
@property (nonatomic ,assign)int patientSex;
@property (nonatomic ,strong)NSString *patientAge;
@property (nonatomic ,strong)NSString *orderNo;

+ (NSArray *)parseRootOrderWithJson:(id)json;
+ (RootOrderEntity *)parseRootOrderEntityWithJson:(id)json;

@end
