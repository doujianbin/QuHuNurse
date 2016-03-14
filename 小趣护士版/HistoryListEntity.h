//
//  HistoryListEntity.h
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/18.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryListEntity : NSObject

@property (nonatomic ,assign)int          assignFlag;
@property (nonatomic ,strong)NSString    *cancelTime;
@property (nonatomic ,strong)NSString    *createTimeStr;
@property (nonatomic ,strong)NSString    *doctorName;
@property (nonatomic ,strong)NSString    *endTime;
@property (nonatomic ,strong)NSString    *hospitalName;
@property (nonatomic ,assign)int          orderId;
@property (nonatomic ,assign)int          orderStatus;
@property (nonatomic ,assign)int          orderType;
@property (nonatomic ,strong)NSString    *orderNo;
@property (nonatomic ,strong)NSString    *patientName;
@property (nonatomic ,strong)NSString    *pictureUrl;
@property (nonatomic ,strong)NSString    *scheduleTime;
@property (nonatomic ,strong)NSString    *startTime;
@property (nonatomic ,strong)NSString    *totalAmount;

+ (HistoryListEntity *)parseHistoryListEntityWithJson:(id)json;
@end
