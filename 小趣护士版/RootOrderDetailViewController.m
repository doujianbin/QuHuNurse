//
//  RootOrderDetailViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "RootOrderDetailViewController.h"
#import "RootDetailTableViewCell.h"
#import "Toast+UIView.h"

@interface RootOrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tb_detail;
@property (nonatomic ,strong)NSArray *arr_putong_left;
@property (nonatomic ,strong)NSArray *arr_texu_left;
@property (nonatomic ,strong)AFNManager *manager;

@end

@implementation RootOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"抢单详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"Rectangle 91 + Line + Line Copy"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [btnl addTarget:self action:@selector(NavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.orderEntity.orderType == 0) {
        self.arr_putong_left = @[@"订  单  号:",@"陪诊对象:",@"陪诊类型:",@"陪诊医院:",@"医院地址:",@"陪诊时间:"];
    }else{
        self.arr_texu_left = @[@"订  单  号:",@"陪诊对象:",@"陪诊类型:",@"负责医师:",@"陪诊医院",@"医院地址:",@"陪诊时间:"];
    }
    
    // Do any additional setup after loading the view.
//    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 8 + 64, 56, 14.5)];
//    [self.view addSubview:lab1];
//    [lab1 setText:@"订单信息"];
//    lab1.textColor = [UIColor colorWithHexString:@"#969696"];
//    lab1.font = [UIFont systemFontOfSize:14];
//    
//    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 215, 9 + 64, 200, 12.5)];
//    [self.view addSubview:lab2];
//    [lab2 setText:self.orderEntity.createTime];
//    lab2.font = [UIFont systemFontOfSize:12];
//    lab2.textColor = [UIColor colorWithHexString:@"#969696"];
//    lab2.textAlignment = NSTextAlignmentRight;
    
    [self onCreate];
}

-(void)onCreate{
    self.tb_detail = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStylePlain];
    [self.tb_detail setTableFooterView:[UIView new]];
    [self.view addSubview:self.tb_detail];
    [self.tb_detail setDataSource:self];
    [self.tb_detail setDelegate:self];
    [self.tb_detail reloadData];
    [self.tb_detail setRowHeight:57];
    
    UIButton *btn_qiangdan = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
    [self.view addSubview:btn_qiangdan];
    [btn_qiangdan setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    [btn_qiangdan setTitle:@"抢单" forState:UIControlStateNormal];
    btn_qiangdan.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn_qiangdan addTarget:self action:@selector(btnQiangdanAction) forControlEvents:UIControlEventTouchUpInside];
    
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
    if (self.orderEntity.orderType == 0) {
        return self.arr_putong_left.count;
    }else{
        return self.arr_texu_left.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"tableViewCell";
    RootDetailTableViewCell *cell = [[RootDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

    if (self.orderEntity.orderType == 0) {
        // 普通陪诊
        [cell.lab_left setText:[self.arr_putong_left objectAtIndex:indexPath.row]];
        if (indexPath.row == 0) {
            [cell.lab_right setText:self.orderEntity.orderNo];
        }
        if (indexPath.row == 1) {
            if (self.orderEntity.patientSex == 0) {
                [cell.lab_right setText:[NSString stringWithFormat:@"%@  男",self.orderEntity.patientName]];
            }else{
                [cell.lab_right setText:[NSString stringWithFormat:@"%@  女",self.orderEntity.patientName]];
            }
    
        }
        if (indexPath.row == 2) {
            if (self.orderEntity.orderType == 0) {
                [cell.lab_right setText:@"普通陪诊"];
            }else{
                [cell.lab_right setText:@"特需陪诊"];
            }
        }
        if (indexPath.row == 3) {
            [cell.lab_right setText:self.orderEntity.hospitalName];
        }
        if (indexPath.row == 4) {
            [cell.lab_right setText:self.orderEntity.hospitalAddress];
        }
        if (indexPath.row == 5) {
            [cell.lab_right setText:self.orderEntity.scheduleTime];
        }
    }else{
        // 特需陪诊
        [cell.lab_left setText:[self.arr_texu_left objectAtIndex:indexPath.row]];
        
        if (indexPath.row == 0) {
            [cell.lab_right setText:self.orderEntity.orderNo];
        }
        if (indexPath.row == 1) {
            if (self.orderEntity.patientSex == 0) {
                [cell.lab_right setText:[NSString stringWithFormat:@"%@  男",self.orderEntity.patientName]];
            }else{
                [cell.lab_right setText:[NSString stringWithFormat:@"%@  女",self.orderEntity.patientName]];
            }
            
        }
        if (indexPath.row == 2) {
            if (self.orderEntity.orderType == 0) {
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
            [labName setText:self.orderEntity.doctorName];
            [labName setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
            [labName setFont:[UIFont systemFontOfSize:16]];
            
            UILabel *labZhiCheng = [[UILabel alloc]initWithFrame:CGRectMake(147.5, 32.5, 100, 12.5)];
            [cell addSubview:labZhiCheng];
            [labZhiCheng setText:self.orderEntity.doctorTitle];
            [labZhiCheng setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
            [labZhiCheng setFont:[UIFont systemFontOfSize:12]];
            labZhiCheng.alpha = 0.7;
            
        }
        if (indexPath.row == 4) {
            [cell.lab_right setText:self.orderEntity.hospitalName];
        }
        if (indexPath.row == 5) {
            [cell.lab_right setText:self.orderEntity.hospitalAddress];
        }
        if (indexPath.row == 6) {
            [cell.lab_right setText:self.orderEntity.scheduleTime];
        }
        
    }
    
    return cell;
}

-(void)btnQiangdanAction{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,Qiangdan];
    self.manager = [[AFNManager alloc]init];
    NSDictionary *dic = @{@"orderId":self.orderEntity.orderId};
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        if ([Status isEqualToString:SUCCESS]) {
            [self.view makeToast:@"抢单成功" duration:1.2 position:@"center"];
        }
    } fail:^(NSError *error) {
        
    }];
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
