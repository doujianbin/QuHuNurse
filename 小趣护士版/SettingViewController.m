//
//  SettingViewController.m
//  小趣医生端
//
//  Created by 窦建斌 on 15/12/24.
//  Copyright © 2015年 窦建斌. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"
#import "SignInViewController.h"
#import "OpinionTableViewController.h"
#import "WebViewViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic ,retain)UITableView *tableView;
@property (nonatomic ,retain)NSMutableArray *arr_tab;
@end

@implementation SettingViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_tab = [[NSMutableArray alloc]initWithObjects:@"关于我们",@"意见反馈",@"帮助",@"联系客服", nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"Rectangle 91 + Line + Line Copy"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [btnl addTarget:self action:@selector(NavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57 * 4 + 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 57;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableView"];
    self.tableView.scrollEnabled = NO;
    
    UIButton *btn_tuichu = [[UIButton alloc]initWithFrame:CGRectMake(12, SCREEN_HEIGHT - 57 - 25, SCREEN_WIDTH - 24, 57)];
    [self.view addSubview:btn_tuichu];
    [btn_tuichu setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    [btn_tuichu setTitle:@"退出登录" forState:UIControlStateNormal];
    btn_tuichu.titleLabel.font = [UIFont systemFontOfSize:18];
    btn_tuichu.layer.cornerRadius = 3;
    btn_tuichu.layer.masksToBounds = YES;
    [btn_tuichu addTarget:self action:@selector(btnTuichuAction) forControlEvents:UIControlEventTouchUpInside];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_tab.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableView"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    [cell.textLabel setText:[self.arr_tab objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        OpinionTableViewController *vc = [[OpinionTableViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 0) {
        WebViewViewController *webVc = [[WebViewViewController alloc]init];
        webVc.strTitle = @"关于我们";
        webVc.strUrl = @"http://wx.haohushi.me/web/#/commonpage/about/ios/2";
        webVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVc animated:YES];
    }
    if (indexPath.row == 2) {
        WebViewViewController *webVc = [[WebViewViewController alloc]init];
        webVc.strTitle = @"帮助";
        webVc.strUrl = @"http://wx.haohushi.me/web/#/userCenter/help/ios/2";
        webVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVc animated:YES];
    }
    if (indexPath.row == 3) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"联系客服" message:[LoginStorage phonenum] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认拨打", nil];
        alert.tag = 11;
        [alert show];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)NavLeftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnTuichuAction{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"是否确认退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    alert.tag = 12;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 12) {
        
        if (buttonIndex == 1) {
            [LoginStorage saveIsLogin:NO];
            [LoginStorage saveIsPassSeeing:NO];
            SignInViewController *vc = [[SignInViewController alloc]init];
            vc.isSetRootView = YES;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
    if (alertView.tag == 11) {
        if (buttonIndex == 1) {
            NSString *str1 = @"tel://";
            NSString *str2 = [LoginStorage phonenum];
            NSString *stt = [NSString stringWithFormat:@"%@%@",str1,str2];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stt]];
        }
    }
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
