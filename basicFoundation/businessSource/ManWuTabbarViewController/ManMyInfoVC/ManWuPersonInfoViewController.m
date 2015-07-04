//
//  ManWuPersonInfoViewController.m
//  e企
//
//  Created by royaMAC on 14-11-14.
//  Copyright (c) 2014年 QYB. All rights reserved.
//

#import "ManWuPersonInfoViewController.h"
#import "ManWuChangePwdViewController.h"
#import "ManWuUserNameViewController.h"

#define HEADHIGHT   10
#define FOOTHIGHT   0.5
#define CELLHIGHT   44
#define FirstHIGHT  60
#define CELL_CONTENT_WIDTH 290  //tableView行宽
#define DEFAULT_CELL_HEIGHT 44      //tableView默认行高
#define exit_alert_tag 20//退出登录
#define update_alert_tag 21//更新




@interface ManWuPersonInfoViewController ()<UIAlertViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    MBProgressHUD *_progressHUD;    ///<指示器
    NSString *headStr;
    NSInteger reqTimes;
    UIImageView * headImg;
    UIImageView * bigImageView;
    UIView *overView ;
    AFHTTPRequestOperationManager *manager;
}

@end

@implementation ManWuPersonInfoViewController

-(KSAdapterService *)service{
    if (_service == nil) {
        _service = [[KSAdapterService alloc] init];
        _service.delegate = self;
        [_service setItemClass:[NSDictionary class]];
        _service.jsonTopKey = @"data";
    }
    return _service;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    self.title = @"设置个人资料";
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _table.delegate=self;
    _table.dataSource=self;
    _table.scrollEnabled = NO;
    _table.sectionFooterHeight = 1;
    [self.view addSubview:_table];
    
    [self quitMethod];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.table reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark  - tableView Delegate方法

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger rows = 0;
    if (section == 0) {
        rows = 3;
    }else
        rows = 1;
    
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        return 60;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell * cell_person=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell_person == nil)
    {
        cell_person=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell_person.textLabel.font=[UIFont boldSystemFontOfSize:14];
        cell_person.selectionStyle = UITableViewCellSelectionStyleNone;
        cell_person.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                cell_person.textLabel.text=@"头像";
                
                headImg=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 60, 5 , 50, 50)];
                headImg.layer.masksToBounds = YES;
                headImg.layer.cornerRadius = headImg.frame.size.width * 0.5;
                if([[KSUserInfoModel sharedConstant].imgUrl length] == 0)
                {
                    headImg.image = [UIImage imageNamed:@"tabitem_home_highlight"];
                }else
                {
                    NSURL *url = [NSURL URLWithString:[KSUserInfoModel sharedConstant].imgUrl];                    
                    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
                    headImg.image = image;
                }
                [cell_person.contentView addSubview:headImg];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigHeadImg:)];
                headImg.userInteractionEnabled = YES;
                [headImg addGestureRecognizer:tap];

            }
                break;
             
            case 1:
            {
                cell_person.textLabel.text = @"用户名";
                cell_person.detailTextLabel.text = [KSUserInfoModel sharedConstant].userName;
            }
                break;
                
            case 2:
            {
                cell_person.textLabel.text = @"手机号码";
                cell_person.detailTextLabel.text = [KSUserInfoModel sharedConstant].phone;
                cell_person.accessoryType = UITableViewCellAccessoryNone;
            }
                break;
                
            default:
                break;
        }
    }else
        cell_person.textLabel.text=@"修改密码";
    
    return cell_person;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            [self updateHeadImg];
        }else if (indexPath.row == 1)
        {
            ManWuUserNameViewController *userNameVC = [[ManWuUserNameViewController alloc]init];
            [self.navigationController pushViewController:userNameVC animated:YES];
        }
    }
    
    if(indexPath.section == 1)
    {
        ManWuChangePwdViewController *changePwd = [[ManWuChangePwdViewController alloc]init];
        [self.navigationController pushViewController:changePwd animated:YES];
    }

}

- (void)quitMethod
{
    UIView *viewQuit = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SELFWIDTH, 100)];
    [_table setTableFooterView:viewQuit];
    
    CGRect rectButton=CGRectMake(kSpaceX,60, WIDTH, DEFAULT_CELL_HEIGHT);
    UIButton * quitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame=rectButton;
    quitBtn.tag=2001;
    [quitBtn setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#dc7868"]] forState:UIControlStateNormal];
    quitBtn.layer.cornerRadius=3;
    [quitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(quitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewQuit addSubview:quitBtn];
}

#pragma mark - UIAlertViewDelegate
-(void)quitButtonClick:(UIButton*)sender
{
//    if (sender.tag==2001) {
//        UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"退出后不会删除任何历史数据，下次登录仍然可以使用本账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出登录", nil];
//        alertView.tag = exit_alert_tag;
//        [alertView show];
//    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[LOGIN_FLAG filePathOfCaches] error:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(CGSize)lableSize:(NSString*)str
{
    CGSize size = [str boundingRectWithSize:CGSizeMake(167.0f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    return size;
}

-(void)showBigHeadImg:(UITapGestureRecognizer *)headerTap
{
    
}


#pragma mark- 更换头像
-(void)updateHeadImg
{
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [action showInView:self.view];
}


#pragma mark - 打开摄像头的调用--打开相册调用统一方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        
        CustomImagePickerController *picker = [[CustomImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [picker setCustomDelegate:self];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alert show];
        }
        
        [self presentViewController:picker animated:YES completion:^{
            self.hidesBottomBarWhenPushed = YES;
        }];
        
    }if (buttonIndex==1)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
    }if(buttonIndex == 3)
    {
        
    }
    
}
- (void)cameraPhoto:(UIImage *)image  //选择完图片
{
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    [fitler setDelegate:self];
    fitler.currentImage = image;
    [self presentViewController:fitler animated:YES completion:nil];
}

- (void)cancelCamera
{
    
}

- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    UIImage * NewImage = [self imageWithImage:image scaledToSize:CGSizeMake(250,250)];
    [self uploadDataWithImage:NewImage];
}

#pragma mark - 打开摄像头的调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //图片存入相册
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        if ([picker allowsEditing]) {
            image=[info objectForKey:UIImagePickerControllerEditedImage];
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        if ([picker allowsEditing]) {
            image=[info objectForKey:UIImagePickerControllerEditedImage];
        }
    }
    
    CGSize imageSize = image.size;
    imageSize.width = 250;
    imageSize.height = 250;
    
    
    image = [self imageWithImage:image scaledToSize:imageSize];
    [self uploadDataWithImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)useThePersoninfoImageChangeOther:(Myblock)myblock{
    self.myblock = myblock;
}

- (void)uploadDataWithImage:(UIImage *)image
{
    //初始化指示器
    
    if (!_progressHUD) {
        _progressHUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        _progressHUD.detailsLabelText=@"上传头像中...";
        _progressHUD.removeFromSuperViewOnHide=YES;
    }
    
    NSData *imgData=UIImageJPEGRepresentation(image , 0.4);
    NSString *imgDataString=[imgData base64Encoding];
    [self.service loadItemWithAPIName:@"user/modifyUser.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId, @"imgb64":imgDataString} version:nil];
}

#pragma mark - 对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark - WeAppBasicServiceDelegate method

- (void)serviceDidStartLoad:(WeAppBasicService *)service
{
    if (service == _service) {
        // todo success
    }
}

- (void)serviceDidFinishLoad:(WeAppBasicService *)service
{
    if (service == _service) {
        // todo success
        if (_progressHUD) {
            [_progressHUD hide:YES];
            _progressHUD = nil;
        }
        
        NSDictionary *dic_userInfo = [NSDictionary dictionaryWithDictionary:(NSDictionary*)service.requestModel.item];

        [[KSUserInfoModel sharedConstant]updateUserInfo:dic_userInfo];
        
        [self.table reloadData];

        [WeAppToast toast:@"修改头像成功"];
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    if (service == _service) {
        // todo fail
        if (_progressHUD) {
            [_progressHUD hide:YES];
            _progressHUD = nil;
        }
        
        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
        [WeAppToast toast:errorInfo];
    }
}

#pragma mark - Navigation
/*
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
