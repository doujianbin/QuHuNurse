//
//  ReviseViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/26.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "ReviseViewController.h"
#import "AddBandTableViewCell.h"

@interface ReviseViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>{
    NSMutableArray *bankArr;
}

@property (nonatomic ,retain)UITableView *tab_addBank;
@property (nonatomic ,retain)NSMutableArray *arr_tabV;
@property (nonatomic ,retain)NSString *strName;
@property (nonatomic ,retain)NSString *strCardNum;
@property (nonatomic ,retain)UIButton *btn_sure;
@property (nonatomic ,strong)AFNManager *manager;
@property (nonatomic ,strong)NSString *bankCode;
@property (nonatomic ,strong)NSString *bankName;
@property (nonatomic ,strong)UITextField *tef_name;
@property (nonatomic ,strong)UITextField *tef_bankCode;
@property (nonatomic ,strong)UITextField *tef_bankZhiHang;
@property (nonatomic ,strong)UILabel *lab_bank;

@end

@implementation ReviseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_tabV = [[NSMutableArray alloc]initWithObjects:@"持卡人:",@"卡号:",@"发卡行",@"支行", nil];
        bankArr = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"修改银行卡";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"Rectangle 91 + Line + Line Copy"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [btnl addTarget:self action:@selector(NavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tab_addBank = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 75*4 + 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tab_addBank];
    [self.tab_addBank setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.tab_addBank.delegate = self;
    self.tab_addBank.dataSource = self;
    self.tab_addBank.rowHeight = 75;
    self.tab_addBank.scrollEnabled = NO;
    [self.tab_addBank registerClass:[AddBandTableViewCell class] forCellReuseIdentifier:@"AddBankTableView"];
    
    self.btn_sure = [[UIButton alloc]initWithFrame:CGRectMake(12, 75 * 4 + 89, SCREEN_WIDTH - 24, 57)];
    [self.view addSubview:self.btn_sure];
    [self.btn_sure setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    [self.btn_sure setTitle:@"确定" forState:UIControlStateNormal];
    self.btn_sure.titleLabel.font = [UIFont systemFontOfSize:18];
    self.btn_sure.layer.cornerRadius = 4.0f;
    self.btn_sure.layer.masksToBounds = YES;
    [self.btn_sure addTarget:self action:@selector(btn_sureAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.bankCode = self.bankEntity.bankCode;
    self.bankName = self.bankEntity.bankName;
    
    [self selectAllBank];

}

-(void)selectAllBank{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,QueryBankList];
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:nil result:^(id responseDic) {
        NSLog(@"银行卡列表:%@",responseDic);
        if ([Status isEqualToString:SUCCESS]) {
            [bankArr addObjectsFromArray:[responseDic objectForKey:@"data"]];
        }
    } fail:^(NSError *error) {
        NetError;
    }];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
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
    AddBandTableViewCell *cell = [[AddBandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddBankTableView"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.lab_left setText:[self.arr_tabV objectAtIndex:indexPath.row]];
    cell.tef_right.delegate = self;
    if (indexPath.row == 0) {
        self.tef_name = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 219, 25, 190, 25)];
        [cell addSubview:self.tef_name];
        self.tef_name.delegate = self;
        [self.tef_name setFont:[UIFont systemFontOfSize:18]];
        [self.tef_name setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        self.tef_name.textAlignment = NSTextAlignmentRight;
        self.tef_name.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.tef_name.text = self.bankEntity.ownerName;
    }
    if (indexPath.row == 1) {
        self.tef_bankCode = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 239, 25, 210, 25)];
        [cell addSubview:self.tef_bankCode];
        [self.tef_bankCode setDelegate:self];
        [self.tef_bankCode setFont:[UIFont systemFontOfSize:18]];
        [self.tef_bankCode setTextColor:[UIColor colorWithHexString:@"#000000"]];
        self.tef_bankCode.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.tef_bankCode.textAlignment = NSTextAlignmentRight;
        self.tef_bankCode.text = self.bankEntity.cardNo;
    }
    if (indexPath.row == 2) {
        self.lab_bank = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 219, 25, 190, 25)];
        [cell addSubview:self.lab_bank];
        [self.lab_bank setFont:[UIFont systemFontOfSize:18]];
        [self.lab_bank setTextColor:[UIColor colorWithHexString:@"#000000"]];
        self.lab_bank.textAlignment = NSTextAlignmentRight;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//        if (self.bankName.length > 0) {
//            [self.lab_bank setText:self.bankName];
//            [self.lab_bank setTextColor:[UIColor colorWithHexString:@"#000000"]];
//        }else{
//            
//            [self.lab_bank setText:@"选择所属银行"];
//            [self.lab_bank setTextColor:[UIColor colorWithHexString:@"#9B9B9B" alpha:0.5]];
//        }
        self.lab_bank.text = self.bankEntity.bankName;
    }
    if (indexPath.row == 3) {
        self.tef_bankZhiHang = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 219, 25, 190, 25)];
        [cell addSubview:self.tef_bankZhiHang];
        [self.tef_bankZhiHang setDelegate:self];
        [self.tef_bankZhiHang setFont:[UIFont systemFontOfSize:18]];
        [self.tef_bankZhiHang setTextColor:[UIColor colorWithHexString:@"#000000"]];
        self.tef_bankZhiHang.textAlignment = NSTextAlignmentRight;
        self.tef_bankZhiHang.clearButtonMode = UITextFieldViewModeWhileEditing;
//        [self.tef_bankZhiHang setPlaceholder:@"输入发卡行支行"];
        self.tef_bankZhiHang.text = self.bankEntity.branchBankInfo;
    }
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"选择银行卡" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        for (NSDictionary *dic in bankArr) {
            NSString *title = [dic objectForKey:@"bankName"];
            [as addButtonWithTitle:title];
        }
        [as showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex > 0) {
        self.bankCode = [[bankArr objectAtIndex:buttonIndex - 1] objectForKey:@"id"];
        self.bankName = [[bankArr objectAtIndex:buttonIndex - 1] objectForKey:@"bankName"];
        //        [self.tab_addBank reloadData];
        [self.lab_bank setText:self.bankName];
        [self.lab_bank setTextColor:[UIColor colorWithHexString:@"#000000"]];
    }
}

-(void)btn_sureAction{
    
    if (self.tef_name.text.length == 0) {
        [self.view makeToast:@"请填写持卡人姓名" duration:1.0 position:@"center"];
        return;
    }
    if (self.tef_bankCode.text.length == 0) {
        [self.view makeToast:@"请填写卡号" duration:1.0 position:@"center"];
        return;
    }
    if (self.bankName.length == 0) {
        [self.view makeToast:@"请选择发卡行" duration:1.0 position:@"center"];
        return;
    }
    if (self.tef_bankZhiHang.text.length == 0) {
        [self.view makeToast:@"请输入发卡行支行" duration:1.0 position:@"center"];
    }
    else{
        
        NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,UpdateBankcardById];
        NSDictionary *dic = @{@"id":self.bankEntity.BankId,@"cardNo":self.tef_bankCode.text,@"ownerName":self.tef_name.text,@"bankName":self.bankName,@"bankCode":self.bankCode,@"branchBankInfo":self.tef_bankZhiHang.text};
        self.manager = [[AFNManager alloc] init];
        [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
            NSLog(@"添加银行卡:%@",responseDic);
            if ([Status isEqualToString:SUCCESS]) {
                [self.view makeToast:@"修改银行卡成功" duration:1.0 position:@"center"];
                [NSTimer scheduledTimerWithTimeInterval:1.5
                                                 target:self
                                               selector:@selector(NavLeftAction)
                                               userInfo:nil
                                                repeats:NO];
            }else{
                [self.view makeToast:Message duration:1.0 position:@"center"];
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
