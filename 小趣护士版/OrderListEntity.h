//
//  OrderListEntity.h
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/17.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListEntity : NSObject

@property (nonatomic ,assign)int        orderId;            // 订单id
@property (nonatomic ,strong)NSString  *orderNo;            // 订单号
@property (nonatomic ,strong)NSString  *patientName;
@property (nonatomic ,strong)NSString  *hospitalName;
@property (nonatomic ,strong)NSString  *doctorName;
@property (nonatomic ,strong)NSString  *createTimeStr;
@property (nonatomic ,assign)int        orderType;
@property (nonatomic ,assign)int        orderStatus;
@property (nonatomic ,assign)int        payStatus;
@property (nonatomic ,strong)NSString  *startTime;
@property (nonatomic ,strong)NSString  *endTime;
@property (nonatomic ,assign)int        assignFlag;
@property (nonatomic ,strong)NSString  *pictureUrl;
@property (nonatomic ,strong)NSString  *patientPhoneNumber;
@property (nonatomic ,assign)int        sex;
@property (nonatomic ,strong)NSString  *scheduleTime;
@property (nonatomic ,strong)NSString  *address;


+ (NSArray *)parseOrdeListrWithJson:(id)json;
+ (OrderListEntity *)parseOrderListEntityWithJson:(id)json;
@end
