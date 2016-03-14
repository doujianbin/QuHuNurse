//
//  SignInViewController.m
//  小趣医生端
//
//  Created by 窦建斌 on 16/1/20.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "SignInViewController.h"
#import "CommonFunc.h"
#import "AuthenticationDataViewController.h"
#import "RootViewController.h"
#import "ReviewIngViewController.h"
#import "ReviewPassViewController.h"
#import "ReviewFailViewController.h"
#import "AppDelegate.h"
#import "BPush.h"
#import "WebViewViewController.h"
#define MAX_TIMEREMAINING 60
@interface SignInViewController ()<UITextFieldDelegate>

@property (nonatomic ,retain)UITextField *tef_phoneNum;
@property (nonatomic ,retain)UITextField *tef_yanzhengma;
@property (nonatomic ,retain)UIButton *btn_yanzhengma;
@property (nonatomic ,retain)UIButton *btn_denglu;
@property (nonatomic        )int timeRemaining;//剩余时间

@property (nonatomic ,strong)AFNManager *manager;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F9"]];
    self.title = @"登录";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor colorWithHexString:@"#4A4A4A"],
                                                                    UITextAttributeFont : [UIFont systemFontOfSize:17]};
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewAction)];
    NSLog(@"%f",SCREEN_HEIGHT);
    
    [self.view addGestureRecognizer:tapGesture];
    
    [self creatView];
}

-(void)creatView{
    
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(15, 15 + 64, SCREEN_WIDTH - 30, 44)];
    [self.view addSubview:aView];
    [aView setBackgroundColor:[UIColor whiteColor]];
    aView.layer.cornerRadius = 3.0f;
    aView.layer.masksToBounds = YES;
    aView.layer.borderWidth = 0.5f;
    aView.layer.borderColor = [[UIColor colorWithHexString:@"#DBDCDD"] CGColor];
    
    self.tef_phoneNum = [[UITextField alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 30 - 12, 44)];
    [aView addSubview:self.tef_phoneNum];
    [self.tef_phoneNum setBackgroundColor:[UIColor whiteColor]];
    self.tef_phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    self.tef_phoneNum.font = [UIFont systemFontOfSize:17];
    self.tef_phoneNum.delegate = self;
    self.tef_phoneNum.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    [self.tef_phoneNum setPlaceholder:@"请输入手机号"];
    
    UIView *bView = [[UIView alloc]initWithFrame:CGRectMake(15, 69 + 64, SCREEN_WIDTH - 145, 44)];
    [self.view addSubview:bView];
    [bView setBackgroundColor:[UIColor whiteColor]];
    bView.layer.cornerRadius = 3.0f;
    bView.layer.masksToBounds = YES;
    bView.layer.borderWidth = 0.5f;
    bView.layer.borderColor = [[UIColor colorWithHexString:@"#DBDCDD"] CGColor];
    
    self.tef_yanzhengma = [[UITextField alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 142, 44)];
    [bView addSubview:self.tef_yanzhengma];
    [self.tef_yanzhengma setBackgroundColor:[UIColor whiteColor]];
    self.tef_yanzhengma.keyboardType = UIKeyboardTypeNumberPad;
    self.tef_yanzhengma.font = [UIFont systemFontOfSize:17];
    self.tef_yanzhengma.delegate = self;
    self.tef_yanzhengma.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    [self.tef_yanzhengma setPlaceholder:@"请输入验证码"];
    
    self.btn_yanzhengma = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.tef_yanzhengma.frame) + 5, 69 + 64, 110, 44)];
    [self.view addSubview:self.btn_yanzhengma];
    [self.btn_yanzhengma setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    self.btn_yanzhengma.layer.cornerRadius = 3.0f;
    self.btn_yanzhengma.layer.masksToBounds = YES;
    [self.btn_yanzhengma setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.btn_yanzhengma setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    self.btn_yanzhengma.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn_yanzhengma addTarget:self action:@selector(yanzhengmaAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_denglu = [[UIButton alloc]initWithFrame:CGRectMake(15, 128 + 64, SCREEN_WIDTH - 30, 44)];
    [self.view addSubview:self.btn_denglu];
    self.btn_denglu.layer.cornerRadius = 3.0f;
    self.btn_denglu.layer.masksToBounds = YES;
    [self.btn_denglu setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    [self.btn_denglu setTitle:@"登录" forState:UIControlStateNormal];
    [self.btn_denglu setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    self.btn_denglu.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.btn_denglu addTarget:self action:@selector(btnDengLuAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString *myStr = [[NSMutableAttributedString alloc] initWithString:@"点击登录，即表示您同意《趣护护士服务协议》"];
    [myStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#969696"] range:NSMakeRange(0, 11)];
    [myStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, 11)];
    
    [myStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#4A90E2"] range:NSMakeRange(11, 10)];
    [myStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(11, 10)];

    UIButton *btn_xieyi = [[UIButton alloc]initWithFrame:CGRectMake(0, 246, 280, 14)];
    [self.view addSubview:btn_xieyi];
    [btn_xieyi setAttributedTitle:myStr forState:UIControlStateNormal];
    btn_xieyi.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn_xieyi addTarget:self action:@selector(xieyiAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)yanzhengmaAction:(id)sender{
    [self.tef_phoneNum resignFirstResponder];
    UIButton *button = (UIButton *)sender;
    
    if (self.tef_phoneNum.text.length > 3) {
        
        NSString *firstStr = [self.tef_phoneNum.text substringToIndex:1];
        NSString *secStr = [self.tef_phoneNum.text substringWithRange:NSMakeRange(1, 1)];
        if (self.tef_phoneNum.text.length == 0) {
            [self.view makeToast:@"请输入手机号" duration:1.0 position:@"center"];
            return;
        }if (self.tef_phoneNum.text.length != 11){
            [self.view makeToast:@"请输入正确手机号" duration:1.0 position:@"center"];
            return;
        }if (![firstStr isEqualToString:@"1"]){
            [self.view makeToast:@"请输入正确手机号" duration:1.0 position:@"center"];
            return;
        }if ([secStr isEqualToString:@"0"] || [secStr isEqualToString:@"1"] || [secStr isEqualToString:@"2"] || [secStr isEqualToString:@"6"]  || [secStr isEqualToString:@"9"]){
            [self.view makeToast:@"请输入正确手机号" duration:1.0 position:@"center"];
            return;
        }
        else{
            
            NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,MessageCode];
            self.manager = [[AFNManager alloc]init];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.tef_phoneNum.text, @"phoneNumber", nil];
            [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
                NSLog(@"%@",responseDic);
                if ([[responseDic objectForKey:@"status"] isEqualToString:SUCCESS]) {
                    [self.view makeToast:@"验证码已发送" duration:1.0 position:@"center"];
                }else{
                    FailMessage;
                }
                
            } fail:^(NSError *error) {
                NetError;
            }];
            
            button.enabled = NO;
            self.timeRemaining = MAX_TIMEREMAINING;
            [button setTitle:[NSString stringWithFormat:@"%d秒",MAX_TIMEREMAINING] forState:UIControlStateDisabled];
            [self startCountDownForReauth];
    }
    }else{
        [self.view makeToast:@"请输入手机号" duration:1.0 position:@"center"];
    }
}

- (void)startCountDownForReauth
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(countingDownForReauthAction:)
                                                    userInfo:nil
                                                     repeats:YES];
    
    [timer fire];
}

//定时改变按钮名称方法（注：该方法每隔间隔时间都会调用一次）
- (void)countingDownForReauthAction:(NSTimer *)timer
{
    if (self.timeRemaining > 0) {
        NSString *string = [NSString stringWithFormat:@"%dS后重新获取",self.timeRemaining--];
        [self.btn_yanzhengma setTitle:string forState:UIControlStateDisabled];
        [self.btn_yanzhengma setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
        [self.btn_yanzhengma setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
        
    }else{
        [timer invalidate];
        [self performSelectorOnMainThread:@selector(updateButtonStateAction:)
                               withObject:nil
                            waitUntilDone:NO];
    }
}

//更新验证码按钮状态
-(void)updateButtonStateAction:(id)sender
{
    //先改变状态，再设置该状态下的文字显示
    self.btn_yanzhengma.enabled = YES;
    [self.btn_yanzhengma setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.btn_yanzhengma setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    [self.btn_yanzhengma setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
}

-(void)btnDengLuAction{
    
    
    if (self.tef_phoneNum.text.length > 3) {
        
        NSString *firstStr = [self.tef_phoneNum.text substringToIndex:1];
        NSString *secStr = [self.tef_phoneNum.text substringWithRange:NSMakeRange(1, 1)];
        if (self.tef_phoneNum.text.length == 0) {
            [self.view makeToast:@"请输入手机号" duration:1.0 position:@"center"];
            return;
        }
        if (self.tef_phoneNum.text.length != 11) {
            [self.view makeToast:@"请输入正确手机号" duration:1.0 position:@"center"];
            return;
        }
        if (self.tef_yanzhengma.text.length == 0) {
            [self.view makeToast:@"请输入验证码" duration:1.0 position:@"center"];
            return;
        }if (![firstStr isEqualToString:@"1"]){
            [self.view makeToast:@"请输入正确手机号" duration:1.0 position:@"center"];
            return;
        }if ([secStr isEqualToString:@"0"] || [secStr isEqualToString:@"1"] || [secStr isEqualToString:@"2"] || [secStr isEqualToString:@"6"]  || [secStr isEqualToString:@"9"]){
            [self.view makeToast:@"请输入正确手机号" duration:1.0 position:@"center"];
            return;
        }
        else{
            
            self.manager = [[AFNManager alloc]init];
            NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,RegisterOrRefresh];
            NSString *strUserName = [NSString stringWithFormat:@"N_%@",self.tef_phoneNum.text];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:strUserName, @"username",self.tef_yanzhengma.text,@"password", nil];
            
            [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
                NSLog(@"验证是否正确=%@",responseDic);
                
                if ([[responseDic objectForKey:@"status"] isEqualToString:SUCCESS]) {
                    [self GetLoginToken];
                    [LoginStorage nurseId:[NSString stringWithFormat:@"%@",[[responseDic objectForKey:@"data"] objectForKey:@"userId"]]];
                    
                }else{
                    FailMessage;
                }
            } fail:^(NSError *error) {
                NetError;
            }];
        }
    }else{
        [self.view makeToast:@"请输入手机号" duration:1.0 position:@"center"];
    }
}

-(void)GetLoginToken{
    
    [self.tef_phoneNum resignFirstResponder];
    [self.tef_yanzhengma resignFirstResponder];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,GetToken];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",  @"text/json", @"text/html", @"text/javascript",@"x-www-form-urlencoded",nil]];
    
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    //    NSString *strHttpHeader = [NSString stringWithFormat:@"Basic %@",[CommonFunc base64StringFromText:@"accompany-nurse-client:ccbPASSquyiyuan20154421"]];
    NSString *strHttpHeader = @"Basic YWNjb21wYW55LW51cnNlLWNsaWVudDpjY2JQQVNTcXV5aXl1YW4yMDE1NDQyMQ==";
    [request setValue:strHttpHeader
   forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSString *strUserName = [NSString stringWithFormat:@"N_%@",self.tef_phoneNum.text];
    NSString *token = [NSString stringWithFormat:@"grant_type=password&username=%@&password=%@",strUserName,self.tef_yanzhengma.text];
    NSData *data = [token dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         // 成功后的处理
                                         NSLog(@"登陆成功返回 == %@",responseObject);
                                         NSString *token_type = [responseObject objectForKey:@"token_type"];
                                         NSString *access_token = [responseObject objectForKey:@"access_token"];
                                         NSString *httpHeader = [NSString stringWithFormat:@"%@ %@",token_type,access_token];
                                         [LoginStorage savePhoneNum:self.tef_phoneNum.text];
                                         [LoginStorage saveYanZhengMa:self.tef_yanzhengma.text];
                                         [LoginStorage saveHTTPHeader:httpHeader];
                                         [LoginStorage saveIsLogin:YES];
                                         NSString *channelId = [BPush getChannelId];
                                         if (channelId.length != 0) {
                                             
                                             [self saveChannelId];
                                         }
                                         // 获取token成功之后  查询当前用户认证状态
                                         [self getUserInfo];
                                         
                                     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         // 失败后的处理
                                         NSLog(@"%@", error);
                                     }];
    [manager.operationQueue addOperation:operation];
    
}

-(void)getUserInfo{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,GetUserInfo];
    NSDictionary *dic = @{@"str":@"1"};
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        NSLog(@"用户信息：%@",responseDic);
        if ([[responseDic objectForKey:@"status"] isEqualToString:@"SUCCESS"]) {
            
            if ([[[responseDic objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"0"]) {
                // 0 ：代表   未认证
                AuthenticationDataViewController *vc_auth = [[AuthenticationDataViewController alloc]init];
                [self.navigationController pushViewController:vc_auth animated:YES];
            }
            if ([[[responseDic objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"1"]) {
                // 1 ：代表   认证中
                ReviewIngViewController *vc = [[ReviewIngViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([[[responseDic objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"2"]) {
                // 2 ：代表   认证失败
                ReviewFailViewController *vc = [[ReviewFailViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([[[responseDic objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"3"]) {
                // 3 ：代表   认证成功
                //  保存一个状态  确保认证通过界面只给用户展示一次
                if ([LoginStorage IsPassSeeing] == YES) {
                    // 展示过了  进入主界面
                    if (self.isSetRootView) {
                        [(AppDelegate*)[UIApplication sharedApplication].delegate setTabBarRootView];
                    }else{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                }else{
                    // 没展示过  给用户看一下认证通过了
                    [LoginStorage saveIsPassSeeing:YES];
                    ReviewPassViewController *vc = [[ReviewPassViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
            }
        }
        
    } fail:^(NSError *error) {
        
    }];
}

-(void)saveChannelId{
    NSString *channelId = [BPush getChannelId];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,SaveChannelId];
    NSDictionary *dic = @{@"channelId":channelId,@"deviceType":@"1"};
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        
    } fail:^(NSError *error) {
        
    }];
}

-(void)viewAction{
    [self.tef_phoneNum resignFirstResponder];
    [self.tef_yanzhengma resignFirstResponder];
}

-(void)xieyiAction{
    WebViewViewController *webVc = [[WebViewViewController alloc]init];
    webVc.strTitle = @"趣护护士服务协议";
    webVc.strUrl = @"http://wx.haohushi.me/web/#/commonpage/agreement/ios/2";
    [self.navigationController pushViewController:webVc animated:YES];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.tef_phoneNum) {
        if (string.length == 0)
            return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
        if (string.length < 11) {
//            NSLog(@"小于11");
        }
        if (existedLength - selectedLength + replaceLength == 11) {
            
//            NSLog(@"等于11");
        }
    }
    if (textField== self.tef_yanzhengma) {
        if (string.length == 0)
            return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 6) {
            return NO;
        }
        if (string.length < 6) {
//            NSLog(@"小于11");
        }
        if (existedLength - selectedLength + replaceLength == 6) {
            
//            NSLog(@"等于11");
        }
    }
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
