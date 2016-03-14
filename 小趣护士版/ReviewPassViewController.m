//
//  ReviewPassViewController.m
//  小趣医生端
//
//  Created by 窦建斌 on 16/1/21.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "ReviewPassViewController.h"
#import "RootViewController.h"
#import "AppDelegate.h"

@interface ReviewPassViewController ()

@end

@implementation ReviewPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"审核结果";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor colorWithHexString:@"#4A4A4A"],
                                                                    UITextAttributeFont : [UIFont systemFontOfSize:17]};
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"kong"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    
    
    [self onCreate];
    [self getTokenAgain];
}

-(void)getTokenAgain{
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
    
    NSString *strUserName = [NSString stringWithFormat:@"N_%@",[LoginStorage GetPhoneNum]];
    NSString *token = [NSString stringWithFormat:@"grant_type=password&username=%@&password=%@",strUserName,[LoginStorage GetYanZhengMa]];
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
                                         
                                         [LoginStorage saveHTTPHeader:httpHeader];
                                         
                                         
                                     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         // 失败后的处理
                                         NSLog(@"%@", error);
                                     }];
    [manager.operationQueue addOperation:operation];
}

-(void)onCreate{
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - (49.5 / 2), 96.5 + 64, 49.5, 58.5)];
    [self.view addSubview:img];
    [img setImage:[UIImage imageNamed:@"reviewPass"]];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 197 + 64, SCREEN_WIDTH, 24)];
    [self.view addSubview:lab];
    [lab setText:@"您已通过审核，开始接单吧！"];
    lab.font = [UIFont systemFontOfSize:17];
    lab.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    lab.textAlignment = NSTextAlignmentCenter;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 98, SCREEN_WIDTH - 30, 44)];
    [self.view addSubview:btn];
    [btn setTitle:@"开始接单" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)btnAction{
    [(AppDelegate*)[UIApplication sharedApplication].delegate setTabBarRootView];
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
