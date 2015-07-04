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
    
    KSDropDownListView *dropdownList1= [[KSDropDownListView alloc]initWithFrame:CGRectMake(10, 15, self.view.width - 20, 44)];
    dropdownList1.userActionLabel.text = @"是否已收货";
    dropdownList1.dataArray = @[@"已收货",@"未收货"];
    [self.view addSubview:dropdownList1];

    KSDropDownListView *dropdownList2= [[KSDropDownListView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(dropdownList1.frame) + 15, self.view.width - 20, 44)];
    dropdownList2.userActionLabel.text = @"申请服务";
    dropdownList2.dataArray = @[@"退款",@"退货"];
    [self.view addSubview:dropdownList2];

    UIPlaceHolderTextView *textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(dropdownList2.frame) + 15, self.view.width - 20, 100)];
    textView.placeholderColor = [TBDetailUIStyle colorWithHexString:@"#adadad"];
    textView.placeholder = @"退款说明 最多100字";
    [self.view addSubview:textView];
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
