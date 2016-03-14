//
//  IncomeStatementViewController.m
//  小趣医生端
//
//  Created by 窦建斌 on 16/2/3.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "IncomeStatementViewController.h"
#import "IncomeStatementTableViewCell.h"
#import "IncomeStatementEntity.h"

@interface IncomeStatementViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)AFNManager * manager;
@property (nonatomic ,strong)UITableView *tb_incomeStatement;
@property (nonatomic ,strong)NSMutableArray *arr_incomeStatement;
@property (nonatomic ,strong)UIView *tab_backGroundView;

@end

@implementation IncomeStatementViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_incomeStatement = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"收益明细";
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

-(void)loadData{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,GetAppUserIncomeDetail];
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:nil result:^(id responseDic) {
        NSLog(@"收益明细:%@",responseDic);
        if ([Status isEqualToString:SUCCESS]) {
            NSArray *arr = [responseDic objectForKey:@"data"];
            for (NSDictionary *dic in arr) {
                [self.arr_incomeStatement addObject:[IncomeStatementEntity parseIncomeStatementEntityWithJson:dic]];
            }
            [self.tb_incomeStatement reloadData];
            if (arr.count == 0) {
                [self.tb_incomeStatement setBackgroundView:self.tab_backGroundView];
            }else{
                [self.tb_incomeStatement setBackgroundView:nil];
            }
        }else{
            FailMessage;
        }
    } fail:^(NSError *error) {
        NetError;
    }];
}

-(void)onCreate{
    self.tb_incomeStatement = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.tb_incomeStatement];
    self.tb_incomeStatement.delegate = self;
    self.tb_incomeStatement.dataSource = self;
    [self.tb_incomeStatement setRowHeight:57];
    [self.tb_incomeStatement setSeparatorColor:[UIColor clearColor]];
    [self.tb_incomeStatement setBackgroundColor:[UIColor whiteColor]];
    
    
    self.tab_backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.tb_incomeStatement.frame.size.width, self.tb_incomeStatement.frame.size.height)];
    UIImageView *img_nothing = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 115) / 2 ,(self.tab_backGroundView.frame.size.height - 127)/2 - 80, 115, 127)];
    [self.tab_backGroundView addSubview:img_nothing];
    [img_nothing setImage:[UIImage imageNamed:@"nothingView"]];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(img_nothing.frame) + 20 , SCREEN_WIDTH, 20)];
    [self.tab_backGroundView addSubview:lab];
    lab.font = [UIFont boldSystemFontOfSize:16];
    lab.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
    lab.textAlignment = NSTextAlignmentCenter;
    [lab setText:@"您还没有收益哦～"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_incomeStatement.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"IncomeStatementTableViewCell";
    
    IncomeStatementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[IncomeStatementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    IncomeStatementEntity *entity = [self.arr_incomeStatement objectAtIndex:indexPath.row];
//    if (entity.cardId == nil) {
//        [cell.lab_title setText:@"陪诊收益"];
//        [cell.lab_price setText:[NSString stringWithFormat:@"+%@",entity.amount]];
//    }else{
//        [cell.lab_title setText:@"提现"];
//        [cell.lab_price setText:[NSString stringWithFormat:@"-%@",entity.amount]];
//    }
//    NSString *applyTime = entity.applyTime;
//    NSString *hospital = entity.hospitalName;
//    if (hospital != nil) {
//        [cell.lab_detail setText:[NSString stringWithFormat:@"%@  %@",applyTime,hospital]];
//    }else{
//        [cell.lab_detail setText:applyTime];
//    }
    
    [cell.lab_title setText:entity.title];
    if (entity.content == nil) {
        [cell.lab_detail setText:entity.accountTime];
    }else{
        [cell.lab_detail setText:[NSString stringWithFormat:@"%@  %@",entity.accountTime,entity.content]];
    }
    [cell.lab_price setText:entity.amount];
    
    return cell;
    
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
