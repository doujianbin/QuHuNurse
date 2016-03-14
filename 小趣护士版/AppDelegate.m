//
//  AppDelegate.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "AppDelegate.h"
#import "SignInViewController.h"
#import "ReviewFailViewController.h"
#import "ReviewPassViewController.h"
#import "ReviewIngViewController.h"
#import "AuthenticationDataViewController.h"
#import "RootViewController.h"
#import "OrderViewController.h"
#import "MyViewController.h"
#import "SignInViewController.h"
#import "BPush.h"
#import "WXApi.h"
#import "WXApiObject.h"


// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AppDelegate ()<UITabBarControllerDelegate>

//@property (nonatomic ,retain)AFNManager *manager;
@property (nonatomic, retain)AFHTTPRequestOperationManager *manager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSThread sleepForTimeInterval:1.2];
    //设置navigationbar标题的字体和颜色
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#FA6262"], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#C7CAD1"], NSForegroundColorAttributeName, nil] forState:UIControlStateDisabled];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor blackColor], NSForegroundColorAttributeName,
                                                          [UIFont systemFontOfSize:18.0], NSFontAttributeName, nil]];
    
    
    // iOS8 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
#warning 测试 开发环境 时需要修改BPushMode为BPushModeDevelopment 需要修改Apikey为自己的Apikey
    
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    [BPush registerChannel:launchOptions apiKey:@"GjUgGkuIks7Sws1YzuoaeH4u"pushMode:BPushModeProduction withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:YES];

    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
    }
#if TARGET_IPHONE_SIMULATOR
    Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
    [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
#endif
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    /*
     // 测试本地通知
     [self performSelector:@selector(testLocalNotifi) withObject:nil afterDelay:1.0];
     */

    [WXApi registerApp:@"wx582d078eb30dc94f" withDescription:@"小趣护士版"];
    
    // 先判断是否登陆   如果未登录  直接跳转到登陆界面
    if ([LoginStorage isLogin] == NO) {
        SignInViewController *vc_signIn = [[SignInViewController alloc]init];
        UINavigationController *nav_vc = [[UINavigationController alloc]initWithRootViewController:vc_signIn];
        vc_signIn.isSetRootView = YES;
        [self.window setRootViewController:nav_vc];
    }else{
        //  如果登陆了  查询认证状态  跳转到相应的界面
        [self getUserInfo];
    }
    [self loadVersionMsg];
    return YES;
}

- (void)setTabBarRootView{
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.delegate = self;
    
    RootViewController *peizhenVC = [[RootViewController alloc] init];
    UINavigationController *navpei = [[UINavigationController alloc]initWithRootViewController:peizhenVC];
    peizhenVC.tabBarItem.title = @"首页";
    peizhenVC.tabBarItem.image = [[UIImage imageNamed:@"Triangle 1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    peizhenVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"Triangle s1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    UINavigationController *peizhenNavibar = [[UINavigationController alloc] initWithRootViewController:peizhenVC];
    
    OrderViewController *yuyueVC = [[OrderViewController alloc] init];
    yuyueVC.tabBarItem.title = @"订单";
    yuyueVC.tabBarItem.image = [[UIImage imageNamed:@"orderDislect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    yuyueVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"orderSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *yuyueNavi = [[UINavigationController alloc] initWithRootViewController:yuyueVC];
    
    MyViewController * myVC = [[MyViewController alloc] init];
    myVC.tabBarItem.title = @"个人中心";
    myVC.tabBarItem.image = [[UIImage imageNamed:@"MyDislect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"Myselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *myNavi = [[UINavigationController alloc] initWithRootViewController:myVC];
    
    tabBarVC.viewControllers = @[navpei, yuyueNavi, myNavi];
    
    self.window.rootViewController = tabBarVC;
}

-(void)getUserInfo{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,GetUserInfo];
    NSDictionary *dic = @{@"str":@"1"};
    self.manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [_manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",  @"text/json", @"text/html", @"text/javascript",nil]];
    if ([LoginStorage GetHTTPHeader].length != 0 || [LoginStorage GetHTTPHeader] != nil) {
        
        [_manager.requestSerializer setValue:[LoginStorage GetHTTPHeader] forHTTPHeaderField:@"Authorization"];
    }
    [self.manager POST:strUrl parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"用户信息：%@",responseObject);
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"SUCCESS"]) {
            if ([[[responseObject objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"0"]) {
                // 0 ：代表   未认证
                AuthenticationDataViewController *vc_auth = [[AuthenticationDataViewController alloc]init];
                UINavigationController *nav_auth = [[UINavigationController alloc]initWithRootViewController:vc_auth];
                [self.window setRootViewController:nav_auth];
            }
            if ([[[responseObject objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"1"]) {
                // 1 ：代表   认证中
                ReviewIngViewController *vc = [[ReviewIngViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
                [self.window setRootViewController:nav];
            }
            if ([[[responseObject objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"2"]) {
                // 2 ：代表   认证失败
                ReviewFailViewController *vc = [[ReviewFailViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
                [self.window setRootViewController:nav];
            }
            if ([[[responseObject objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"3"]) {
                // 3 ：代表   认证成功
                //  保存一个状态  确保认证通过界面只给用户展示一次
                if ([LoginStorage IsPassSeeing] == YES) {
                    // 展示过了  进入主界面
                    [self setTabBarRootView];
                }else{
                    // 没展示过  给用户看一下认证通过了,同时重新获取一遍token
                    [LoginStorage saveIsPassSeeing:YES];
                    ReviewPassViewController *vc = [[ReviewPassViewController alloc]init];
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
                    [self.window setRootViewController:nav];
                }
            }
        }else{
            
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (operation.response.statusCode == 401) {
            // 重新登录
            NSUserDefaults *userdefaults = [[NSUserDefaults alloc]init];
            [userdefaults removeObjectForKey:@"httpHeader"];
            NSLog(@"%@",[LoginStorage GetHTTPHeader]);
            [LoginStorage saveIsLogin:NO];
            SignInViewController* controller = [[SignInViewController alloc]init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
            controller.isSetRootView = YES;
            [self.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
        }
    }];
}
- (void)gotoSignIn {
    SignInViewController* controller = [[SignInViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
}

-(void)loadVersionMsg{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,VersionInfo];
    NSString *deviceVersion = [UIDevice currentDevice].systemVersion;
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *dic = @{@"os":@"ios",@"osversion":deviceVersion,@"role":@"nurse",@"roleversion":appVersion};
    AFNManager *manager = [[AFNManager alloc]init];
    [manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        if ([Status isEqualToString:SUCCESS]) {
    
            [LoginStorage saveShareDic:[[responseDic objectForKey:@"data"] objectForKey:@"share"]];
            [LoginStorage saveKefuPhoneNum:[[[responseDic objectForKey:@"data"] objectForKey:@"service"] objectForKey:@"telnum"]];
            [LoginStorage savesySBulletin:[[responseDic objectForKey:@"data"] objectForKey:@"sysBulletin"]];
            if ([[[responseDic objectForKey:@"data"] objectForKey:@"isuse"] isEqualToString:@"2"]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您的版本已不兼容，请到AppStore升级最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)testLocalNotifi
{
    NSLog(@"测试本地通知啦！！！");
    NSDate *fireDate = [[NSDate new] dateByAddingTimeInterval:5];
    [BPush localNotification:fireDate alertBody:@"这是本地通知" badge:3 withFirstAction:@"打开" withSecondAction:@"关闭" userInfo:nil soundName:nil region:nil regionTriggersOnce:YES category:nil];
}

// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
    // 打印到日志 textView 中
    NSLog(@"********** iOS7.0之后 background **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
//        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertView show];
    }
    else//杀死状态下，直接跳转到跳转页面。
    {
        
    }
    
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
    
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        
        // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
        //        if (result) {
        //            [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
        //                if (result) {
        //                    NSLog(@"设置tag成功");
        //                }
        //            }];
        //        }
    }];
    
    
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"接收本地通知啦！！！");
    [BPush showLocalNotificationAtFront:notification identifierKey:nil];
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
