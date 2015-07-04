//
//  ManWuHongBaoViewController.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHongBaoViewController.h"
#import "ManWuHongBaoView.h"
#import "ManWuHomeVoucherModel.h"

@interface ManWuHongBaoViewController()

@property (nonatomic, strong) ManWuHongBaoView           *hongBaoView;

@property (nonatomic, strong) ManWuHomeVoucherModel      *voucherModel;

@end

@implementation ManWuHongBaoViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        self.voucherModel = [nativeParams objectForKey:@"voucherModel"];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"商品列表";
    [self.view addSubview:self.hongBaoView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidUnload{
    self.hongBaoView = nil;
    [super viewDidUnload];
}

-(ManWuHongBaoView *)hongBaoView{
    if (_hongBaoView == nil) {
        _hongBaoView = [[ManWuHongBaoView alloc] initWithFrame:self.view.bounds];
        [_hongBaoView setVoucherModel:self.voucherModel];
    }
    return _hongBaoView;
}

@end
