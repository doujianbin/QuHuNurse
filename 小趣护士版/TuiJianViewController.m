//
//  TuiJianViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/24.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "TuiJianViewController.h"
#import "ErWeiMa.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface TuiJianViewController (){
    UIImageView *erweima;
}

@property (nonatomic ,retain)UIView *view_hui;
@property (nonatomic ,retain)UIView *view_share;
@property (nonatomic ,retain)UIButton *btn_sharehaoyou;
@property (nonatomic ,retain)UIButton *btn_sharepengyouquan;

@end

@implementation TuiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"邀请有奖";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"Rectangle 91 + Line + Line Copy"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [btnl addTarget:self action:@selector(NavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    
    erweima = [[UIImageView alloc]initWithFrame:CGRectMake(88, 128, SCREEN_WIDTH - 88 * 2,SCREEN_WIDTH - 88 * 2)];
    [self.view addSubview:erweima];
    
    NSString *str_erweima = [NSString stringWithFormat:@"%@%@",[[LoginStorage ShareDic] objectForKey:@"url"],[LoginStorage nurseId]];

    
    UIImage *i_erweima = [ErWeiMa ErWeiMaReturn:[ErWeiMa createString:str_erweima] withSize:erweima.frame.size.width - 5];
    [erweima setImage:i_erweima];
    
    NSString *strGuiZe = @"被推荐人通过审核，可得到50元奖励；\n 推荐人可获得20元奖励；被推荐人完成首单后,\n推荐人再获得80元奖励；完成首单后可提现；";
    UILabel *labGuiZe = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(erweima.frame) + 50 , SCREEN_WIDTH, 55)];
    labGuiZe.font = [UIFont systemFontOfSize:14];
    labGuiZe.textAlignment = NSTextAlignmentCenter;
    labGuiZe.numberOfLines = 0;
    [labGuiZe setTextColor:[UIColor colorWithHexString:@"#262626"]];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:strGuiZe];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:10];
    [labGuiZe setAttributedText:attributedString1];
    [self.view addSubview:labGuiZe];
    
    UIButton *btn_share = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 60 - 44, SCREEN_WIDTH - 40, 44)];
    [self.view addSubview:btn_share];
    [btn_share setTitle:@"邀请好友参加" forState:UIControlStateNormal];
    [btn_share setBackgroundColor:[UIColor colorWithHexString:@"#FA6262"]];
    btn_share.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    btn_share.layer.cornerRadius = 3.0f;
    btn_share.layer.masksToBounds = YES;
    [btn_share addTarget:self action:@selector(ShareAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)ShareAction{
    CGRect size = [UIScreen mainScreen].bounds;
    self.view_hui = [[UIView alloc]initWithFrame:size];
    [self.view.window addSubview:self.view_hui];
    [self.view_hui setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.6]];
    
    self.view_share = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    [self.view_hui addSubview:self.view_share];
    [self.view_share setBackgroundColor:[UIColor whiteColor]];
    
    //创建view_share上的控件
    
    self.btn_sharehaoyou = [[UIButton alloc]initWithFrame:CGRectMake(90, 35, 50, 50)];
    [self.view_share addSubview:self.btn_sharehaoyou];
    [self.btn_sharehaoyou setBackgroundImage:[UIImage imageNamed:@"微信好友"] forState:UIControlStateNormal];
    [self.btn_sharehaoyou addTarget:self action:@selector(haoyouAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_sharepengyouquan = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 140, 35, 50, 50)];
    [self.view_share addSubview:self.btn_sharepengyouquan];
    [self.btn_sharepengyouquan setBackgroundImage:[UIImage imageNamed:@"朋友圈"] forState:UIControlStateNormal];
    [self.btn_sharepengyouquan addTarget:self action:@selector(pengyouquanAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgxian = [[UIImageView alloc]initWithFrame:CGRectMake(10,110, self.view.frame.size.width - 20, 0.5)];
    [self.view_share addSubview:imgxian];
    [imgxian setImage:[UIImage imageNamed:@"二维码虚线"]];
    
    UIButton *btn_quxiao = [[UIButton alloc]initWithFrame:CGRectMake(20, 120, self.view.frame.size.width - 40, 30)];
    [self.view_share addSubview:btn_quxiao];
    [btn_quxiao setTitle:@"取 消" forState:UIControlStateNormal];
    btn_quxiao.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_quxiao setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [btn_quxiao addTarget:self action:@selector(quxiaoshareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:0.6];
    [self.view_share setFrame:CGRectMake(0, self.view.frame.size.height - 160, self.view.frame.size.width, 160)];
    [UIView commitAnimations];
    
}

- (void)haoyouAction
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = [[LoginStorage ShareDic] objectForKey:@"title"];
    message.description = [[LoginStorage ShareDic] objectForKey:@"desc"];
    [message setThumbImage:[UIImage imageNamed:@"120 - share"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [NSString stringWithFormat:@"%@%@",[[LoginStorage ShareDic] objectForKey:@"url"],[LoginStorage nurseId]];
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
    
}

- (void)pengyouquanAction
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = [[LoginStorage ShareDic] objectForKey:@"title"];
    message.description = [[LoginStorage ShareDic] objectForKey:@"desc"];
    [message setThumbImage:[UIImage imageNamed:@"120 - share"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [NSString stringWithFormat:@"%@%@",[[LoginStorage ShareDic] objectForKey:@"url"],[LoginStorage nurseId]];
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
    
}

-(void)quxiaoshareAction:(UIButton *)sender{
    [self.view_hui removeFromSuperview];
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
