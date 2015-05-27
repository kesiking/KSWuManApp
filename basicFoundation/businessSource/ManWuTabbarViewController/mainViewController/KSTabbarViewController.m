//
//  KSMainViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-22.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSTabbarViewController.h"

@interface KSTabbarViewController ()

@end

@implementation KSTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self measureViewFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIViewController *rdv_tabBarController = self.rdv_tabBarController;
    [rdv_tabBarController setTitle:self.title];
    // 设置bar颜色
    UINavigationController* navigationController = self.navigationController;
    if([navigationController.navigationBar respondsToSelector:@selector(barTintColor)]){
        navigationController.navigationBar.barTintColor = RGB(0xed, 0x65, 0x65);
    }else if([navigationController.navigationBar respondsToSelector:@selector(tintColor)]){
        navigationController.navigationBar.tintColor = RGB(0xed, 0x65, 0x65);
    }
}

-(void)measureViewFrame{
    CGRect frame = self.view.frame;
    frame.size.height -= 56;
    if (!CGRectEqualToRect(frame, self.view.frame)) {
        [self.view setFrame:frame];
    }
}

#pragma mark- KSTabBarViewControllerProtocol

-(BOOL)shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

// 点击选中
-(void)didSelectViewController:(UIViewController*)viewController{
    
}

// 重复点击选中
-(void)didSelectSameViewController:(UIViewController *)viewController{
    
}

@end
