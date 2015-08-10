//
//  ManWuPostSaleServiceViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/7/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuPostSaleServiceViewController.h"
#import "KSDropDownListView.h"
#import "UIPlaceHolderTextView.h"

@interface ManWuPostSaleServiceViewController ()
{
    BOOL isRegister;
    BOOL isKeyShow;//是否有键盘
    UIScrollView *scrollView;
    KSDropDownListView *dropdownListService;
    UIPlaceHolderTextView *textView;
}

@end

@implementation ManWuPostSaleServiceViewController


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
    // Do any additional setup after loading the view.
    self.title = @"申请退款";
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    
//    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//    scrollView.contentSize = CGSizeMake(self.view.width,  self.view.height + 50);
//    [scrollView setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
//    
//    UITapGestureRecognizer* singleTapRecognizer;
//    singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
//    singleTapRecognizer.numberOfTapsRequired = 1; // 单击
//    [scrollView addGestureRecognizer:singleTapRecognizer];
//    [self setView:scrollView];

    dropdownListService = [[KSDropDownListView alloc]initWithFrame:CGRectMake(10, 15, self.view.width - 20, 60*6) CellHeight:60];
    dropdownListService.userActionLabel.text = @"申请服务";
    dropdownListService.dataArray = @[@"未收到货",@"商品质量问题",@"商品错发",@"商品运输破损",@"其他"];
    [self.view addSubview:dropdownListService];

    textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(dropdownListService.frame) + 75, self.view.width - 20, 200)];
    textView.placeholderColor = [TBDetailUIStyle colorWithHexString:@"#adadad"];
    textView.layer.cornerRadius = 3;
    textView.placeholder = @"退款说明 最多100字";
    [self.view addSubview:textView];
    
    UIButton *btn_commit = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, self.view.height - 150, WIDTH, 40)];
    [btn_commit setTitle:@"提交" forState:UIControlStateNormal];
    [btn_commit.titleLabel setFont:[UIFont systemFontOfSize:18]];
    btn_commit.titleLabel.textColor = [UIColor whiteColor];
    [btn_commit setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#dc7868"]] forState:UIControlStateNormal];
    [btn_commit addTarget:self action:@selector(doPostSaleService) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_commit];
    
    isRegister = NO;
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    //注册键盘显示通知
    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘隐藏通知
    [center addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 监听View点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
}

#pragma mark 键盘显示时调用
- (void)keyBoardWillShow:(NSNotification *)notification
{
    if(isKeyShow)
    {
        return;
    }
    isKeyShow=YES;
    //    //获取LoginArea的视图
    //    UIView *LoginArea=[self.view viewWithTag:VIEW_TAG];
    //    //获取LoginArea的Rect
    //    CGRect loginAreaRect=LoginArea.frame;
    //键盘Rect
    CGRect keyBoardRect=[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //偏移量
    CGFloat distance = -dropdownListService.height;
    [self animationWithUserInfo:notification.userInfo bloack:^{
        if (self.view.frame.size.height == 480) {
            self.view.transform=CGAffineTransformTranslate(self.view.transform, 0, distance);
            
        }
        else{
            //                self.ZYlabel.transform=CGAffineTransformTranslate(self.ZYlabel.transform, 0, distance);
            self.view.transform=CGAffineTransformTranslate(self.view.transform, 0, distance);
        }
        //            self.ZYlabel.transform = CGAffineTransformTranslate(self.ZYlabel.transform, 0, distance);
    }];
}
#pragma mark 键盘隐藏时调用
- (void)keyBoardWillHidden:(NSNotification *)notification
{
    isKeyShow=NO;
    [self animationWithUserInfo:notification.userInfo bloack:^{
        self.view.transform=CGAffineTransformIdentity;
        //        self.ZYlabel.transform = CGAffineTransformIdentity;
    }];
    
}
#pragma mark 键盘动画
- (void)animationWithUserInfo:(NSDictionary *)userInfo bloack:(void (^)(void))block
{
    // 取出键盘弹出的时间
    CGFloat duration=[userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue];
    // 取出键盘弹出动画曲线
    NSInteger curve=[userInfo[UIKeyboardAnimationCurveUserInfoKey]integerValue];
    //开始动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    //调用bock
    block();
    [UIView commitAnimations];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [textView resignFirstResponder];
}

- (void)doPostSaleService
{
    NSString *orderReason = textView.text;
    
    if([orderReason length] > 100)
    {
        [WeAppToast toast:@"退款说明最多100字"];
        return;
    }
    
    [self.service loadItemWithAPIName:@"order/refundOrder.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId, @"orderId":self.orderModel.orderId, @"type":[NSString stringWithFormat:@"%ld",(long)dropdownListService.serviceType],@"reason":orderReason?:@""} version:nil];
}

#pragma mark WeAppBasicServiceDelegate method

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
        [WeAppToast toast:@"申请退款成功"];

        if(self.postSaleServeSuccess)
        {
            self.postSaleServeSuccess(YES);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error
{
    if (service == _service) {
        // todo fail
        [WeAppToast toast:@"服务器在偷懒，请稍后再试"];
    }
    
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
