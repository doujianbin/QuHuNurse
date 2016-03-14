//
//  HistoryOrderViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/18.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "HistoryOrderViewController.h"
#import "HistoryListEntity.h"
#import "HistoryTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "HistoryDetailViewController.h"
#import "Toast+UIView.h"

@interface HistoryOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)AFNManager *manager;
@property (nonatomic ,strong)UITableView *tb_history;
@property (nonatomic ,strong)NSMutableArray *arr_history;
@property (nonatomic ,strong)UIView *tab_backGroundView;

@end

@implementation HistoryOrderViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_history = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"历史订单";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"Rectangle 91 + Line + Line Copy"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [btnl addTarget:self action:@selector(NavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    [self onCreate];
    [self loadData];
}

-(void)onCreate{
    self.tb_history = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_history];
    [self.tb_history setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    [self.tb_history setDataSource:self];
    [self.tb_history setDelegate:self];
    [self.tb_history setRowHeight:174.5];
    [self.tb_history setSeparatorColor:[UIColor clearColor]];
    
    self.tab_backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.tb_history.frame.size.width, self.tb_history.frame.size.height)];
    UIImageView *img_nothing = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 115) / 2 ,(self.tab_backGroundView.frame.size.height - 127)/2 - 80, 115, 127)];
    [self.tab_backGroundView addSubview:img_nothing];
    [img_nothing setImage:[UIImage imageNamed:@"nothingView"]];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(img_nothing.frame) + 20 , SCREEN_WIDTH, 20)];
    [self.tab_backGroundView addSubview:lab];
    lab.font = [UIFont boldSystemFontOfSize:16];
    lab.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
    lab.textAlignment = NSTextAlignmentCenter;
    [lab setText:@"您还没有历史订单~"];
    
    UILabel *lab_detail = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame) + 3, SCREEN_WIDTH, 16)];
    [self.tab_backGroundView addSubview:lab_detail];
    lab_detail.font = [UIFont systemFontOfSize:14];
    lab_detail.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
    lab_detail.textAlignment = NSTextAlignmentCenter;
    [lab_detail setText:@"快去抢单吧"];
    
    self.tb_history.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
}

-(void)loadData{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,QueryHistoryList];
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:nil result:^(id responseDic) {
        if ([Status isEqualToString:SUCCESS]) {
            [self.tb_history.mj_header endRefreshing];
            [self.arr_history removeAllObjects];
            NSArray *arr = [responseDic objectForKey:@"data"];
            for (NSDictionary *dic in arr) {
                [self.arr_history addObject:[HistoryListEntity parseHistoryListEntityWithJson:dic]];
            }
            [self.tb_history reloadData];
            if (arr.count == 0) {
                [self.tb_history setBackgroundView:self.tab_backGroundView];
            }else{
                [self.tb_history setBackgroundView:nil];
            }
        }
    } fail:^(NSError *error) {
        [self.tb_history.mj_header endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_history.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"HistoryTableViewCell";
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[HistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    HistoryListEntity *entity = [self.arr_history objectAtIndex:indexPath.row];
    [cell.lab_orderNo setText:[NSString stringWithFormat:@"订单号 :%@",entity.orderNo]];
    if (entity.orderStatus == 4) {
        [cell.lab_orderStatus setText:@"已完成"];
    }
    if (entity.orderStatus == 5) {
        [cell.lab_orderStatus setText:@"已取消"];
    }
    [cell.img_headPic sd_setImageWithURL:[NSURL URLWithString:entity.pictureUrl] placeholderImage:[UIImage imageNamed:@"ic_医生介绍"]];
    [cell.lab_name setText:entity.patientName];
    if (entity.orderType == 0) {
        [cell.lab_orderType setText:@"普通陪诊"];
    }else{
        [cell.lab_orderType setText:@"特需陪诊"];
    }
    [cell.lab_hospitalAddress setText:[NSString stringWithFormat:@"陪诊地址: %@",entity.hospitalName]];
    if (entity.orderStatus == 4) {
        
        NSString *startTime = [entity.startTime substringWithRange:NSMakeRange(0, entity.startTime.length - 3)];
        NSString *endTime = [entity.endTime substringWithRange:NSMakeRange(entity.endTime.length - 8,5)];
        [cell.lab_orderTime setText:[NSString stringWithFormat:@"%@-%@",startTime,endTime]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HistoryListEntity *entity = [self.arr_history objectAtIndex:indexPath.row];
    if (entity.orderStatus == 4) {
        
        HistoryDetailViewController *vc = [[HistoryDetailViewController alloc]init];
        vc.orderId = [NSString stringWithFormat:@"%d",entity.orderId];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.view makeToast:@"已取消订单无法查看订单详情" duration:1.2 position:@"center"];
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
