//
//  MyViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "MyViewController.h"
#import "UserInfoEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailUserInfoViewController.h"
#import "TiXianViewController.h"
#import "MyBankCardViewController.h"
#import "IncomeStatementViewController.h"
#import "SettingViewController.h"
#import "TuiJianViewController.h"
#import "WebViewViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,retain)UITableView *tableView1;
@property (nonatomic ,retain)UITableView *tableView2;
@property (nonatomic ,retain)NSMutableArray *arrTab2;
@property (nonatomic ,strong)AFNManager *manager;
@property (nonatomic ,strong)UserInfoEntity *userInfoEntity;
@property (nonatomic ,strong)NSDictionary *sysBulletin;

@end

@implementation MyViewController
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"个人中心";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    // Do any additional setup after loading the view.
    [self onCreate];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

-(void)onCreate{
//    UIView *aview = [UIView new];
//    [self.view addSubview:aview];
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150 + 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView1];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.rowHeight = 75;
    //    [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableView1"];
    self.tableView1.scrollEnabled = NO;
    
//    if (self.userInfoEntity.recommendFlag == 1) {
//        // 0 为不显示   1 为显示
//        self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 150 + 74, SCREEN_WIDTH, 171 + 57 ) style:UITableViewStylePlain];
//    }else{
//        self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 150 + 74, SCREEN_WIDTH, 171) style:UITableViewStylePlain];
//    }
    self.tableView2 = [[UITableView alloc]init];
//    self.tableView2. = UITableViewStylePlain;
    [self.view addSubview:self.tableView2];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.rowHeight = 57;
    [self.tableView2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableView2"];
    self.tableView2.scrollEnabled = NO;
}

-(void)loadData{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,QueryPersonalInfo];
    NSDictionary *dic = @{@"aa":@"s"};
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        NSLog(@"个人信息:%@",responseDic);
        if ([Status isEqualToString:SUCCESS]) {
            self.userInfoEntity = [UserInfoEntity parseUserInfoEntityWithJson:[responseDic objectForKey:@"data"]];
            if (self.userInfoEntity.recommendFlag == 0) {
                self.arrTab2 = [[NSMutableArray alloc]initWithObjects:@"收益明细",@"我的银行卡",@"设置", nil];
                self.tableView2.frame = CGRectMake(0, 150 + 74, SCREEN_WIDTH, 171);
            }else{
                self.arrTab2 = [[NSMutableArray alloc]initWithObjects:@"收益明细",@"我的银行卡",@"邀请有奖",@"设置", nil];
                self.tableView2.frame = CGRectMake(0, 150 + 74, SCREEN_WIDTH, 171 + 57 );
            }
            [self.tableView1 reloadData];
            [self.tableView2 reloadData];
        }else{
            FailMessage;
        }
    } fail:^(NSError *error) {
        NetError;
    }];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView1) {
        return 2;
    }
    if (tableView == self.tableView2) {
        if (self.userInfoEntity.recommendFlag == 0) {
            // 0 为不显示   1 为显示
            return 3;
        }else{
            return 4;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView1) {
        //        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView1"];
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            UIImageView *img_headPic = [[UIImageView alloc]initWithFrame:CGRectMake(15, 7.5, 60, 60)];
            [cell addSubview:img_headPic];
            [img_headPic sd_setImageWithURL:[NSURL URLWithString:self.userInfoEntity.photo] placeholderImage:[UIImage imageNamed:@"ic_医生介绍"]];
            
            UILabel *lab_name = [[UILabel alloc]initWithFrame:CGRectMake(90, 15.5, SCREEN_WIDTH - 110, 25)];
            [cell addSubview:lab_name];
            lab_name.font = [UIFont systemFontOfSize:18];
            lab_name.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
            [lab_name setText:self.userInfoEntity.name];
            
            UIImageView *img_renzheng = [[UIImageView alloc]initWithFrame:CGRectMake(90, 45, 49, 16)];
            [cell addSubview:img_renzheng];
            [img_renzheng setImage:[UIImage imageNamed:@"icon_shimingrenzhen"]];
            
            UILabel *lab_level = [[UILabel alloc]initWithFrame:CGRectMake(90, 43, 200, 16.5)];
            [cell addSubview:lab_level];
            lab_level.font = [UIFont systemFontOfSize:12];
            lab_level.textColor = [UIColor colorWithHexString:@"#969696"];
            [lab_level setText:self.userInfoEntity.title];
            
        }
        if (indexPath.row == 1) {
            UILabel *lab_ZHYE = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5, 48, 16.5)];
            [cell addSubview:lab_ZHYE];
            lab_ZHYE.font = [UIFont systemFontOfSize:12];
            lab_ZHYE.textColor = [UIColor colorWithHexString:@"#969696"];
            [lab_ZHYE setText:@"账户余额"];
            
            UILabel *lab_money = [[UILabel alloc]initWithFrame:CGRectMake(15, 29, 150, 33.5)];
            [cell addSubview:lab_money];
            [lab_money setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
            lab_money.font = [UIFont systemFontOfSize:24];
            NSString *strAccount = self.userInfoEntity.account;
            
            if (strAccount.length > 0) {
                [lab_money setText:strAccount];
            }else{
                
                [lab_money setText:@"0.00"];
            }
            
            UIButton *btn_tixian = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 115, 15.5, 100, 44)];
            [cell addSubview:btn_tixian];
            btn_tixian.layer.cornerRadius = 3.0f;
            btn_tixian.layer.masksToBounds = YES;
            [btn_tixian setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
            [btn_tixian setTitle:@"提现" forState:UIControlStateNormal];
            btn_tixian.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
            btn_tixian.titleLabel.font = [UIFont systemFontOfSize:18];
            [btn_tixian addTarget:self action:@selector(btnTixianAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        return cell;
    }
    if (tableView == self.tableView2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        [cell.textLabel setFrame:CGRectMake(15, 16, 72, 25)];
        [cell.textLabel setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        [cell.textLabel setText:[self.arrTab2 objectAtIndex:indexPath.row]];
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (tableView == self.tableView1) {
        if (indexPath.row == 0) {
            DetailUserInfoViewController *detailView = [[DetailUserInfoViewController alloc]init];
            detailView.userInfoEntity = self.userInfoEntity;
            [self.navigationController pushViewController:detailView animated:YES];
        }
    }
    if (tableView == self.tableView2) {
        if (self.userInfoEntity.recommendFlag == 1) {
            if (indexPath.row == 0) {
                IncomeStatementViewController *vc = [[IncomeStatementViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row == 1) {
                MyBankCardViewController *cardView = [[MyBankCardViewController alloc]init];
                [self.navigationController pushViewController:cardView animated:YES];
            }
            if (indexPath.row == 2) {
                TuiJianViewController *vc = [[TuiJianViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
//            if (indexPath.row == 3) {
//                WebViewViewController *vc = [[WebViewViewController alloc]init];
//                vc.strTitle = [self.sysBulletin objectForKey:@"title"];
//                vc.strUrl = [self.sysBulletin objectForKey:@"url"];
//                vc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
            if (indexPath.row == 3) {
                SettingViewController *setView = [[SettingViewController alloc]init];
                [self.navigationController pushViewController:setView animated:YES];
            }
        }else{
            if (indexPath.row == 0) {
                IncomeStatementViewController *vc = [[IncomeStatementViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row == 1) {
                MyBankCardViewController *cardView = [[MyBankCardViewController alloc]init];
                [self.navigationController pushViewController:cardView animated:YES];
            }
//            if (indexPath.row == 2) {
//                TuiJianViewController *vc = [[TuiJianViewController alloc]init];
//                vc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
            if (indexPath.row == 2) {
                SettingViewController *setView = [[SettingViewController alloc]init];
                [self.navigationController pushViewController:setView animated:YES];
            }
        }
    }
}

-(void)btnTixianAction{
    NSString *strAccount = self.userInfoEntity.account;
    
    if (strAccount.length > 0) {
        
        TiXianViewController *tixian = [[TiXianViewController alloc]init];
        tixian.account = self.userInfoEntity.account;
        [self.navigationController pushViewController:tixian animated:YES];
    }else{
        
        TiXianViewController *tixian = [[TiXianViewController alloc]init];
        tixian.account = @"0.00";
        [self.navigationController pushViewController:tixian animated:YES];
    }
    
}

-(void)NavLeftAction{
    [self.navigationController popViewControllerAnimated:YES];
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
