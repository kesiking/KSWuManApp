//
//  KSLoginViewController.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSLoginViewController.h"
#import "KSLoginView.h"
#import "KSLoginMaroc.h"

@interface KSLoginViewController ()

@property (nonatomic,strong) loginActionBlock  loginActionBlock;

@property (nonatomic,strong) cancelActionBlock cancelActionBlock;

@property (nonatomic,strong) KSLoginView       *loginView;

@end

@implementation KSLoginViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    self = [self init];
    if (self) {
        self.loginActionBlock = [nativeParams objectForKey:kLoginSuccessBlock];
        self.cancelActionBlock = [nativeParams objectForKey:kLoginCancelBlock];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    self.title = @"登录";
    
    [self.view addSubview:self.loginView];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.loginView.loginViewCtl.btn_register];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.loginView.loginViewCtl.btn_cancel];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.loginView reloadData];
}

-(KSLoginView *)loginView{
    if (_loginView == nil) {
        _loginView = [[KSLoginView alloc] initWithFrame:self.view.bounds];
        WEAKSELF
        _loginView.loginActionBlock = ^(BOOL success){
            STRONGSELF
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
            if (strongSelf.loginActionBlock) {
                strongSelf.loginActionBlock(success);
            }
        };
        _loginView.cancelActionBlock = ^(){
            STRONGSELF
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
            if (strongSelf.cancelActionBlock) {
                strongSelf.cancelActionBlock();
            }
        };
    }
    return _loginView;
}

@end
