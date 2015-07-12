//
//  ManWuHomeViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHomeViewController.h"
#import "ManWuHomeHeaderView.h"
#import "ManWuCommodityListView.h"
#import "ManWuCommodityNewListService.h"
#import "KSSafePayUtility.h"

@interface ManWuHomeViewController (){
    
}

@property (nonatomic, strong) ManWuHomeHeaderView          *headerView;

@property (nonatomic, strong) ManWuCommodityListView       *commodityListView;

@property (nonatomic, strong) ManWuCommodityNewListService *newListService;

@end

@implementation ManWuHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"屋满";
    [self.view addSubview:self.commodityListView];
    [self.headerView refresh];
    [self.headerView sizeToFit];
    [self.commodityListView.collectionViewCtl setColletionHeaderView:self.headerView];
    [self.newListService loadCommodityListData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UINavigationController* navigationController = self.navigationController;
    if([navigationController.navigationBar respondsToSelector:@selector(barTintColor)]){
        navigationController.navigationBar.barTintColor = RGB(0xe8, 0x53, 0x53);
    }else if([navigationController.navigationBar respondsToSelector:@selector(tintColor)]){
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    
//    NSDictionary* resultDict = @{@"resultStatus":@9000,@"memo":@"",@"result":@"partner=\"2088911272587293\"&seller_id=\"hzwuman@126.com\"&out_trade_no=\"2015071254093120345\"&subject=\"男装外套测试商品1\"&body=\"男装外套测试商品1\"&total_fee=\"0.01\"&notify_url=\"http://115.29.227.64/wuman/order/callbackOrder.do\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&show_url=\"m.alipay.com\"&success=\"true\"&sign_type=\"RSA\"&sign=\"iOMOBdDSo38NFnbHXii0nXIrOzwlc+GAvkN/cbtqKoNBQtRnkULEoF9m6KeRvhcQvuZl43rNdRjfhpG6ajahIVh2J8zQdHJ/FrRMp3ZKCBAzmDE/wumm3U01zoH/w5a3qGZuWKKRyz+SK6pBEhU/h9k5C5xJuPcCXnkgLAe6SNI=\""};
//    [KSSafePayUtility processResultStatus:resultDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - discountInfo

-(ManWuHomeHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[ManWuHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.commodityListView.collectionViewCtl.frame.size.width, 0)];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}

#pragma mark - commodityListView

-(ManWuCommodityListView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuCommodityListView alloc] initWithFrame:self.view.bounds];
        _commodityListView.backgroundColor = [UIColor whiteColor];
        __weak __block __typeof(self) weadSelf = self;
        _commodityListView.collectionViewCtl.onRefreshEvent = ^(KSScrollViewServiceController* scrollViewController){
            if (weadSelf == nil) {
                return;
            }
            __strong __typeof(self) strongSelf = weadSelf;
            [strongSelf.headerView refresh];
        };
        [_commodityListView setCollectionService:self.newListService];
    }
    return _commodityListView;
}

-(ManWuCommodityNewListService *)newListService{
    if (_newListService == nil) {
        _newListService = [[ManWuCommodityNewListService alloc] init];
    }
    return _newListService;
}

@end
