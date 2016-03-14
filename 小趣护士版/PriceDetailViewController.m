//
//  PriceDetailViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/17.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "PriceDetailViewController.h"
#import "RootDetailTableViewCell.h"
#import "NSString+Size.h"

@interface PriceDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)AFNManager *manager;
@property (nonatomic ,strong)NSDictionary *dic;
@property (nonatomic ,strong)UITableView *tb_up;
@property (nonatomic ,strong)UITableView *tb_down;
@property (nonatomic ,strong)NSArray *arr_up;
@property (nonatomic ,strong)NSArray *arr_down;

@end

@implementation PriceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"收费详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"Rectangle 91 + Line + Line Copy"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [btnl addTarget:self action:@selector(NavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
    
}

-(void)loadData{
    NSString *strUrl = [NSString stringWithFormat:@"%@/quhu/accompany/nurse/queryOrderDetails?id=%@",Development,self.orderId];
//    NSDictionary *dic = @{@"id":self.orderId};
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:nil result:^(id responseDic) {
        if ([Status isEqualToString:SUCCESS]) {
            self.dic = [responseDic objectForKey:@"data"];
            NSLog(@"%@",self.dic);
            self.arr_up = @[@"订单号：",@"开始陪诊时间：",@"结束陪诊时间：",@"订单状态："];
            [self oncreate];
        }else{
            FailMessage;
        }
    } fail:^(NSError *error) {
        
    }];
}

-(void)oncreate{
    UIView *view = [UIView new];
    [self.view addSubview:view];
    self.tb_up = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 57 * 4) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_up];
    self.tb_up.scrollEnabled = NO;
    self.tb_up.delegate = self;
    self.tb_up.dataSource = self;
    self.tb_up.rowHeight = 57;

    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 301.5 , 80, 14.5)];
    [self.view addSubview:lab];
    [lab setText:@"费用明细"];
    [lab setTextColor:[UIColor colorWithHexString:@"#969696"]];
    lab.font = [UIFont systemFontOfSize:14];

    
    if ([[self.dic objectForKey:@"couponValue"] isKindOfClass:[NSNull class]]) {
        self.tb_down = [[UITableView alloc]initWithFrame:CGRectMake(0, 324, SCREEN_WIDTH, 57 * 3) style:UITableViewStylePlain];
        self.arr_down = @[@"基础陪诊",@"超时费用",@"   "];
    }else{
        self.tb_down = [[UITableView alloc]initWithFrame:CGRectMake(0, 324, SCREEN_WIDTH, 57 * 4) style:UITableViewStylePlain];
        self.arr_down = @[@"基础陪诊",@"超时费用",@"优惠券",@"   "];
    }
    [self.view addSubview:self.tb_down];
    [self.tb_down setDelegate:self];
    [self.tb_down setDataSource:self];
    [self.tb_down setRowHeight:57];
    self.tb_down.scrollEnabled = NO;

    
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
    if (tableView == self.tb_up) {
        return self.arr_up.count;
    }
    if (tableView == self.tb_down) {
        return self.arr_down.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tb_up) {
        
        static NSString *CellIdentifier = @"tableViewCell";
        RootDetailTableViewCell *cell = [[RootDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *str = [self.arr_up objectAtIndex:indexPath.row];
        CGFloat with = [str fittingLabelHeightWithWidth:15 andFontSize:[UIFont systemFontOfSize:17]];
        [cell.lab_left setFrame:CGRectMake(15, 19.5, with, 18)];
        [cell.lab_left setText:str];
        if (indexPath.row == 0) {
            CGFloat width_right = [[self.dic objectForKey:@"orderNo"] fittingLabelHeightWithWidth:18 andFontSize:[UIFont systemFontOfSize:17]];
            [cell.lab_right setFrame:CGRectMake(with, 19.5, width_right, 18)];
            [cell.lab_right setText:[self.dic objectForKey:@"orderNo"]];
        }
        if (indexPath.row == 1) {
            CGFloat width_right = [[self.dic objectForKey:@"startTime"] fittingLabelHeightWithWidth:18 andFontSize:[UIFont systemFontOfSize:17]];
            [cell.lab_right setFrame:CGRectMake(with, 19.5, width_right, 18)];
            [cell.lab_right setText:[self.dic objectForKey:@"startTime"]];
        }
        if (indexPath.row == 2) {
            CGFloat width_right = [[self.dic objectForKey:@"endTime"] fittingLabelHeightWithWidth:18 andFontSize:[UIFont systemFontOfSize:17]];
            [cell.lab_right setFrame:CGRectMake(with, 19.5, width_right, 18)];
            [cell.lab_right setText:[self.dic objectForKey:@"endTime"]];
        }
        if (indexPath.row == 3) {
            int payStatus = [[self.dic objectForKey:@"payStatus"] intValue];
            [cell.lab_right setFrame:CGRectMake(with, 19.5, 80, 18)];
            [cell.lab_right setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
            cell.lab_right.font = [UIFont boldSystemFontOfSize:17];
            if (payStatus == 0) {
                [cell.lab_right setText:@"未支付"];
            }else{
                [cell.lab_right setText:@"已支付"];
            }
            
        }
        
        return cell;
    }
    if (tableView == self.tb_down) {
        static NSString *CellIdentifier = @"tableViewCell";
        RootDetailTableViewCell *cell = [[RootDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.lab_left setText:[self.arr_down objectAtIndex:indexPath.row]];
        cell.lab_left.alpha = 1.0;
        if (indexPath.row == 0) {
            [cell.lab_right setText:[NSString stringWithFormat:@"¥%@",[self.dic objectForKey:@"setAmount"]]];
        }
        if (indexPath.row == 1) {
            [cell.lab_right setText:[NSString stringWithFormat:@"¥%@",[self.dic objectForKey:@"overtimeAmount"]]];
        }
        if (![[self.dic objectForKey:@"couponValue"] isKindOfClass:[NSNull class]]) {
            if (indexPath.row == 2) {
                
                if ([[self.dic objectForKey:@"couponType"] intValue] == 1) {
                    //1为折扣卷
                    [cell.lab_right setText:[NSString stringWithFormat:@"%@折",[self.dic objectForKey:@"couponValue"]]];
                }else{
                    // 抵价卷
                    [cell.lab_right setText:[NSString stringWithFormat:@"-¥%@",[self.dic objectForKey:@"couponValue"]]];
                }
                [cell.lab_right setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
            }
        }
        
        if (indexPath.row == self.arr_down.count - 1) {
            [cell.lab_right setText:[NSString stringWithFormat:@"总计：¥%@",[self.dic objectForKey:@"totalAmount"]]];
            [cell.lab_right setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
            [cell.lab_right setFont:[UIFont boldSystemFontOfSize:17]];
        }
        [cell.lab_right setFrame:CGRectMake(SCREEN_WIDTH - 155, 20.5, 140, 16.5)];
        cell.lab_right.textAlignment = NSTextAlignmentRight;
        return cell;
    }
    return nil;
}


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
