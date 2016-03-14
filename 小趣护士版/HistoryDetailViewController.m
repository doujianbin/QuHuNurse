//
//  HistoryDetailViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/18.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HistoryDetailViewController ()
@property (nonatomic ,strong)AFNManager *manager;
@property (nonatomic ,strong)NSDictionary *dic;
@property (nonatomic ,strong)UIScrollView *sc;

@end

@implementation HistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"订单详情";
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
    NSString *strUrl = [NSString stringWithFormat:@"%@/quhu/accompany/nurse/queryOrderDetails?id=%@",Development,self.orderId];
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:nil result:^(id responseDic) {
        if ([Status isEqualToString:SUCCESS]) {
            NSLog(@"%@",[responseDic objectForKey:@"data"]);
            self.dic = [responseDic objectForKey:@"data"];
            [self onCreate];
        }
    } fail:^(NSError *error) {
        
    }];
}

-(void)onCreate{
    self.sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.sc];
    [self.sc setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    [self.sc setContentSize:CGSizeMake(SCREEN_WIDTH, 900)];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 56, 14.5)];
    [self.sc addSubview:lab];
    [lab setText:@"订单状态"];
    lab.font = [UIFont systemFontOfSize:14];
    [lab setTextColor:[UIColor colorWithHexString:@"#969696"]];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 30.5, SCREEN_WIDTH, 110)];
    [self.sc addSubview:view];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 17.5, 22.5, 22.5)];
    [view addSubview:img];
    [img setImage:[UIImage imageNamed:@"orderStatus"]];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(67, 20, 85, 18)];
    [view addSubview:lab2];
    [lab2 setText:@"订单已完成"];
    lab2.font = [UIFont systemFontOfSize:17];
    [lab2 setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
    
    UIImageView *img_heng = [[UIImageView alloc]initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 0.5)];
    [view addSubview:img_heng];
    [img_heng setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 74.5, 68, 18)];
    [view addSubview:lab3];
    [lab3 setText:@"订单号: "];
    [lab3 setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    [lab3 setFont:[UIFont systemFontOfSize:17]];
    [lab3 setAlpha:0.8];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(83, 76.5, 250, 18)];
    [view addSubview:lab4];
    [lab4 setText:[NSString stringWithFormat:@"%@",[self.dic objectForKey:@"orderNo"]]];
    [lab4 setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    [lab4 setFont:[UIFont systemFontOfSize:17]];
    
    UIImageView *img_heng2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 109.5, SCREEN_WIDTH, 0.5)];
    [view addSubview:img_heng2];
    [img_heng2 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(15, 150.5, 80, 14.5)];
    [self.sc addSubview:lab5];
    [lab5 setText:@"订单明细"];
    lab5.font = [UIFont systemFontOfSize:14];
    [lab5 setTextColor:[UIColor colorWithHexString:@"#969696"]];
    
    UIView *view2 = [[UIView alloc]init];
    [self.sc addSubview:view2];
    [view2 setFrame:CGRectMake(0, 173, SCREEN_WIDTH, 57 * 5)];
    
    [view2 setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imgheng3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5, SCREEN_WIDTH, 0.5)];
    [view2 addSubview:imgheng3];
    [imgheng3 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UIImageView *imgheng4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5 + 57, SCREEN_WIDTH, 0.5)];
    [view2 addSubview:imgheng4];
    [imgheng4 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UIImageView *imgheng5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5 + 57 * 2, SCREEN_WIDTH, 0.5)];
    [view2 addSubview:imgheng5];
    [imgheng5 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UIImageView *imgheng6 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5 + 57 * 3, SCREEN_WIDTH, 0.5)];
    [view2 addSubview:imgheng6];
    [imgheng6 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UIImageView *imgheng7 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5 + 57 * 4, SCREEN_WIDTH, 0.5)];
    [view2 addSubview:imgheng7];
    [imgheng7 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UIImageView *img_headPic = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 37, 37)];
    [view2 addSubview:img_headPic];
    if ([[[self.dic objectForKey:@"patient"] objectForKey:@"patientPortrait"] isKindOfClass:[NSNull class]]) {
        [img_headPic setImage:[UIImage imageNamed:@"ic_医生介绍"]];
    }else{
         [img_headPic sd_setImageWithURL:[NSURL URLWithString:[[self.dic objectForKey:@"patient"] objectForKey:@"patientPortrait"]] placeholderImage:[UIImage imageNamed:@"ic_医生介绍"]];
    }
    
    UILabel *lab_patientName = [[UILabel alloc]initWithFrame:CGRectMake(62, 20.5, 48, 16.5)];
    [view2 addSubview:lab_patientName];
    [lab_patientName setText:[[self.dic objectForKey:@"patient"] objectForKey:@"patientName"]];
    lab_patientName.font = [UIFont systemFontOfSize:16];
    [lab_patientName setTextColor:[UIColor colorWithHexString:@"#000000"]];
    
    UILabel *lab_patientSex = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab_patientName.frame), 20.5, 16, 16.5)];
    [view2 addSubview:lab_patientSex];
    lab_patientSex.font = [UIFont systemFontOfSize:16];
    [lab_patientSex setTextColor:[UIColor colorWithHexString:@"#000000"]];

    if ([[[self.dic objectForKey:@"patient"] objectForKey:@"patientName"] intValue] == 0) {
        [lab_patientSex setText:@"男"];
    }else{
        [lab_patientSex setText:@"女"];
    }
    
//    UILabel *lab_patientAge = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab_patientSex.frame) + 15, 20.5, 30, 16.5)];
//    [view2 addSubview:lab_patientAge];
//    lab_patientAge.font = [UIFont systemFontOfSize:16];
//    [lab_patientAge setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
//    [lab_patientAge setAlpha:0.7];
//    [lab_patientAge setText:[NSString stringWithFormat:@"%@岁",[[self.dic objectForKey:@"patient"] objectForKey:@"patientAge"]]];
    
    UILabel *lab_order = [[UILabel alloc]initWithFrame:CGRectMake(15, 77.5, 64, 16.5)];
    [view2 addSubview:lab_order];
    [lab_order setText:@"基础陪诊"];
    lab_order.font = [UIFont systemFontOfSize:16];
    [lab_order setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    
    UILabel *lab_order2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 75, 77.5, 60, 16.5)];
    [view2 addSubview:lab_order2];
    [lab_order2 setText:[NSString stringWithFormat:@"¥%@",[self.dic objectForKey:@"setAmount"]]];
    lab_order2.font = [UIFont systemFontOfSize:16];
    [lab_order2 setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    [lab_order2 setTextAlignment:NSTextAlignmentRight];
    
    UILabel *lab_chaoshi = [[UILabel alloc]initWithFrame:CGRectMake(15, 77.5 + 57, 64, 16.5)];
    [view2 addSubview:lab_chaoshi];
    [lab_chaoshi setText:@"超时费用"];
    lab_chaoshi.font = [UIFont systemFontOfSize:16];
    [lab_chaoshi setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    
    UILabel *lab_chaoshi2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 75, 77.5 + 57, 60, 16.5)];
    [view2 addSubview:lab_chaoshi2];
    lab_chaoshi2.font = [UIFont systemFontOfSize:16];
    [lab_chaoshi2 setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    [lab_chaoshi2 setTextAlignment:NSTextAlignmentRight];
    if ([[self.dic objectForKey:@"overtimeAmount"] isKindOfClass:[NSNull class]]) {
       [lab_chaoshi2 setText:@"¥0"];
    }else{
        [lab_chaoshi2 setText:[NSString stringWithFormat:@"¥%@",[self.dic objectForKey:@"overtimeAmount"]]];
    }
    
    UILabel *lab_youhuijuan = [[UILabel alloc]initWithFrame:CGRectMake(15, 77.5 + 57 * 2, 64, 16.5)];
    [view2 addSubview:lab_youhuijuan];
    [lab_youhuijuan setText:@"优惠券"];
    lab_youhuijuan.font = [UIFont systemFontOfSize:16];
    [lab_youhuijuan setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    
    UILabel *lab_youhuijuan2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 175, 77.5 + 57 * 2, 160, 16.5)];
    [view2 addSubview:lab_youhuijuan2];
    lab_youhuijuan2.font = [UIFont systemFontOfSize:16];
    [lab_youhuijuan2 setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
    [lab_youhuijuan2 setTextAlignment:NSTextAlignmentRight];
    
    if ([[self.dic objectForKey:@"couponType"] isKindOfClass:[NSNull class]]) {
        [lab_youhuijuan2 setText:@"未使用优惠券"];
    }else{
        if ([[self.dic objectForKey:@"couponType"] intValue] == 1) {
            //1为折扣卷
            [lab_youhuijuan2 setText:[NSString stringWithFormat:@"%@折",[self.dic objectForKey:@"couponValue"]]];
        }else{
            // 抵价卷
            [lab_youhuijuan2 setText:[NSString stringWithFormat:@"-¥%@",[self.dic objectForKey:@"couponValue"]]];
        }
    }
    
    UILabel *lab_totalAmount = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 175, 77.5 + 57 * 3, 160, 16.5)];
    [view2 addSubview:lab_totalAmount];
    lab_totalAmount.font = [UIFont boldSystemFontOfSize:17];
    [lab_totalAmount setTextColor:[UIColor colorWithHexString:@"#FA6262"]];
    [lab_totalAmount setTextAlignment:NSTextAlignmentRight];
    [lab_totalAmount setText:[NSString stringWithFormat:@"总计:  ¥%@",[self.dic objectForKey:@"totalAmount"]]];
    
    UILabel *lab_qita = [[UILabel alloc]initWithFrame:CGRectMake(15, 466.5, 80, 14.5)];
    [self.sc addSubview:lab_qita];
    [lab_qita setText:@"其他信息"];
    lab_qita.font = [UIFont boldSystemFontOfSize:14];
    [lab_qita setTextColor:[UIColor colorWithHexString:@"#969696"]];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 489, SCREEN_WIDTH, 57 * 5)];
    [self.sc addSubview:view3];
    [view3 setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imgheng11 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5, SCREEN_WIDTH, 0.5)];
    [view3 addSubview:imgheng11];
    [imgheng11 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UIImageView *imgheng12 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5 + 57, SCREEN_WIDTH, 0.5)];
    [view3 addSubview:imgheng12];
    [imgheng12 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UIImageView *imgheng13 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5 + 57 * 2, SCREEN_WIDTH, 0.5)];
    [view3 addSubview:imgheng13];
    [imgheng13 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UIImageView *imgheng14 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5 + 57 * 3, SCREEN_WIDTH, 0.5)];
    [view3 addSubview:imgheng14];
    [imgheng14 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UIImageView *imgheng15 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 56.5 + 57 * 4, SCREEN_WIDTH, 0.5)];
    [view3 addSubview:imgheng15];
    [imgheng15 setBackgroundColor:[UIColor colorWithHexString:@"#E6E6E8"]];
    
    UILabel *lab_hospitalName = [[UILabel alloc]initWithFrame:CGRectMake(15, 19.5, 85, 18)];
    [view3 addSubview:lab_hospitalName];
    [lab_hospitalName setText:@"陪诊医院："];
    lab_hospitalName.font = [UIFont systemFontOfSize:17];
    [lab_hospitalName setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    [lab_hospitalName setAlpha:0.6];
    
    UILabel *lab_hospitalName1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 19.5, SCREEN_WIDTH - 110, 18)];
    [view3 addSubview:lab_hospitalName1];
    [lab_hospitalName1 setText:[[self.dic objectForKey:@"hospital"] objectForKey:@"hospitalName"]];
    lab_hospitalName1.font = [UIFont systemFontOfSize:17];
    [lab_hospitalName1 setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    
    UILabel *lab_hospitalAddress = [[UILabel alloc]initWithFrame:CGRectMake(15, 19.5 + 57, 85, 18)];
    [view3 addSubview:lab_hospitalAddress];
    [lab_hospitalAddress setText:@"医院地址："];
    lab_hospitalAddress.font = [UIFont systemFontOfSize:17];
    [lab_hospitalAddress setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    [lab_hospitalAddress setAlpha:0.6];
    
    UILabel *lab_hospitalAddress2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 19.5 + 57, SCREEN_WIDTH - 110, 18)];
    [view3 addSubview:lab_hospitalAddress2];
    [lab_hospitalAddress2 setText:[[self.dic objectForKey:@"hospital"] objectForKey:@"address"]];
    lab_hospitalAddress2.font = [UIFont systemFontOfSize:17];
    [lab_hospitalAddress2 setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    
    UILabel *lab_createTime = [[UILabel alloc]initWithFrame:CGRectMake(15, 19.5 + 57 * 2, 85, 18)];
    [view3 addSubview:lab_createTime];
    [lab_createTime setText:@"下单时间："];
    lab_createTime.font = [UIFont systemFontOfSize:17];
    [lab_createTime setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    [lab_createTime setAlpha:0.6];
    
    UILabel *lab_createTime2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 19.5 + 57 * 2, SCREEN_WIDTH - 110, 18)];
    [view3 addSubview:lab_createTime2];
    [lab_createTime2 setText:[self.dic objectForKey:@"createTime"]];
    lab_createTime2.font = [UIFont systemFontOfSize:17];
    [lab_createTime2 setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    
    UILabel *lab_startTime = [[UILabel alloc]initWithFrame:CGRectMake(15, 19.5 + 57 * 3, 119, 18)];
    [view3 addSubview:lab_startTime];
    [lab_startTime setText:@"开始陪诊时间："];
    lab_startTime.font = [UIFont systemFontOfSize:17];
    [lab_startTime setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    [lab_startTime setAlpha:0.6];
    
    UILabel *lab_startTime2 = [[UILabel alloc]initWithFrame:CGRectMake(133.5, 19.5 + 57 * 3, SCREEN_WIDTH - 134.5, 18)];
    [view3 addSubview:lab_startTime2];
    [lab_startTime2 setText:[self.dic objectForKey:@"startTime"]];
    lab_startTime2.font = [UIFont systemFontOfSize:17];
    [lab_startTime2 setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    
    UILabel *lab_endTime = [[UILabel alloc]initWithFrame:CGRectMake(15, 19.5 + 57 * 4, 119, 18)];
    [view3 addSubview:lab_endTime];
    [lab_endTime setText:@"结束陪诊时间："];
    lab_endTime.font = [UIFont systemFontOfSize:17];
    [lab_endTime setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
    [lab_endTime setAlpha:0.6];
    
    UILabel *lab_endTime2 = [[UILabel alloc]initWithFrame:CGRectMake(133.5, 19.5 + 57 * 4, SCREEN_WIDTH - 134.5, 18)];
    [view3 addSubview:lab_endTime2];
    [lab_endTime2 setText:[self.dic objectForKey:@"endTime"]];
    lab_endTime2.font = [UIFont systemFontOfSize:17];
    [lab_endTime2 setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
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
