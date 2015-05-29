//
//  ManWuMyInfoViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuMyInfoViewController.h"
#import "ManWuLoginContent.h"

@implementation ManWuMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor redColor];
    [button setFrame:self.view.bounds];
    [button addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)doClick{
    TBOpenURLFromSourceAndParams(internalURL(KManWuCommodityListFavorite), self, nil);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- KSTabBarViewControllerProtocol

-(BOOL)shouldSelectViewController:(UIViewController *)viewController{
    BOOL isLogin = YES;
    if (!isLogin) {
        WEAKSELF
        void(^cancelActionBlock)(void) = ^(void){
            [WeAppToast toast:@"取消登陆"];
        };
        
        void(^loginActionBlock)(BOOL loginSuccess) = ^(BOOL loginSuccess){
            STRONGSELF
            // 如果登陆成功就跳转到当前
            [strongSelf.rdv_tabBarController setSelectedViewController:strongSelf];
        };
        
        NSDictionary *callBacks =[NSDictionary dictionaryWithObjectsAndKeys:loginActionBlock, kLoginSuccessBlock,cancelActionBlock, kLoginCancelBlock, nil];
        
        TBOpenURLFromTargetWithNativeParams(loginURL, self, nil, callBacks);
    }
    return isLogin;
}

@end
