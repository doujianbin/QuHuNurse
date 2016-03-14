//
//  IncomeStatementEntity.h
//  小趣医生端
//
//  Created by 窦建斌 on 16/2/3.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IncomeStatementEntity : NSObject

@property (nonatomic )int   type;
@property (nonatomic )int   status;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *amount;
@property (nonatomic ,strong)NSString *accountTime;
@property (nonatomic ,strong)NSString *content;


//@property (nonatomic ,strong)NSString *amount;
//@property (nonatomic ,strong)NSString *applyTime;
//@property (nonatomic ,strong)NSString *cardId;   // cardId 不为空就是收入 title为加号收益
//@property (nonatomic ,strong)NSString *hospitalName;

+ (IncomeStatementEntity *)parseIncomeStatementEntityWithJson:(id)json;

@end
