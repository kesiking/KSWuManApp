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
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    
    self.title = @"申请退款";
    
    KSDropDownListView *dropdownList1= [[KSDropDownListView alloc]initWithFrame:CGRectMake(10, 15, self.view.width - 20, 140)];
    //[dropdownList1 setBackgroundColor:[TBDetailUIStyle colorWithHexString:@"#ffffff"]];
    dropdownList1.userActionLabel.text = @"是否已收货";
    dropdownList1.dataArray = @[@"已收货",@"未收货"];
    [self.view addSubview:dropdownList1];

    KSDropDownListView *dropdownList2= [[KSDropDownListView alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(dropdownList1.frame) + 75, self.view.width - 20, 140)];
    //[dropdownList2 setBackgroundColor:[TBDetailUIStyle colorWithHexString:@"#ffffff"]];
    dropdownList2.userActionLabel.text = @"申请服务";
    dropdownList2.dataArray = @[@"退款",@"退货"];
    [self.view addSubview:dropdownList2];

    UIPlaceHolderTextView *textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(dropdownList2.frame) + 75, self.view.width - 20, 120)];
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

- (void)doPostSaleService
{
    
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
