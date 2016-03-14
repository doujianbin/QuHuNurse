//
//  DetailUserInfoViewController.m
//  小趣医生端
//
//  Created by 窦建斌 on 15/12/21.
//  Copyright © 2015年 窦建斌. All rights reserved.
//

#import "DetailUserInfoViewController.h"
//#import "MyHospitalViewController.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface DetailUserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>{
    UIImagePickerController *ipc;
    UIButton *btn_headPic;
}

@property(nonatomic ,retain)UITableView *tableView1;
@property(nonatomic ,retain)UITableView *tableView2;
@property(nonatomic ,retain)NSMutableArray *arrTab2;
@property(nonatomic ,strong)NSString *strImg;
@property(nonatomic ,strong)AFNManager *manager;


@end

@implementation DetailUserInfoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrTab2 = [[NSMutableArray alloc]initWithObjects:@"姓名",@"我的科室",@"我的职称", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F6F7"]];
    self.title = @"个人信息";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A4A4A"]}];
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"Rectangle 91 + Line + Line Copy"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    [btnl addTarget:self action:@selector(NavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 132 + 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView1];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableView1"];
    self.tableView1.scrollEnabled = NO;
    
    ipc = [[UIImagePickerController alloc] init];
    //表示用户可编辑图片。
    ipc.allowsEditing = YES;
    [ipc setDelegate:self];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
            return 75;
        }
    if (indexPath.row == 1) {
            return 57;
        }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == self.tableView1) {
        return 2;
    }
    return 0;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            UILabel *labT = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 36, 25)];
            [cell addSubview:labT];
            [labT setText:@"头像"];
            labT.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
            labT.font = [UIFont systemFontOfSize:18];
            
            btn_headPic = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 89, 7.5, 60, 60)];
            [cell addSubview:btn_headPic];
            [btn_headPic addTarget:self action:@selector(btn_headPicAction) forControlEvents:UIControlEventTouchUpInside];
            [btn_headPic sd_setBackgroundImageWithURL:[NSURL URLWithString:self.userInfoEntity.photo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_医生介绍"]];
        }
        if (indexPath.row == 1) {
            UILabel *labT = [[UILabel alloc]initWithFrame:CGRectMake(15, 16, 80, 25)];
            [cell addSubview:labT];
            [labT setText:@"姓名"];
            labT.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
            labT.font = [UIFont systemFontOfSize:18];
            
            UILabel *labT2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 95, 16, 80, 25)];
            [cell addSubview:labT2];
            [labT2 setText:self.userInfoEntity.name];
            labT2.textColor = [UIColor colorWithHexString:@"#969696"];
            labT2.font = [UIFont systemFontOfSize:16];
            labT2.textAlignment = NSTextAlignmentRight;
            
        }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self btn_headPicAction];
    }
}

-(void)btn_headPicAction{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择上传头像方式"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"相册",nil];
    actionSheet.actionSheetStyle = UIBarStyleDefault;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        default:
            return;
    }
    [self presentViewController:ipc animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [btn_headPic setImage:image forState:UIControlStateNormal];
    NSData *data1 = UIImageJPEGRepresentation(image, 0.6);
    self.strImg = [data1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [self updataHeadPic];
    
}

-(void)updataHeadPic{
    NSString *strUlr = [NSString stringWithFormat:@"%@%@",Development,SavePersonalInfo];
    NSDictionary *dic = @{@"nickName":@"昵称",@"photo":self.strImg,@"photoExt":@"jpg"};
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUlr method:@"POST" parameter:dic result:^(id responseDic) {
        NSLog(@"上传头像结果:%@",responseDic);
        if ([Status isEqualToString:SUCCESS]) {
            [self.view makeToast:@"上传头像成功" duration:1.0 position:@"center"];
        }else{
            FailMessage;
        }
        
    } fail:^(NSError *error) {
        NetError;
        [btn_headPic setImage:[UIImage imageNamed:@"ic_医生介绍"] forState:UIControlStateNormal];
    }];
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
