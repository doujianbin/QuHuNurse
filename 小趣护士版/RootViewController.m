//
//  RootViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "RootViewController.h"
#import "Toast+UIView.h"
#import "RootTableViewCell.h"
#import "RootOrderEntity.h"
#import "RootOrderDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "SignInViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tb_order;
@property (nonatomic ,strong)NSMutableArray *arr_tableView;
@property (nonatomic ,strong)AFNManager *manager;
@property (nonatomic ,strong)UIView *tab_backGroundView;
@property (nonatomic ,strong)RootOrderEntity *orderEntity;
@property (nonatomic ,strong)UILabel  *lb_status;
@property (nonatomic ,strong)UISwitch *sw_status;
@end

@implementation RootViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_tableView = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"首页";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    // Do any additional setup after loading the view.
    
    UIView *v_left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.sw_status = [[UISwitch alloc]initWithFrame:CGRectMake(-10, 6, 50, 16)];
    self.sw_status.transform = CGAffineTransformMakeScale(0.75, 0.70);
    self.sw_status.onTintColor = [UIColor colorWithHexString:@"#4A90E2"];
    [self.sw_status addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventValueChanged];
    [v_left addSubview:self.sw_status];
    self.lb_status = [[UILabel alloc]initWithFrame:CGRectMake(42, 0, 30, 44)];
    
    [self.lb_status setFont:[UIFont boldSystemFontOfSize:12]];
    [self.lb_status setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [v_left addSubview:self.lb_status];
    

    UIBarButtonItem *btn_left = [[UIBarButtonItem alloc]initWithCustomView:v_left];
    [self.navigationItem setLeftBarButtonItem:btn_left];
    
    [self onCreate];
    [self loadData];
}

- (void)changeAction{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,ChangeWorkFlag];
    self.manager = [[AFNManager alloc]init];
    if (self.sw_status.on) {
        [LoginStorage saveIsNotWorking:@"1"];
        [self.lb_status setText:@"上班"];
        //传1
        NSDictionary *dic = @{@"FLAG":@"1"};
        [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
            if ([Status isEqualToString:SUCCESS]) {
                [self.view makeToast:@"更新成功" duration:1.0 position:@"center"];
            }
        } fail:^(NSError *error) {
            
        }];
        
    }else{
        [LoginStorage saveIsNotWorking:@"0"];
        [self.lb_status setText:@"下班"];
        //传0
        NSDictionary *dic = @{@"FLAG":@"0"};
        [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
            if ([Status isEqualToString:SUCCESS]) {
                [self.view makeToast:@"更新成功" duration:1.0 position:@"center"];
            }
        } fail:^(NSError *error) {
            
        }];
    }
}



-(void)loadData{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,QueryMayGrabOrders];
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:nil result:^(id responseDic) {
        NSLog(@"订单列表=%@",responseDic);
        [self.tb_order.mj_header endRefreshing];
        [self.arr_tableView removeAllObjects];
        if ([Status isEqualToString:SUCCESS]) {
            NSArray *arr = [[responseDic objectForKey:@"data"] objectForKey:@"orderShowList"];
            NSString *isInWork = [NSString stringWithFormat:@"%@",[[responseDic objectForKey:@"data"] objectForKey:@"isInWork"]];
            [LoginStorage saveIsNotWorking:isInWork];
            
            if ([[LoginStorage IsNotWorking] isEqualToString:@"1"]) {
                [self.lb_status setText:@"上班"];
                [self.sw_status setOn:YES];
            }else{
                [self.lb_status setText:@"下班"];
                [self.sw_status setOn:NO];
            }
            
            for (NSDictionary *dic in arr) {
                
                [self.arr_tableView addObject:[RootOrderEntity parseRootOrderEntityWithJson:dic]];
            }
            [self.tb_order reloadData];
            if (arr.count == 0) {
                [self.tb_order setBackgroundView:self.tab_backGroundView];
            }else{
                [self.tb_order setBackgroundView:nil];
            }
        }
    } fail:^(NSError *error) {
        [self.tb_order.mj_header endRefreshing];
    }];
    
}

-(void)onCreate{
    
    self.tb_order = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_order];
    [self.tb_order setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.tb_order.delegate = self;
    self.tb_order.dataSource = self;
    self.tb_order.rowHeight = 184.5;
    [self.tb_order setSeparatorColor:[UIColor clearColor]];
    self.tb_order.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    self.tab_backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.tb_order.frame.size.width, self.tb_order.frame.size.height)];
    UIImageView *img_nothing = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 115) / 2 ,(self.tab_backGroundView.frame.size.height - 127)/2 - 80, 115, 127)];
    [self.tab_backGroundView addSubview:img_nothing];
    [img_nothing setImage:[UIImage imageNamed:@"nothingView"]];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(img_nothing.frame) + 20 , SCREEN_WIDTH, 20)];
    [self.tab_backGroundView addSubview:lab];
    lab.font = [UIFont boldSystemFontOfSize:16];
    lab.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
    lab.textAlignment = NSTextAlignmentCenter;
    [lab setText:@"静静地等，等风来～"];
    
    UILabel *lab_detail = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame) + 3, SCREEN_WIDTH, 16)];
    [self.tab_backGroundView addSubview:lab_detail];
    lab_detail.font = [UIFont systemFontOfSize:14];
    lab_detail.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
    lab_detail.textAlignment = NSTextAlignmentCenter;
    [lab_detail setText:@"还没用户下单，去玩会儿再来吧……"];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_tableView.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"tableViewCell";
    RootTableViewCell *cell = (RootTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[RootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    self.orderEntity = [self.arr_tableView objectAtIndex:indexPath.row];
    if (self.orderEntity.orderType == 1) {
        [cell.lab_orderType setText:@"特需陪诊"];
    }else{
        [cell.lab_orderType setText:@"普通陪诊"];
    }
    [cell.lab_hospital setText:self.orderEntity.hospitalName];
    [cell.lab_orderTime setText:self.orderEntity.scheduleTime];
    
    NSString *creettime = self.orderEntity.createTime;
    NSDateFormatter *formmatter = [[NSDateFormatter alloc] init];
    [formmatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate = [formmatter dateFromString:creettime];
    
    NSString *aaa = [self compareCurrentTime:fromdate];
    [cell.lab_orderCreateTime setText:aaa];
    cell.btn_qiangdan.tag = indexPath.row;
    [cell.btn_qiangdan addTarget:self action:@selector(btn_qiangdanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RootOrderEntity *entity = [self.arr_tableView objectAtIndex:indexPath.row];
    
    RootOrderDetailViewController *vc = [[RootOrderDetailViewController alloc]init];
    vc.orderEntity = entity;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)btn_qiangdanAction:(UIButton *)sender{
    RootOrderEntity *entity = [self.arr_tableView objectAtIndex:sender.tag];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,Qiangdan];
    self.manager = [[AFNManager alloc]init];
    NSDictionary *dic = @{@"orderId":entity.orderId};
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        
        if ([Status isEqualToString:SUCCESS]) {
            [self.view makeToast:@"抢单成功" duration:1.2 position:@"center"];
            [NSTimer scheduledTimerWithTimeInterval:1.5
                                             target:self
                                           selector:@selector(qiangdanComplete)
                                           userInfo:nil
                                            repeats:NO];
            
        }else{
            FailMessage;
        }
    } fail:^(NSError *error) {
        NetError;
    }];
}

-(void)qiangdanComplete{
    [self.tb_order.mj_header beginRefreshing];
}

-(NSString *)compareCurrentTime:(NSDate*) compareDate
//
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
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
