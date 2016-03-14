//
//  BeginServiceViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/17.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "BeginServiceViewController.h"
#import "RootDetailTableViewCell.h"
#import "Toast+UIView.h"
#import "EndServiceViewController.h"
@interface BeginServiceViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic ,strong)UITableView *tb_detail;
@property (nonatomic ,strong)NSArray *arr_putong_left;
@property (nonatomic ,strong)NSArray *arr_texu_left;
@property (nonatomic ,strong)AFNManager *manager;
@property (nonatomic ,strong)NSDictionary *dic;

@end

@implementation BeginServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"Rectangle 91 + Line + Line Copy"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [btnl addTarget:self action:@selector(NavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    [self loadData];
    
}

-(void)loadData{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,OrderDetail];
    NSDictionary *dic = @{@"orderId":self.orderId};
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        if ([Status isEqualToString:SUCCESS]) {
            self.dic = [responseDic objectForKey:@"data"];
            [self onCreate];
        }else{
            FailMessage;
        }
    } fail:^(NSError *error) {
        NetError;
    }];
}

-(void)onCreate{
    
    if ([[self.dic objectForKey:@"orderType"] intValue] == 0) {
        self.arr_putong_left = @[@"订  单  号:",@"陪诊对象:",@"陪诊类型:",@"陪诊医院:",@"医院地址:",@"陪诊时间:"];
    }else{
        self.arr_texu_left = @[@"订  单  号:",@"陪诊对象:",@"陪诊类型:",@"负责医师:",@"陪诊医院",@"医院地址:",@"陪诊时间:"];
    }
    
//    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 8 + 64, 56, 14.5)];
//    [self.view addSubview:lab1];
//    [lab1 setText:@"订单信息"];
//    lab1.textColor = [UIColor colorWithHexString:@"#969696"];
//    lab1.font = [UIFont systemFontOfSize:14];
//    
//    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 215, 9 + 64, 200, 12.5)];
//    [self.view addSubview:lab2];
//    [lab2 setText:[self.dic objectForKey:@"createTime"]];
//    lab2.font = [UIFont systemFontOfSize:12];
//    lab2.textColor = [UIColor colorWithHexString:@"#969696"];
//    lab2.textAlignment = NSTextAlignmentRight;
    UIView *view = [UIView new];
    [self.view addSubview:view];
    self.tb_detail = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStylePlain];
    [self.tb_detail setTableFooterView:[UIView new]];
    [self.view addSubview:self.tb_detail];
    [self.tb_detail setDataSource:self];
    [self.tb_detail setDelegate:self];
    [self.tb_detail reloadData];
    [self.tb_detail setRowHeight:57];
    [self.tb_detail reloadData];
    
    UIButton *btn_begin = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
    [self.view addSubview:btn_begin];
    [btn_begin setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    [btn_begin setTitle:@"服务开始" forState:UIControlStateNormal];
    btn_begin.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn_begin addTarget:self action:@selector(beginServiceAction) forControlEvents:UIControlEventTouchUpInside];
}

// 分割线左侧顶头
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[self.dic objectForKey:@"orderType"] intValue] == 0) {
        return self.arr_putong_left.count;
    }else{
        return self.arr_texu_left.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"tableViewCell";
    RootDetailTableViewCell *cell = [[RootDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([[self.dic objectForKey:@"orderType"] intValue] == 0) {
        // 普通陪诊
        [cell.lab_left setText:[self.arr_putong_left objectAtIndex:indexPath.row]];
        if (indexPath.row == 0) {
            [cell.lab_right setText:[self.dic objectForKey:@"orderNo"]];
        }
        if (indexPath.row == 1) {
            if ([[self.dic objectForKey:@"patientAge"] intValue] == 0) {
                [cell.lab_right setText:[NSString stringWithFormat:@"%@  男",[self.dic objectForKey:@"patientName"]]];
            }else{
                [cell.lab_right setText:[NSString stringWithFormat:@"%@  女",[self.dic objectForKey:@"patientName"]]];
            }
            UIButton *btnPhone = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 102.5, 11, 80, 35)];
            [cell addSubview:btnPhone];
            [btnPhone setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
            [btnPhone setTitle:@"拨打电话" forState:UIControlStateNormal];
            btnPhone.titleLabel.font = [UIFont systemFontOfSize:16];
            btnPhone.layer.cornerRadius = 3.0;
            btnPhone.layer.masksToBounds = YES;
            [btnPhone addTarget:self action:@selector(btnPhoneAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
        if (indexPath.row == 2) {
            if ([[self.dic objectForKey:@"orderType"] intValue] == 0) {
                [cell.lab_right setText:@"普通陪诊"];
            }else{
                [cell.lab_right setText:@"特需陪诊"];
            }
        }
        if (indexPath.row == 3) {
            [cell.lab_right setText:[self.dic objectForKey:@"hospitalName"]];
        }
        if (indexPath.row == 4) {
            [cell.lab_right setText:[self.dic objectForKey:@"hospitalAddress"]];
        }
        if (indexPath.row == 5) {
            [cell.lab_right setText:[self.dic objectForKey:@"scheduleTime"]];
        }
    }else{
        // 特需陪诊
        [cell.lab_left setText:[self.arr_texu_left objectAtIndex:indexPath.row]];
        
        if (indexPath.row == 0) {
            [cell.lab_right setText:[self.dic objectForKey:@"orderNo"]];
        }
        if (indexPath.row == 1) {
            if ([[self.dic objectForKey:@"patientAge"] intValue] == 0) {
                [cell.lab_right setText:[NSString stringWithFormat:@"%@  男",[self.dic objectForKey:@"patientName"]]];
            }else{
                [cell.lab_right setText:[NSString stringWithFormat:@"%@  女",[self.dic objectForKey:@"patientName"]]];
            }
            UIButton *btnPhone = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 102.5, 11, 80, 35)];
            [cell addSubview:btnPhone];
            [btnPhone setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
            [btnPhone setTitle:@"拨打电话" forState:UIControlStateNormal];
            btnPhone.titleLabel.font = [UIFont systemFontOfSize:16];
            btnPhone.layer.cornerRadius = 3.0;
            btnPhone.layer.masksToBounds = YES;
            [btnPhone addTarget:self action:@selector(btnPhoneAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
        if (indexPath.row == 2) {
            if ([[self.dic objectForKey:@"orderType"] intValue] == 0) {
                [cell.lab_right setText:@"普通陪诊"];
            }else{
                [cell.lab_right setText:@"特需陪诊"];
            }
            [cell.lab_right setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
        }
        if (indexPath.row == 3) {
            UIImageView *img_pic = [[UIImageView alloc]initWithFrame:CGRectMake(100.5, 10.5, 37, 37)];
            [cell addSubview:img_pic];
            [img_pic setImage:[UIImage imageNamed:@"ic_医生介绍"]];
            
            UILabel *labName = [[UILabel alloc]initWithFrame:CGRectMake(147.5, 12.5, 60, 16.5)];
            [cell addSubview:labName];
            [labName setText:[self.dic objectForKey:@"doctorName"]];
            [labName setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
            [labName setFont:[UIFont systemFontOfSize:16]];
            
            UILabel *labZhiCheng = [[UILabel alloc]initWithFrame:CGRectMake(147.5, 32.5, 100, 12.5)];
            [cell addSubview:labZhiCheng];
            [labZhiCheng setText:[self.dic objectForKey:@"doctorTitle"]];
            [labZhiCheng setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
            [labZhiCheng setFont:[UIFont systemFontOfSize:12]];
            labZhiCheng.alpha = 0.7;
            
        }
        if (indexPath.row == 4) {
            [cell.lab_right setText:[self.dic objectForKey:@"hospitalName"]];
        }
        if (indexPath.row == 5) {
            [cell.lab_right setText:[self.dic objectForKey:@"hospitalAddress"]];
        }
        if (indexPath.row == 6) {
            [cell.lab_right setText:[self.dic objectForKey:@"scheduleTime"]];
        }
    
    }
    
    return cell;
}

-(void)beginServiceAction{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确认开始服务？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alert.delegate = self;
    alert.tag = 102;
    [alert show];
}

-(void)btnPhoneAction{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定拨打" message:[self.dic objectForKey:@"patientPhoneNumber"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 101;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        
        if (buttonIndex == 1) {
            NSString *str1 = @"tel://";
            NSString *str2 = [self.dic objectForKey:@"patientPhoneNumber"];
            NSString *stt = [NSString stringWithFormat:@"%@%@",str1,str2];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stt]];
        }
    }
    if (alertView.tag == 102) {
        if (buttonIndex == 1) {
            [self.view makeToastActivity];
            NSString *strUrl = [NSString stringWithFormat:@"%@/quhu/accompany/nurse/serveStart",Development];
            NSDictionary *dic = @{@"orderId":self.orderId};
            self.manager = [[AFNManager alloc]init];
            [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
                [self.view hideToastActivity];
                if ([Status isEqualToString:SUCCESS]) {
                    EndServiceViewController *vc = [[EndServiceViewController alloc]init];
                    vc.orderId = self.orderId;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    FailMessage;
                }
            } fail:^(NSError *error) {
                NetError;
                [self.view hideToastActivity];
            }];
        }
    }
}

//-(void)viewWillAppear:(BOOL)animated{
//    [self.tabBarController.tabBar setHidden:YES];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [self.tabBarController.tabBar setHidden:NO];
//}

-(void)NavLeftAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
