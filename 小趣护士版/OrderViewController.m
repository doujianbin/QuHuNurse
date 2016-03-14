//
//  OrderViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "OrderViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "OrderListEntity.h"
#import "OrderListTableViewCell.h"
#import "BeginServiceViewController.h"
#import "EndServiceViewController.h"
#import "PriceDetailViewController.h"
#import "HistoryOrderViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic ,strong)AFNManager *manager;
@property (nonatomic ,strong)UITableView *tb_orderList;
@property (nonatomic ,strong)NSMutableArray *arr_tbList;
@property (nonatomic ,strong)UIView *tab_backGroundView;
@property (nonatomic ,strong)OrderListEntity *orderListEntity;
@property (nonatomic ,strong)NSString *phoneNum;
@property (nonatomic ,strong)UIButton *btn_left;

@end

@implementation OrderViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_tbList = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"订单";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnR = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 35, 21.5, 20, 20)];
    [btnR setBackgroundImage:[UIImage imageNamed:@"ic_lishi"] forState:UIControlStateNormal];
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc]initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = btnRight;
    [btnR addTarget:self action:@selector(btnLeftaction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    [self onCreate];
//    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tb_orderList.mj_header beginRefreshing];
}

-(void)loadData{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,QueryUnfinishedList];
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:nil result:^(id responseDic) {
        NSLog(@"%@",responseDic);
        [self.tb_orderList.mj_header endRefreshing];
        [self.arr_tbList removeAllObjects];
        if ([Status isEqualToString:SUCCESS]) {
            NSArray *arr = [responseDic objectForKey:@"data"];
            for (NSDictionary *dic in arr) {
                
                [self.arr_tbList addObject:[OrderListEntity parseOrderListEntityWithJson:dic]];
            }
            [self.tb_orderList reloadData];
            if (arr.count == 0) {
                [self.tb_orderList setBackgroundView:self.tab_backGroundView];
            }else{
                [self.tb_orderList setBackgroundView:nil];
            }
        }
    } fail:^(NSError *error) {
        [self.tb_orderList.mj_header endRefreshing];
    }];
}

-(void)onCreate{
    self.tb_orderList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_orderList];
    [self.tb_orderList setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    [self.tb_orderList setDelegate:self];
    [self.tb_orderList setDataSource:self];
    [self.tb_orderList setRowHeight:242.5];
    [self.tb_orderList setSeparatorColor:[UIColor clearColor]];
    self.tb_orderList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    self.tab_backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.tb_orderList.frame.size.width, self.tb_orderList.frame.size.height)];
    UIImageView *img_nothing = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 115) / 2 ,(self.tab_backGroundView.frame.size.height - 127)/2 - 80, 115, 127)];
    [self.tab_backGroundView addSubview:img_nothing];
    [img_nothing setImage:[UIImage imageNamed:@"nothingView"]];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(img_nothing.frame) + 20 , SCREEN_WIDTH, 20)];
    [self.tab_backGroundView addSubview:lab];
    lab.font = [UIFont boldSystemFontOfSize:16];
    lab.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
    lab.textAlignment = NSTextAlignmentCenter;
    [lab setText:@"您还没有订单哦～"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_tbList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"tableViewCell";
    OrderListTableViewCell *cell = (OrderListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[OrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderListEntity *entity = [self.arr_tbList objectAtIndex:indexPath.row];
    if (entity.assignFlag == 0) {
        [cell.btn_xiangqing setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
        [cell.btn_xiangqing setTitle:@"查看抢单详情" forState:UIControlStateNormal];
        [cell.img_paidan setImage:nil];
        
    }if (entity.assignFlag == 1){
        // 派单的
        [cell.btn_xiangqing setBackgroundColor:[UIColor colorWithHexString:@"#4A90E2"]];
        [cell.btn_xiangqing setTitle:@"查看派单详情" forState:UIControlStateNormal];
        [cell.img_paidan setImage:[UIImage imageNamed:@"Rectangle 17 + 派单"]];
    }
    if (entity.orderType == 0) {
        [cell.lab_orderType setText:@"普通陪诊"];
        [cell.lab_orderType setTextColor:[UIColor colorWithHexString:@"#4A90E2"]];
        if (entity.orderStatus == 1) {
            [cell.lab_orderCreateTime setText:@"已接单"];
        }
        if (entity.orderStatus == 2) {
            [cell.lab_orderCreateTime setText:@"陪诊中"];
        }
        if (entity.orderStatus == 3) {
            [cell.lab_orderCreateTime setText:@"已完成-未支付"];
        }
        
    }else{
        [cell.lab_orderType setText:@"特需陪诊"];
        [cell.lab_orderType setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
        if (entity.orderStatus == 1) {
            [cell.lab_orderCreateTime setText:@"已接单"];
        }
        if (entity.orderStatus == 2) {
            [cell.lab_orderCreateTime setText:@"陪诊中"];
        }
        if (entity.orderStatus == 3) {
            [cell.lab_orderCreateTime setText:@"已结束"];
        }
    }
//    NSString *creettime = self.orderListEntity.createTimeStr;
//    NSDateFormatter *formmatter = [[NSDateFormatter alloc] init];
//    [formmatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *fromdate = [formmatter dateFromString:creettime];
//    NSString *aaa = [self compareCurrentTime:fromdate];
//    [cell.lab_orderCreateTime setText:aaa];
    
    
    [cell.img_headPic sd_setImageWithURL:[NSURL URLWithString:entity.pictureUrl] placeholderImage:[UIImage imageNamed:@"ic_医生介绍"]];
    [cell.lab_name setText:entity.patientName];
    if (entity.sex == 0) {
        [cell.lab_genderAndAge setText:@"男"];
    }else{
        [cell.lab_genderAndAge setText:@"女"];
    }
    [cell.lab_hospitalName setText:entity.hospitalName];
    [cell.lab_orderTime setText:entity.scheduleTime];
    
    [cell.btn_phone addTarget:self action:@selector(btn_phoneAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_phone.tag = indexPath.row;
    [cell.btn_xiangqing addTarget:self action:@selector(btn_xiangqingAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_xiangqing.tag = indexPath.row;
    
    return cell;
}

-(NSString *)compareCurrentTime:(NSDate*) compareDate
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
    
    return result;
}

-(void)btn_xiangqingAction:(UIButton *)sender{
    
    OrderListEntity *entity = [self.arr_tbList objectAtIndex:sender.tag];
    
    if (entity.orderStatus == 1) {
        //护士已经接单   跳转到开始陪诊界面
        BeginServiceViewController *vc = [[BeginServiceViewController alloc]init];
        vc.orderId = [NSString stringWithFormat:@"%d",entity.orderId];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (entity.orderStatus == 2) {
        //护士已经开始陪诊   跳转到结束陪诊界面
        EndServiceViewController *vc = [[EndServiceViewController alloc]init];
        vc.orderId = [NSString stringWithFormat:@"%d",entity.orderId];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (entity.orderType == 0 && entity.orderStatus == 3) {
        // 普通陪诊 & 护士已经结束陪诊   跳转到收费详情界面
        PriceDetailViewController *vc = [[PriceDetailViewController alloc]init];
        vc.orderId = [NSString stringWithFormat:@"%d",entity.orderId];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)btn_phoneAction:(UIButton *)sender{
    OrderListEntity *entity = [self.arr_tbList objectAtIndex:sender.tag];
    self.phoneNum = entity.patientPhoneNumber;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定拨打" message:entity.patientPhoneNumber delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *str1 = @"tel://";
        NSString *str2 = self.phoneNum;
        NSString *stt = [NSString stringWithFormat:@"%@%@",str1,str2];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stt]];
    }
}

-(void)btnLeftaction{
    HistoryOrderViewController *vc = [[HistoryOrderViewController alloc]init];
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
