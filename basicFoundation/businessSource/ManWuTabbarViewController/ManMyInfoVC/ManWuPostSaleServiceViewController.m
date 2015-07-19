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
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    scrollView.contentSize = CGSizeMake(self.view.width,  self.view.height + 50);
    [scrollView setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    
    UITapGestureRecognizer* singleTapRecognizer;
    singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    singleTapRecognizer.numberOfTapsRequired = 1; // 单击
    [scrollView addGestureRecognizer:singleTapRecognizer];
    [self setView:scrollView];

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
}

#pragma mark 监听View点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
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
    
    [self.service loadItemWithAPIName:@"user/refundOrder.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId, @"orderId":self.orderModel.orderId, @"type":[NSString stringWithFormat:@"%ld",(long)dropdownListService.serviceType],@"reason":orderReason?:@""} version:nil];
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
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error
{
    if (service == _service) {
        // todo fail
        [WeAppToast toast:error.description];
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
