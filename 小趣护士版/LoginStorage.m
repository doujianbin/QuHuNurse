//
//  LoginStorage.m
//  小趣用户端
//
//  Created by 窦建斌 on 16/1/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "LoginStorage.h"

static NSString * const ISLOGIN = @"isLogin";
static NSString * const HttpHeader = @"httpHeader";
static NSString * const PhoneNum = @"PhoneNum";
static NSString * const YanZhengMa = @"YanZhengMa";
static NSString * const IsPassSeeing = @"IsPassSeeing";
static NSString * const IsNotWorking = @"IsWorking";
static NSString * const ShareDic = @"ShareDic";
static NSString * const KeFuNum = @"KeFuNum";
static NSString * const NurseId = @"NurseId";
static NSString * const SysBulletin = @"sysBulletin";


@implementation LoginStorage

/**
 *  存/取  手机号
 */
+ (void)savePhoneNum:(NSString *)str{
    [UserDefaultsUtils saveValue:str forKey:PhoneNum];
}

+ (NSString *)GetPhoneNum
{
    return [UserDefaultsUtils valueWithKey:PhoneNum];
}

/**
 *  存/取  验证码
 */
+ (void)saveYanZhengMa:(NSString *)str{
    [UserDefaultsUtils saveValue:str forKey:YanZhengMa];
}

+ (NSString *)GetYanZhengMa
{
    return [UserDefaultsUtils valueWithKey:YanZhengMa];
}

/**
 *  登陆成功
 */
+ (void)saveIsLogin:(BOOL)loginStatus{
    [UserDefaultsUtils saveBoolValue:loginStatus withKey:ISLOGIN];
}
+ (BOOL)isLogin{
    return  [UserDefaultsUtils boolValueWithKey:ISLOGIN];
}

/**
 *  存/取  登陆成功返回的 的 HTTP header
 */
+ (void)saveHTTPHeader:(NSString *)str{
    [UserDefaultsUtils saveValue:str forKey:HttpHeader];
}

+ (NSString *)GetHTTPHeader
{
    return [UserDefaultsUtils valueWithKey:HttpHeader];
}
/**
 *  判断是否进入过 认证通过的界面 ， 该界面只给用户显示一次
 */
+ (void)saveIsPassSeeing:(BOOL)passSeeing{
    [UserDefaultsUtils saveBoolValue:passSeeing withKey:IsPassSeeing];
}
+ (BOOL)IsPassSeeing{
    return  [UserDefaultsUtils boolValueWithKey:IsPassSeeing];
}

+ (void)saveIsNotWorking:(NSString *)isworking{
    [UserDefaultsUtils saveValue:isworking forKey:IsNotWorking];
}
+ (NSString *)IsNotWorking
{
    return [UserDefaultsUtils valueWithKey:IsNotWorking];
}

+ (void)saveShareDic:(NSDictionary *)shareDic{
    [UserDefaultsUtils saveValue:shareDic forKey:ShareDic];
}

+ (NSDictionary *)ShareDic{
    return [UserDefaultsUtils valueWithKey:ShareDic];
}

+ (void)saveKefuPhoneNum:(NSString *)phonenum{
    [UserDefaultsUtils saveValue:phonenum forKey:KeFuNum];
}
+ (NSString *)phonenum{
    return [UserDefaultsUtils valueWithKey:KeFuNum];
}

+ (void)nurseId:(NSString *)nurseId{
    [UserDefaultsUtils saveValue:nurseId forKey:NurseId];
}
+ (NSString *)nurseId{
    return [UserDefaultsUtils valueWithKey:NurseId];
}

+ (void)savesySBulletin:(NSDictionary *)sysBulletin{
    [UserDefaultsUtils saveValue:sysBulletin forKey:SysBulletin];
}

+ (NSDictionary *)sysBulletin{
    return [UserDefaultsUtils valueWithKey:SysBulletin];
}


@end
