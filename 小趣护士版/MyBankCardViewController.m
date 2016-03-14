//
//  MyBankCardViewController.m
//  小趣医生端
//
//  Created by 窦建斌 on 15/12/24.
//  Copyright © 2015年 窦建斌. All rights reserved.
//

#import "MyBankCardViewController.h"
#import "BankTableViewCell.h"
#import "AddBankViewController.h"
#import "ReviseViewController.h"

@interface MyBankCardViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (nonatomic ,retain)UITableView *tableView_card;
@property (nonatomic ,retain)NSMutableArray *arr_tabCard;
@property (nonatomic ,strong)AFNManager *manager;
@property (nonatomic ,strong)UIView *tab_backGroundView;
@property (nonatomic ,assign)int index;
@property (nonatomic ,strong)NSString *bankId;

@end

@implementation MyBankCardViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_tabCard = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"我的银行卡";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"Rectangle 91 + Line + Line Copy"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [btnl addTarget:self action:@selector(NavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btnR = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 49, 10, 34, 24)];
    [btnR setTitle:@"添加" forState:UIControlStateNormal];
    [btnR setTitleColor:[UIColor colorWithHexString:@"#FA6262"] forState:UIControlStateNormal];
    btnR.titleLabel.font = [UIFont systemFontOfSize:17];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc]initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = btnright;
    [btnR addTarget:self action:@selector(btnRAdd) forControlEvents:UIControlEventTouchUpInside];
    
    [self onCreate];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
    [self loadData];
}

-(void)onCreate{
    self.tableView_card = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView_card];
    self.tableView_card.delegate = self;
    self.tableView_card.dataSource = self;
    self.tableView_card.rowHeight = 132.5;
    self.tableView_card.scrollEnabled = NO;
    [self.tableView_card registerClass:[BankTableViewCell class] forCellReuseIdentifier:@"bankTableView"];
    [self.tableView_card setSeparatorColor:[UIColor clearColor]];
    
    self.tab_backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.tableView_card.frame.size.width, self.tableView_card.frame.size.height)];
    UIImageView *img_nothing = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 115) / 2 ,(self.tab_backGroundView.frame.size.height - 127)/2 - 80, 115, 127)];
    [self.tab_backGroundView addSubview:img_nothing];
    [img_nothing setImage:[UIImage imageNamed:@"nothingView"]];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(img_nothing.frame) + 20 , SCREEN_WIDTH, 20)];
    [self.tab_backGroundView addSubview:lab];
    lab.font = [UIFont boldSystemFontOfSize:16];
    lab.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
    lab.textAlignment = NSTextAlignmentCenter;
    [lab setText:@"您还没有添加银行卡,快去添加吧~"];
}

-(void)loadData{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,GetBankcardList];
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:nil result:^(id responseDic) {
        NSLog(@"%@",responseDic);
        if ([Status isEqualToString:SUCCESS]) {
            [self.arr_tabCard removeAllObjects];
            if ([[responseDic objectForKey:@"data"] count] > 0) {
                
                for (NSDictionary *dic in [responseDic objectForKey:@"data"]) {
                    [self.arr_tabCard addObject:[BankEntity parseBankListEntityWithJson:dic]];
                }
                self.tableView_card.backgroundView = nil;
                [self.tableView_card reloadData];
            }else{
                [self.tableView_card setBackgroundView:self.tab_backGroundView];
            }
        }
    } fail:^(NSError *error) {
        
    }];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_tabCard.count;
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
    BankTableViewCell *cell = [[BankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bankTableView"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BankEntity *bankEntity = [self.arr_tabCard objectAtIndex:indexPath.row];
    [cell.lab_bankName setText:bankEntity.bankName];
    [cell.lab_cardNum setText:bankEntity.cardNo];
//    [cell.lab_cardNum setText:@"* * * * * * * * * * * 1 2 3 4"];
    [cell.btn_delete addTarget:self action:@selector(btnDelege:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_delete setTag:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.FromType == 2) {
        // 回到提现界面  把当前cell的 BankEntity传回去
        BankEntity *bankEntity = [self.arr_tabCard objectAtIndex:indexPath.row];
        [self.delegate didSelectedBankWithEntity:bankEntity];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        ReviseViewController *vc = [[ReviseViewController alloc]init];
        vc.bankEntity = [self.arr_tabCard objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)btnDelege:(UIButton *)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"删除后将不会出现在您的消息记录中" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
    actionSheet.delegate = self;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    BankEntity *entity = [self.arr_tabCard objectAtIndex:sender.tag];
    self.index = (int)sender.tag;
    self.bankId = entity.BankId;
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self deleteBankCard];
    }
}

-(void)deleteBankCard{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,DeleteBankcardById];
    NSDictionary *dic = @{@"id":self.bankId};
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        if ([Status isEqualToString:SUCCESS]) {
            [self.arr_tabCard removeObjectAtIndex:self.index];
            [self.tableView_card reloadData];
        }
        if (self.arr_tabCard.count == 0) {
            [self.tableView_card setBackgroundView:self.tab_backGroundView];
        }else{
            [self.tableView_card setBackgroundView:nil];
        }
    } fail:^(NSError *error) {
        NetError;
    }];
}


-(void)NavLeftAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillDisappear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
}
-(void)btnRAdd{
    AddBankViewController *addView = [[AddBankViewController alloc]init];
    [self.navigationController pushViewController:addView animated:YES];
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
