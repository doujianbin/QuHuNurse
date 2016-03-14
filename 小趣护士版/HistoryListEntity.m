//
//  HistoryListEntity.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/18.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "HistoryListEntity.h"
#import <MJExtension/MJExtension.h>
@implementation HistoryListEntity

+ (NSArray *)parseHistoryListrWithJson:(id)json {
    return [self parseObjectArrayWithKeyValues:json];
}

+ (HistoryListEntity *)parseHistoryListEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"orderId" : @"id",
             };
}

+ (NSArray *)parseObjectArrayWithKeyValues:(id)json
{
    if([NSJSONSerialization isValidJSONObject:json]){
        
        NSArray * result = nil;
        @try {
            result = [self objectArrayWithKeyValuesArray:json];
        }
        @catch (NSException *exception) {
            
            return nil;
        }
        return result;
    }else{
        return [NSArray array];
    }
}

+ (id)parseObjectWithKeyValues:(NSDictionary *)keyValues
{
    id result = nil;
    @try {
        result = [self objectWithKeyValues:keyValues];
    }
    @catch (NSException *exception) {
        return nil;
    }
    return result;
}


@end
