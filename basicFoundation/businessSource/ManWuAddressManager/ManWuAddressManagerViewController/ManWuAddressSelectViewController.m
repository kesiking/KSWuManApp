//
//  ManWuAddressManagerViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressSelectViewController.h"
#import "ManWuAddressSelectListView.h"
#import "ManWuAddressInfoModel.h"

#define kAddressSelectedSuccessBlock         @"AddressSelectedSuccessBlock"
#define kAddressSelectedFailureBlock         @"AddressSelectedFailureBlock"

typedef void (^successWrapper)(ManWuAddressInfoModel *addressModel);
typedef void (^failureWrapper)();

@interface ManWuAddressSelectViewController ()

@property (nonatomic,strong) ManWuAddressSelectListView* commodityListView;

@property (nonatomic,strong) successWrapper              successBlock;

@property (nonatomic,strong) failureWrapper              failureWrapper;

@end

@implementation ManWuAddressSelectViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        if (nativeParams) {
            self.successBlock = [nativeParams objectForKey:kAddressSelectedSuccessBlock];
            self.failureWrapper = [nativeParams objectForKey:kAddressSelectedFailureBlock];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择收货地址";
    [self.view addSubview:self.commodityListView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStyleBordered target:self action:@selector(managerAddress)];
    [self.view addSubview:self.commodityListView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)managerAddress{
    // 跳转到管理地址页面
}

-(ManWuAddressSelectListView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuAddressSelectListView alloc] initWithFrame:self.view.bounds];
        WEAKSELF
        _commodityListView.addressSelectBlock = ^(ManWuAddressInfoModel* addressComponentItem){
            STRONGSELF
            if (strongSelf.successBlock) {
                strongSelf.successBlock(addressComponentItem);
            }
        };
    }
    return _commodityListView;
}
@end
