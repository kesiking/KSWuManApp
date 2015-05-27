//
//  ManWuCommodityBuyViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-29.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityBuyViewController.h"
#import "ManWuBuyScrollView.h"
#import "ManWuCommodityDetailModel.h"

@interface ManWuCommodityBuyViewController ()

@property (nonatomic, strong) ManWuBuyScrollView             *buyScrollView;

@property (nonatomic, strong) NSString                       *itemId;

@property (nonatomic, strong) NSDictionary                   *skuDict;

@property (nonatomic, strong) ManWuCommodityDetailModel      *detailModel;

@end

@implementation ManWuCommodityBuyViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        self.detailModel = [nativeParams objectForKey:@"detailModel"];
        self.skuDict = [nativeParams objectForKey:@"skuDict"];
        self.itemId = [nativeParams objectForKey:@"itemId"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确定订单";
    [self.view addSubview:self.buyScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ManWuBuyScrollView *)buyScrollView{
    if(_buyScrollView == nil){
        _buyScrollView = [[ManWuBuyScrollView alloc] initWithFrame:self.view.bounds];
        [_buyScrollView setObject:self.detailModel dict:self.skuDict];
    }
    return _buyScrollView;
}

@end
