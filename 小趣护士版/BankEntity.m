//
//  BankEntity.m
//  小趣医生端
//
//  Created by 窦建斌 on 16/2/1.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "BankEntity.h"
#import <MJExtension/MJExtension.h>
@implementation BankEntity

+ (NSArray *)parseBankWithJson:(id)json {
    return [self parseObjectArrayWithKeyValues:json];
}

+ (BankEntity *)parseBankListEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"BankId" : @"id",
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
