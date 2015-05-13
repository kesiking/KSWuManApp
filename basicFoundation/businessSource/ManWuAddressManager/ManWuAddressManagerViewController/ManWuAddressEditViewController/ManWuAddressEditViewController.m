//
//  ManWuAddressEditViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressEditViewController.h"
#import "ManWuAddressEditView.h"
#import "ManWuAddressInfoModel.h"
#import "ManWuAddressManagerMaroc.h"

@interface ManWuAddressEditViewController ()

@property (nonatomic,strong) ManWuAddressEditView   * addressEditView;

@property (nonatomic,strong) ManWuAddressInfoModel  * addressInfoModel;

@property (nonatomic,strong) addressDidChangeBlock  addressDidChangeBlock;

@end

@implementation ManWuAddressEditViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        if (nativeParams) {
            self.addressDidChangeBlock = [nativeParams objectForKey:kAddressManagerSuccessBlock];
            self.addressInfoModel = [nativeParams objectForKey:kAddressModelKey];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑收货地址";
    [self.view addSubview:self.addressEditView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ManWuAddressEditView *)addressEditView{
    if (_addressEditView == nil) {
        _addressEditView = [[ManWuAddressEditView alloc] initWithFrame:self.view.bounds];
        [_addressEditView setAddressInfoModel:self.addressInfoModel];
        if (self.addressDidChangeBlock) {
            _addressEditView.addressDidChangeBlock = self.addressDidChangeBlock;
        }
    }
    return _addressEditView;
}

@end
