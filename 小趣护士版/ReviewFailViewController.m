//
//  ReviewFailViewController.m
//  小趣医生端
//
//  Created by 窦建斌 on 16/1/21.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "ReviewFailViewController.h"
#import "AuthenticationDataViewController.h"

@interface ReviewFailViewController ()

@end

@implementation ReviewFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"认证结果";
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
    [img setImage:[UIImage imageNamed:@"reviewFail"]];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 197 + 64, SCREEN_WIDTH, 24)];
    [self.view addSubview:lab];
    [lab setText:@"您的审核未通过，请您重新填写或联系客服。"];
    lab.font = [UIFont systemFontOfSize:17];
    lab.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    lab.textAlignment = NSTextAlignmentCenter;
    
    UIButton *btnlianxi = [[UIButton alloc]initWithFrame:CGRectMake(0, 310, SCREEN_WIDTH, 24)];
    [self.view addSubview:btnlianxi];
    [btnlianxi setTitle:@"重新填写>>" forState:UIControlStateNormal];
    [btnlianxi setTitleColor:[UIColor colorWithHexString:@"#FA6262"] forState:UIControlStateNormal];
    btnlianxi.titleLabel.font = [UIFont systemFontOfSize:17];
    btnlianxi.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnlianxi addTarget:self action:@selector(btnlianxiAction) forControlEvents:UIControlEventTouchUpInside];
    
   UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 98, SCREEN_WIDTH - 30, 44)];
    [self.view addSubview:btn];
    [btn setTitle:@"联系客服" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)btnlianxiAction{
    AuthenticationDataViewController *vc = [[AuthenticationDataViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)btnAction{
    
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
