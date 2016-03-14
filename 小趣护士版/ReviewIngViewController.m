//
//  ReviewIngViewController.m
//  小趣医生端
//
//  Created by 窦建斌 on 16/1/21.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "ReviewIngViewController.h"
#import "ReviewPassViewController.h"
#import "ReviewFailViewController.h"

@interface ReviewIngViewController ()<UIAlertViewDelegate>
@property (nonatomic ,strong)AFNManager *manager;

@end

@implementation ReviewIngViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"待审核";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor colorWithHexString:@"#4A4A4A"],
                                                                    UITextAttributeFont : [UIFont systemFontOfSize:17]};
    // Do any additional setup after loading the view.
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"kong"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [self onCreate];
}

-(void)onCreate{
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - (49.5 / 2), 96.5 + 64, 49.5, 58.5)];
    [self.view addSubview:img];
    [img setImage:[UIImage imageNamed:@"reviewing"]];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 197 + 64, SCREEN_WIDTH, 24)];
    [self.view addSubview:lab];
    [lab setText:@"正在审核，我们会尽快与您取得联系。"];
    lab.font = [UIFont systemFontOfSize:17];
    lab.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    lab.textAlignment = NSTextAlignmentCenter;
    
    UIButton * btnR = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 45, 10, 30, 24)];
    [btnR setTitle:@"刷新" forState:UIControlStateNormal];
    [btnR setTitleColor:[UIColor colorWithHexString:@"#FA6262"] forState:UIControlStateNormal];
    btnR.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc]initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = btnright;
    [btnR addTarget:self action:@selector(btnRSave) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 98, SCREEN_WIDTH - 30, 44)];
    [self.view addSubview:btn];
    [btn setTitle:@"联系客服" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)btnRSave{
    [self getUserInfo];
}

-(void)btnAction{
    NSString *phone = [LoginStorage phonenum];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"联系客服" message:phone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *str1 = @"tel://";
        NSString *str2 = [LoginStorage phonenum];
        NSString *stt = [NSString stringWithFormat:@"%@%@",str1,str2];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stt]];
    }
}

-(void)getUserInfo{
    [self.view makeToastActivity];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,GetUserInfo];
    NSDictionary *dic = @{@"str":@"1"};
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        [self.view hideToastActivity];
        if ([[responseDic objectForKey:@"status"] isEqualToString:@"SUCCESS"]) {
            
            if ([[[responseDic objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"0"]) {
                // 0 ：代表   未认证
//                AuthenticationDataViewController *vc_auth = [[AuthenticationDataViewController alloc]init];
//                [self.navigationController pushViewController:vc_auth animated:YES];
            }
            if ([[[responseDic objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"1"]) {
                [self.view makeToast:@"您的资料正在审核" duration:1.0 position:@"center"];
            }
            if ([[[responseDic objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"2"]) {
                // 2 ：代表   认证失败
                ReviewFailViewController *vc = [[ReviewFailViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([[[responseDic objectForKey:@"data"] objectForKey:@"certificationStatus"] isEqualToString:@"3"]) {
                // 3 ：代表   认证成功
                //  保存一个状态  确保认证通过界面只给用户展示一次
                   [self.view makeToast:@"恭喜您，认证成功" duration:1.0 position:@"center"];
                   [NSTimer scheduledTimerWithTimeInterval:1.5
                                                 target:self
                                               selector:@selector(Success)
                                               userInfo:nil
                                                repeats:NO];
                
                
            }
        }
        
    } fail:^(NSError *error) {
        [self.view hideToastActivity];
        NetError;
    }];
}

-(void)Success{
    ReviewPassViewController *vc = [[ReviewPassViewController alloc]init];
    [LoginStorage saveIsPassSeeing:YES];
    [self.navigationController pushViewController:vc animated:YES];
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
