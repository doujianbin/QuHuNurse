//
//  AuthenticationDataViewController.m
//  小趣护士版
//
//  Created by 窦建斌 on 16/2/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "AuthenticationDataViewController.h"
#import "RadioButton.h"
#import "UITextField+ResignKeyboard.h"
#import "ReviewIngViewController.h"

@interface AuthenticationDataViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *ipc;
    UIButton *btnR;
}

@property (nonatomic,strong)UIScrollView   *scl_back;
@property (nonatomic,strong)UITextField    *tf_name;
@property (nonatomic,strong)RadioButton    *btn_man;
@property (nonatomic,strong)RadioButton    *btn_woman;
@property (nonatomic,strong)UITextField    *tf_identityCard;
@property (nonatomic,strong)UISegmentedControl *segmentedControl;
@property (nonatomic,strong)UIView         *v_students;
@property (nonatomic,strong)UIView         *v_nurse;
@property (nonatomic,strong)UIImageView    *iv_studentsIdCardLeft;
@property (nonatomic,strong)UIImageView    *iv_studentsIdCardRight;
@property (nonatomic,strong)UIImageView    *iv_studentsCard;
@property (nonatomic,strong)UIImageView    *iv_nurseIdCardLeft;
@property (nonatomic,strong)UIImageView    *iv_nurseIdCardRight;
@property (nonatomic,strong)NSMutableArray *arr_nurseCard;
@property (nonatomic,assign)int             int_selectedTag;
@property (nonatomic,strong)AFNManager *manager;
@property (nonatomic,strong)NSString *gender;
@end

@implementation AuthenticationDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F9"]];
    self.title = @"认证资料";
    ipc = [[UIImagePickerController alloc] init];
    //表示用户可编辑图片。
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    self.arr_nurseCard = [NSMutableArray array];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor colorWithHexString:@"#4A4A4A"],
                                                                    UITextAttributeFont : [UIFont systemFontOfSize:17]};
    
    UIButton *btnl = [[UIButton alloc]initWithFrame:CGRectMake(15, 21.5, 20, 20)];
    [btnl setBackgroundImage:[UIImage imageNamed:@"kong"] forState:UIControlStateNormal];
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc]initWithCustomView:btnl];
    self.navigationItem.leftBarButtonItem = btnleft;
    
    btnR = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 49, 10, 34, 24)];
    [btnR setTitle:@"提交" forState:UIControlStateNormal];
    [btnR setTitleColor:[UIColor colorWithHexString:@"#FA6262"] forState:UIControlStateNormal];
    btnR.titleLabel.font = [UIFont systemFontOfSize:17];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc]initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = btnright;
    [btnR addTarget:self action:@selector(btnRaction) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
    [self onCreate];
}

- (void)onCreate{
    self.scl_back = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.scl_back];
    
    UIView  *v_back = [[UIView alloc]initWithFrame:CGRectMake(0,10.5, SCREEN_WIDTH, 57*3)];
    [v_back setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.scl_back addSubview:v_back];
    
    UILabel   *lb_nameTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0 , 80, 57)];
    [lb_nameTitle setFont:[UIFont systemFontOfSize:18]];
    [lb_nameTitle setTextColor:[UIColor colorWithHexString:@"#969696"]];
    [lb_nameTitle setText:@"姓名"];
    [v_back addSubview:lb_nameTitle];
    
    self.tf_name = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 200, 0, 200, 57)];
    [self.tf_name setTextAlignment:NSTextAlignmentRight];
    [self.tf_name setPlaceholder:@"请输入姓名"];
    [self.tf_name setNormalInputAccessory];
    [self.tf_name setFont:[UIFont systemFontOfSize:16]];
    [v_back addSubview:self.tf_name];
    
    UILabel   *lb_genderTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 57 , 80, 57)];
    [lb_genderTitle setFont:[UIFont systemFontOfSize:18]];
    [lb_genderTitle setTextColor:[UIColor colorWithHexString:@"#969696"]];
    [lb_genderTitle setText:@"性别"];
    [v_back addSubview:lb_genderTitle];
    
    self.btn_man = [[RadioButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 55 - 37.5 - 55, 57 + 57/2 - 23/2 , 55, 23)];
    self.btn_man.tag = 0;
    [self.btn_man setTitle:@"男" forState:UIControlStateNormal];
    [self.btn_man setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn_man.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_man setImage:[UIImage imageNamed:@"nm_dian"] forState:UIControlStateNormal];
    [self.btn_man setImage:[UIImage imageNamed:@"hl_dian"] forState:UIControlStateSelected];
    self.btn_man.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btn_man.titleEdgeInsets = UIEdgeInsetsMake(0, 11, 0, 0);
    [v_back addSubview:self.btn_man];
    
    self.btn_woman = [[RadioButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 55,57 + 57/2 - 23/2,55,23)];
    self.btn_woman.tag = 1;
    [self.btn_woman setTitle:@"女" forState:UIControlStateNormal];
    [self.btn_woman setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn_woman.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_woman setImage:[UIImage imageNamed:@"nm_dian"] forState:UIControlStateNormal];
    [self.btn_woman setImage:[UIImage imageNamed:@"hl_dian"] forState:UIControlStateSelected];
    self.btn_woman.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btn_woman.titleEdgeInsets = UIEdgeInsetsMake(0, 11, 0, 0);
    [v_back addSubview:self.btn_woman];
    
    [self.btn_man setGroupButtons:@[self.btn_man,self.btn_woman]]; // Setting buttons into the group
    [self.btn_man setSelected:YES];
    
    UILabel *lb_identityCardTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 57 * 2, 80, 57)];
    [lb_identityCardTitle setFont:[UIFont systemFontOfSize:18]];
    [lb_identityCardTitle setTextColor:[UIColor colorWithHexString:@"#969696"]];
    [lb_identityCardTitle setText:@"身份证号"];
    [v_back addSubview:lb_identityCardTitle];
    
    self.tf_identityCard = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 200, 57*2, 200, 57)];
    [self.tf_identityCard setTextAlignment:NSTextAlignmentRight];
    [self.tf_identityCard setPlaceholder:@"请输入身份证号"];
    [self.tf_identityCard setNormalInputAccessory];
    [self.tf_identityCard setFont:[UIFont systemFontOfSize:16]];
    [v_back addSubview:self.tf_identityCard];
    
    UIView *v_lineOne = [[UIView alloc]initWithFrame:CGRectMake(0, 57 - 0.5, SCREEN_WIDTH,0.5)];
    [v_lineOne setBackgroundColor:[UIColor colorWithHexString:@"#DBDCDD"]];
    [v_back addSubview:v_lineOne];
    
    UIView *v_lineTwo = [[UIView alloc]initWithFrame:CGRectMake(0, 57*2 - 0.5, SCREEN_WIDTH,0.5)];
    [v_lineTwo setBackgroundColor:[UIColor colorWithHexString:@"#DBDCDD"]];
    [v_back addSubview:v_lineTwo];
    
    UIView *v_lineThree = [[UIView alloc]initWithFrame:CGRectMake(0, 57*3 - 0.5, SCREEN_WIDTH,0.5)];
    [v_lineThree setBackgroundColor:[UIColor colorWithHexString:@"#DBDCDD"]];
    [v_back addSubview:v_lineThree];
    
    UIView *v_segmentBack = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(v_back.frame) + 7.5, SCREEN_WIDTH, 74)];
    [v_segmentBack setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.scl_back addSubview:v_segmentBack];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"护理学校学生",@"职业护士",nil];
    //初始化UISegmentedControl
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmentedControl.frame = CGRectMake(15,15,SCREEN_WIDTH - 30,44);
    // 设置默认选择项索引
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = [UIColor colorWithHexString:@"#FA6262"];
    
    // 设置在点击后是否恢复原样
    [self.segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction)forControlEvents:UIControlEventValueChanged];
    [v_segmentBack addSubview:self.segmentedControl];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#FFFFFF"],UITextAttributeTextColor, [UIFont systemFontOfSize:17],UITextAttributeFont ,[UIColor colorWithHexString:@"#DBDCDD"],UITextAttributeTextShadowColor ,nil];
    [self.segmentedControl setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#9B9B9B"],UITextAttributeTextColor, [UIFont systemFontOfSize:17],UITextAttributeFont ,[UIColor colorWithHexString:@"#DBDCDD"],UITextAttributeTextShadowColor,nil];
    
    [self.segmentedControl setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    
    UIView *v_lineFour = [[UIView alloc]initWithFrame:CGRectMake(0, 74 - 0.5, SCREEN_WIDTH,0.5)];
    [v_lineFour setBackgroundColor:[UIColor colorWithHexString:@"#DBDCDD"]];
    [v_segmentBack addSubview:v_lineFour];
    
    self.v_students = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(v_segmentBack.frame),SCREEN_WIDTH, 30*2 + 120 + 159)];
    self.v_students.clipsToBounds = YES;
    [self createStudentsView];
    [self.scl_back addSubview:self.v_students];
    
    self.v_nurse = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(v_segmentBack.frame),SCREEN_WIDTH, 30*2 + 120 + 159)];
    self.v_nurse.clipsToBounds = YES;
    [self.v_nurse setHidden:YES];
    [self createNurseView];
    [self.scl_back addSubview:self.v_nurse];
    
    [self.scl_back setContentSize:CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.v_students.frame))];
    
}

- (void)createStudentsView{
    
    UILabel *lb_photoTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 30)];
    [lb_photoTitle setText:@"上传你的身份证照片"];
    [lb_photoTitle setFont:[UIFont systemFontOfSize:14]];
    [lb_photoTitle setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [self.v_students addSubview:lb_photoTitle];
    
    UIView *v_idPhotoBack = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lb_photoTitle.frame), SCREEN_WIDTH, 120)];
    [v_idPhotoBack setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.v_students addSubview:v_idPhotoBack];
    
    self.iv_studentsIdCardLeft = [[UIImageView alloc]initWithFrame:CGRectMake(20, 16.5, 87, 87)];
    [self.iv_studentsIdCardLeft setImage:[UIImage imageNamed:@"upphoto"]];
    [self.iv_studentsIdCardLeft setTag:0];
    [self.iv_studentsIdCardLeft setUserInteractionEnabled:YES];
    UITapGestureRecognizer *studentsIdCardLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhotoAction:)];
    [self.iv_studentsIdCardLeft addGestureRecognizer:studentsIdCardLeft];
    [v_idPhotoBack addSubview:self.iv_studentsIdCardLeft];
    
    self.iv_studentsIdCardRight = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iv_studentsIdCardLeft.frame) + 15, 16.5, 87, 87)];
    [self.iv_studentsIdCardRight setTag:1];
    [self.iv_studentsIdCardRight setUserInteractionEnabled:YES];
    UITapGestureRecognizer *studentsIdCardRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhotoAction:)];
    [self.iv_studentsIdCardRight addGestureRecognizer:studentsIdCardRight];
    [self.iv_studentsIdCardRight setImage:[UIImage imageNamed:@"upphoto"]];
    [v_idPhotoBack addSubview:self.iv_studentsIdCardRight];
    
    UILabel *lb_memo = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 100, 120 - 16.5 - 20, 100, 20)];
    [lb_memo setText:@"正反2张"];
    [lb_memo setFont:[UIFont systemFontOfSize:14]];
    [lb_memo setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [lb_memo setTextAlignment:NSTextAlignmentRight];
    [v_idPhotoBack addSubview:lb_memo];
    
    UILabel *lb_studentsCardTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(v_idPhotoBack.frame), 200, 30)];
    [lb_studentsCardTitle setText:@"上传你的学生证"];
    [lb_studentsCardTitle setFont:[UIFont systemFontOfSize:14]];
    [lb_studentsCardTitle setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [self.v_students addSubview:lb_studentsCardTitle];
    
    UIView  *v_studentsCardBack = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lb_studentsCardTitle.frame), SCREEN_WIDTH, 159)];
    [v_studentsCardBack setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.v_students addSubview:v_studentsCardBack];
    
    self.iv_studentsCard = [[UIImageView alloc]initWithFrame:CGRectMake(20, 16.5, 87, 87)];
    [self.iv_studentsCard setImage:[UIImage imageNamed:@"upphoto"]];
    self.iv_studentsCard.tag = 2;
    [self.iv_studentsCard setUserInteractionEnabled:YES];
    UITapGestureRecognizer *studentsCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhotoAction:)];
    [self.iv_studentsCard addGestureRecognizer:studentsCard];
    [v_studentsCardBack addSubview:self.iv_studentsCard];
    
    UILabel *lb_studentsCardMemo = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.iv_studentsCard.frame) + 10, 87, 20)];
    [lb_studentsCardMemo setText:@"学生证首页"];
    [lb_studentsCardMemo setTextAlignment:NSTextAlignmentCenter];
    [lb_studentsCardMemo setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [lb_studentsCardMemo setFont:[UIFont systemFontOfSize:14]];
    [v_studentsCardBack addSubview:lb_studentsCardMemo];
    
    UIImageView *iv_example = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iv_studentsCard.frame) + 33, 16.5, 123.5, 87)];
    [iv_example setImage:[UIImage imageNamed:@"studentsCard"]];
    [v_studentsCardBack addSubview:iv_example];
    
    UILabel *lb_exampleMemo = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iv_studentsCard.frame) + 33, CGRectGetMaxY(iv_example.frame) + 10, 123.5, 20)];
    [lb_exampleMemo setText:@"示例"];
    [lb_exampleMemo setTextAlignment:NSTextAlignmentCenter];
    [lb_exampleMemo setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [lb_exampleMemo setFont:[UIFont systemFontOfSize:14]];
    [v_studentsCardBack addSubview:lb_exampleMemo];
    
}

- (void)createNurseView{
    UILabel *lb_photoTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 30)];
    [lb_photoTitle setText:@"上传你的身份证照片"];
    [lb_photoTitle setFont:[UIFont systemFontOfSize:14]];
    [lb_photoTitle setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [self.v_nurse addSubview:lb_photoTitle];
    
    UIView *v_idPhotoBack = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lb_photoTitle.frame), SCREEN_WIDTH, 120)];
    [v_idPhotoBack setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.v_nurse addSubview:v_idPhotoBack];
    
    self.iv_nurseIdCardLeft = [[UIImageView alloc]initWithFrame:CGRectMake(20, 16.5, 87, 87)];
    [self.iv_nurseIdCardLeft setImage:[UIImage imageNamed:@"upphoto"]];
    self.iv_nurseIdCardLeft.tag = 0;
    [self.iv_nurseIdCardLeft setUserInteractionEnabled:YES];
    UITapGestureRecognizer *nurseIdCardLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhotoAction:)];
    [self.iv_nurseIdCardLeft addGestureRecognizer:nurseIdCardLeft];
    [v_idPhotoBack addSubview:self.iv_nurseIdCardLeft];
    
    self.iv_nurseIdCardRight = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iv_nurseIdCardLeft.frame) + 15, 16.5, 87, 87)];
    self.iv_nurseIdCardRight.tag = 1;
    [self.iv_nurseIdCardRight setUserInteractionEnabled:YES];
    UITapGestureRecognizer *nurseIdCardRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhotoAction:)];
    [self.iv_nurseIdCardRight addGestureRecognizer:nurseIdCardRight];
    [self.iv_nurseIdCardRight setImage:[UIImage imageNamed:@"upphoto"]];
    [v_idPhotoBack addSubview:self.iv_nurseIdCardRight];
    
    UILabel *lb_memo = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 100, 120 - 16.5 - 20, 100, 20)];
    [lb_memo setText:@"正反2张"];
    [lb_memo setFont:[UIFont systemFontOfSize:14]];
    [lb_memo setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [lb_memo setTextAlignment:NSTextAlignmentRight];
    [v_idPhotoBack addSubview:lb_memo];
    
    UILabel *lb_nurseCardTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(v_idPhotoBack.frame), 200, 30)];
    [lb_nurseCardTitle setText:@"上传你的护士执业证书照片"];
    [lb_nurseCardTitle setFont:[UIFont systemFontOfSize:14]];
    [lb_nurseCardTitle setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [self.v_nurse addSubview:lb_nurseCardTitle];
    
    UIView  *v_nurseCardBack = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lb_nurseCardTitle.frame), SCREEN_WIDTH, 159)];
    [v_nurseCardBack setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.v_nurse addSubview:v_nurseCardBack];
    NSArray *arr_memo = @[@"发证机关页",@"执业信息页",@"最近一次 注册日期"];
    
    for (int i = 0; i < 3; i ++) {
        UIImageView *iv_nurseCard = [[UIImageView alloc]initWithFrame:CGRectMake(20 + i*87 + i*15, 16.5, 87, 87)];
        [iv_nurseCard setImage:[UIImage imageNamed:@"upphoto"]];
        [iv_nurseCard setTag:i+2];
        [iv_nurseCard setUserInteractionEnabled:YES];
        UITapGestureRecognizer *nurseCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhotoAction:)];
        [iv_nurseCard addGestureRecognizer:nurseCard];
        [v_nurseCardBack addSubview:iv_nurseCard];
        [self.arr_nurseCard addObject:iv_nurseCard];
        
        UILabel *lb_memo = [[UILabel alloc]initWithFrame:CGRectMake(20 + i*87 + i*15, CGRectGetMaxY(iv_nurseCard.frame) + 10, 87, 20)];
        [lb_memo setText:[arr_memo objectAtIndex:i]];
        [lb_memo setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
        [lb_memo setFont:[UIFont systemFontOfSize:14]];
        [lb_memo setTextAlignment:NSTextAlignmentCenter];
        [v_nurseCardBack addSubview:lb_memo];
        if (i == 2) {
            [lb_memo setFrame:CGRectMake(20 + i*87 + i*15 + 10, CGRectGetMaxY(iv_nurseCard.frame) + 10, 87 - 20, 36)];
            [lb_memo setNumberOfLines:0];
        }
    }
    
}

- (void)selectPhotoAction:(UITapGestureRecognizer *)recognizer{
    UIImageView *iv_sender = (UIImageView *)[recognizer view];
    self.int_selectedTag = (int)iv_sender.tag;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    // Show the sheet
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
            
        case 1:
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
            
        default:
            return;
    }
    [self presentViewController:ipc animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        switch (self.int_selectedTag) {
            case 0:
                [self.iv_studentsIdCardLeft setImage:image];
                break;
            case 1:
                [self.iv_studentsIdCardRight setImage:image];
                break;
            case 2:
                [self.iv_studentsCard setImage:image];
                break;
            default:
                break;
        }
    }else if (self.segmentedControl.selectedSegmentIndex == 1){
        UIImageView *iv_demo = [[UIImageView alloc]init];
        if (self.int_selectedTag >= 2) {
            iv_demo = (UIImageView *)[self.arr_nurseCard objectAtIndex:self.int_selectedTag - 2];
        }
        switch (self.int_selectedTag) {
            case 0:
                [self.iv_nurseIdCardLeft setImage:image];
                break;
            case 1:
                [self.iv_nurseIdCardRight setImage:image];
                break;
            case 2:
                [iv_demo setImage:image];
                break;
            case 3:
                [iv_demo setImage:image];
                break;
            case 4:
                [iv_demo setImage:image];
                break;
            default:
                break;
        }
    }
}


- (void)didClicksegmentedControlAction{
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self.v_students setHidden:NO];
        [self.v_nurse setHidden:YES];
    }else{
        [self.v_students setHidden:YES];
        [self.v_nurse setHidden:NO];
    }
}

-(void)btnRaction{
    UIImage *image = [UIImage imageNamed:@"upphoto"];
    NSData * data = UIImagePNGRepresentation(image);
    if (self.tf_name.text.length == 0) {
        [self.view makeToast:@"请输入姓名" duration:1.0 position:@"center"];
        return;
    }
    if (self.tf_identityCard.text.length == 0) {
        [self.view makeToast:@"请输入身份证号" duration:1.0 position:@"center"];
        return;
    }
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        // 学生的
        if ([UIImagePNGRepresentation(self.iv_studentsIdCardLeft.image) isEqualToData:data]) {
            [self.view makeToast:@"请上传身份证正面照片" duration:1.0 position:@"center"];
            return;
        }
        if ([UIImagePNGRepresentation(self.iv_studentsIdCardRight.image) isEqualToData:data]) {
            [self.view makeToast:@"请上传身份证背面照片" duration:1.0 position:@"center"];
            return;
        }
        if ([UIImagePNGRepresentation(self.iv_studentsCard.image) isEqualToData:data]) {
            [self.view makeToast:@"请上传学生证照片" duration:1.0 position:@"center"];
            return;
        }
        [self uploadStudentMsg];
        [self.view makeToastActivity];
    }else{
        // 护士的
        if ([UIImagePNGRepresentation(self.iv_nurseIdCardLeft.image) isEqualToData:data]) {
            [self.view makeToast:@"请上传身份证正面照片" duration:1.0 position:@"center"];
            return;
        }
        if ([UIImagePNGRepresentation(self.iv_nurseIdCardRight.image) isEqualToData:data]) {
            [self.view makeToast:@"请上传身份证背面照片" duration:1.0 position:@"center"];
            return;
        }
        for (int i = 0; i < self.arr_nurseCard.count; i++) {
            UIImageView *iv = [self.arr_nurseCard objectAtIndex:i];
            if ([UIImagePNGRepresentation(iv.image) isEqualToData:data] && i == 0) {
                [self.view makeToast:@"请上传发证机关页" duration:1.0 position:@"center"];
                return;
            }
            if ([UIImagePNGRepresentation(iv.image) isEqualToData:data] && i == 1) {

                [self.view makeToast:@"请上传执业信息页" duration:1.0 position:@"center"];
                return;
            }
            if ([UIImagePNGRepresentation(iv.image) isEqualToData:data] && i == 2) {
                [self.view makeToast:@"请上传最近一次注册日期" duration:1.0 position:@"center"];
                return;
            }
        }
        [self uploadNurseMsg];
        [self.view makeToastActivity];
    }
    
}
- (void)uploadStudentMsg{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,AuthSaveInfo];
    

    NSData *data_stuIDLeft = UIImageJPEGRepresentation(self.iv_studentsIdCardLeft.image, 0.6);
    NSString *stuIdLeft = [data_stuIDLeft base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSData *data_stuIDRight = UIImageJPEGRepresentation(self.iv_studentsIdCardRight.image, 0.6);
    NSString *strIdRight = [data_stuIDRight base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSData *data_studentCard = UIImageJPEGRepresentation(self.iv_studentsCard.image, 0.6);
    NSString *strStudentCard = [data_studentCard base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    if (self.btn_man.selected == NO) {
        self.gender = @"1";
    }else{
        self.gender = @"0";
    }
    NSDictionary *dic = @{@"name":self.tf_name.text,@"sex":self.gender,@"identityNumber":self.tf_identityCard.text,@"isStudent":@"1",@"studentCard":strStudentCard,@"idNoImageFront":stuIdLeft,@"idNoImageBack":strIdRight,@"photoExt":@"JPEG"};
    self.manager = [[AFNManager alloc]init];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        [self.view hideToastActivity];
        if ([Status isEqualToString:SUCCESS]) {
            ReviewIngViewController *vc = [[ReviewIngViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            FailMessage;
        }
    } fail:^(NSError *error) {
        [self.view hideToastActivity];
        NetError;
    }];
}

- (void)uploadNurseMsg{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Development,AuthSaveInfo];
    
    NSData *data_n_IDLeft = UIImageJPEGRepresentation(self.iv_nurseIdCardLeft.image, 0.6);
    NSString *strIdLeft = [data_n_IDLeft base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSData *data_n_IDRight = UIImageJPEGRepresentation(self.iv_nurseIdCardRight.image, 0.6);
    NSString *strIdRight = [data_n_IDRight base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    UIImageView *iv1 = [self.arr_nurseCard objectAtIndex:0];
    NSData *data_n_fazhengjiguan = UIImageJPEGRepresentation(iv1.image, 0.6);
    NSString *strN1 = [data_n_fazhengjiguan base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    UIImageView *iv2 = [self.arr_nurseCard objectAtIndex:1];
    NSData *data_n_zhiye = UIImageJPEGRepresentation(iv2.image, 0.6);
    NSString *strN2 = [data_n_zhiye base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    UIImageView *iv3 = [self.arr_nurseCard objectAtIndex:2];
    NSData *data_n_3 = UIImageJPEGRepresentation(iv3.image, 0.6);
    NSString *strN3 = [data_n_3 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    if (self.btn_man.selected == NO) {
        self.gender = @"1";
    }else{
        self.gender = @"0";
    }
    NSDictionary *dic = @{@"name":self.tf_name.text,@"sex":self.gender,@"identityNumber":self.tf_identityCard.text,@"isStudent":@"0",@"idNoImageFront":strIdLeft,@"idNoImageBack":strIdRight,@"licenceAuthority":strN1,@"licenceMessage":strN2,@"licenceRegistDate":strN3,@"photoExt":@"JPEG"};
    self.manager = [[AFNManager alloc]init];
    [self.view makeToastActivity];
    [self.manager RequestJsonWithUrl:strUrl method:@"POST" parameter:dic result:^(id responseDic) {
        
        [self.view hideToastActivity];
        if ([Status isEqualToString:SUCCESS]) {
            ReviewIngViewController *vc = [[ReviewIngViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            FailMessage;
        }
    } fail:^(NSError *error) {
        [self.view hideToastActivity];
        NetError;
    }];
    
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
