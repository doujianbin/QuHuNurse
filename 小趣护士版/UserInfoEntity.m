//
//  UserInfoEntity.m
//  小趣医生端
//
//  Created by 窦建斌 on 16/1/26.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "UserInfoEntity.h"
#import <MJExtension/MJExtension.h>

@implementation UserInfoEntity


+ (NSArray *)parseUserInfoWithJson:(id)json {
    return [self parseObjectArrayWithKeyValues:json];
}

+ (UserInfoEntity *)parseUserInfoEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
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
