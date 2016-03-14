//
//  TiXianViewController.m
//  小趣医生端
//
//  Created by 窦建斌 on 15/12/24.
//  Copyright © 2015年 窦建斌. All rights reserved.
//

#import "TiXianViewController.h"
#import "AddBandTableViewCell.h"
#import "MyBankCardViewController.h"
#import "BankEntity.h"
#import "UITextField+ResignKeyboard.h"

@interface TiXianViewController ()<UITableViewDataSource,UITableViewDelegate,MyBankCardViewControllerDegelate>

@property (nonatomic ,retain)UITableView *tableView;
@property (nonatomic ,retain)NSMutableArray *arr_tab;
@property (nonatomic ,retain)UIButton *btn_tixian;
@property (nonatomic ,strong)BankEntity *bankEntity;
@property (nonatomic ,strong)UILabel *lab_bankName;
@property (nonatomic ,strong)NSString *str_bankName;
@property (nonatomic ,strong)UITextField *tef_jine;
@property (nonatomic ,strong)AFNManager *manager;
@end

@implementation TiXianViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_tab = [[NSMutableArray alloc]initWithObjects:@"银行卡:",@"金额:", nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"提现";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"Rectangle 91 + Line + Line Copy"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [btnl addTarget:self action:@selector(NavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 75*2 + 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 75;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[AddBandTableViewCell class] forCellReuseIdentifier:@"TixianTableView"];
    
    self.btn_tixian = [[UIButton alloc]initWithFrame:CGRectMake(12, 75 * 2 + 99, SCREEN_WIDTH - 24, 57)];
    [self.view addSubview:self.btn_tixian];
    [self.btn_tixian setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    [self.btn_tixian setTitle:@"提现" forState:UIControlStateNormal];
    self.btn_tixian.layer.cornerRadius = 4.0f;
    self.btn_tixian.layer.masksToBounds = YES;
    [self.btn_tixian addTarget:self action:@selector(btn_tixianAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab_wenzi = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.btn_tixian.frame) + 25, SCREEN_WIDTH - 40, 40)];
    [self.view addSubview:lab_wenzi];
    [lab_wenzi setText:@"注：提现申请后，约3-7个工作日到账，请及时查收"];
    lab_wenzi.font = [UIFont boldSystemFontOfSize:14];
    lab_wenzi.numberOfLines = 0;
    lab_wenzi.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    lab_wenzi.textAlignment = NSTextAlignmentCenter;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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
    AddBandTableViewCell *cell = [[AddBandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TixianTableView"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.lab_left setText:[self.arr_tab objectAtIndex:indexPath.row]];
    if (indexPath.row == 0) {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        self.lab_bankName = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 219, 25, 190, 25)];
        [cell addSubview:self.lab_bankName];
        [self.lab_bankName setFont:[UIFont systemFontOfSize:18]];
        self.lab_bankName.textAlignment = NSTextAlignmentRight;
        if (self.str_bankName.length > 0) {
            [self.lab_bankName setText:self.str_bankName];
            [self.lab_bankName setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        }else{
            [self.lab_bankName setText:@"选择银行卡"];
            [self.lab_bankName setTextColor:[UIColor colorWithHexString:@"#9B9B9B" alpha:0.5]];
        }
    }
    if (indexPath.row == 1) {
        self.tef_jine = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 219, 25, 190, 25)];
        [cell addSubview:self.tef_jine];
        [self.tef_jine setFont:[UIFont systemFontOfSize:18]];
        [self.tef_jine setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
         self.tef_jine.textAlignment = NSTextAlignmentRight;
        self.tef_jine.keyboardType = UIKeyboardTypeDecimalPad;
        [self.tef_jine setNormalInputAccessory];
//        [self.tef_jine setPlaceholder:@"输入金额"];
        self.tef_jine.enabled = NO;
        self.tef_jine.text = self.account;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MyBankCardViewController *bankView = [[MyBankCardViewController alloc]init];
        bankView.FromType = 2;
        bankView.delegate = self;
        [self.navigationController pushViewController:bankView animated:YES];
    }
}

- (void)didSelectedBankWithEntity:(BankEntity *)bankEntity{
    self.bankEntity = bankEntity;
    NSString *bankNum = [bankEntity.bankCode substringFromIndex:bankEntity.bankCode.length - 4];
    self.str_bankName = [NSString stringWithFormat:@"%@  (%@)",bankEntity.bankName,bankNum];
    [self.tableView reloadData];
}

-(void)btn_tixianAction{
    
    if (self.bankEntity.BankId == nil) {
        [self.view makeToast:@"请选择银行卡" duration:1.0 position:@"center"];
    }else if (self.tef_jine.text.length == 0){
        [self.view makeToast:@"请输入提现金额" duration:1.0 position:@"center"];
    }else{
        
        NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,DoctorTiXian];
        NSDictionary *dic = @{@"cardId":self.bankEntity.BankId,@"amount_out":self.tef_jine.text};
        self.manager = [[AFNManager alloc]init];
        [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
            if ([Status isEqualToString:SUCCESS]) {
                [self.view makeToast:@"申请提现成功" duration:1.0 position:@"center"];
                [NSTimer scheduledTimerWithTimeInterval:1.5
                                                 target:self
                                               selector:@selector(NavLeftAction)
                                               userInfo:nil
                                                repeats:NO];
            }else{
                FailMessage;
            }
        } fail:^(NSError *error) {
            NetError;
        }];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)NavLeftAction{
    [self.navigationController popViewControllerAnimated:YES];
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
