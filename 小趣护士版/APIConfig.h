//
//  APIConfig.h
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#ifndef APIConfig_h
#define APIConfig_h


//成功的状态吗
#define SUCCESS @"SUCCESS"
#define ERROR @"ERROR"
#define FAIL @"FAIL"
//验证stauts的状态
#define Status [responseDic objectForKey:@"status"]
// 请求提示
#define Message [responseDic objectForKey:@"message"]

// 开发环境
#define Development @"https://app.haohushi.me:8443"
//开发环境 http://101.201.223.151:7001
//生产环境 http://app.haohushi.me:8080
//https://app.haohushi.me:8443
//测试环境 https://ci.haohushi.me:7009
//发送验证码
#define MessageCode @"/quhu/accompany/public/N/messageCode"
//验证验证码
#define RegisterOrRefresh @"/quhu/accompany/public/registerOrRefresh"
//登录获取token
#define GetToken @"/oauth/token"
//查询用户认证状态
#define GetUserInfo @"/quhu/accompany/public/getUserInfo"
//护士查询抢单列表
#define QueryMayGrabOrders @"/quhu/accompany/nurse/queryMayGrabOrders"
//护士抢单
#define Qiangdan @"/quhu/accompany/nurse/grabOrder"
// 护士订单一级列表
#define QueryUnfinishedList @"/quhu/accompany/nurse/order/queryUnfinishedList"
// 护士查看订单详情
#define OrderDetail @"/quhu/accompany/nurse/queryOrderInfo"
//护士查看收费明细 （订单详情）
#define QueryOrderDetails @"/quhu/accompany/nurse/accounts/getAppUserIncomeDetail"
// 护士认证
#define AuthSaveInfo @"/quhu/accompany/nurse_temp/authSaveInfo"
//护士查看历史订单
#define QueryHistoryList @"/quhu/accompany/nurse/order/queryHistoryList"

// 医生查询个人信息
#define QueryPersonalInfo @"/quhu/accompany/nurse/queryPersonalInfo"
//更新头像
#define SavePersonalInfo @"/quhu/accompany/nurse/savePersonalInfo"
// 添加银行卡
#define CreateBankcard @"/quhu/accompany/nurse/createBankcard"
#define QueryBankList @"/quhu/accompany/public/queryBankList"
// 护士查找已添加的银行卡
#define GetBankcardList @"/quhu/accompany/nurse/getBankcardList"
// 修改银行卡
#define UpdateBankcardById @"/quhu/accompany/nurse/updateBankcardById"
// 护士删除银行卡
#define DeleteBankcardById @"/quhu/accompany/nurse/deleteBankcardById"
// 护士提现
#define DoctorTiXian @"/quhu/accompany/nurse/accounts/applyAppUserOutcomeAmount"
// 医生收益明细查询
#define GetAppUserIncomeDetail  @"/quhu/accompany/nurse/accounts/getAppUserIncomeDetail"
// 护士更新上班下班状态
#define ChangeWorkFlag @"/quhu/accompany/nurse/order/changeWorkFlag"
// 上传百度推送channelId
#define SaveChannelId @"/quhu/accompany/nurse/saveChannelId"
// 版本升级
#define VersionInfo @"/quhu/accompany/common/versionInfo"

#endif /* APIConfig_h */
