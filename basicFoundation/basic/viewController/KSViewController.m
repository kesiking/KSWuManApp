//
//  KSViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSViewController.h"

@interface KSViewController ()

@end

@implementation KSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self measureViewFrame];
    [self setupView];
}

-(void)measureViewFrame{
    CGRect frame = self.view.frame;
    frame.size.height -= (self.navigationController.viewControllers.count > 1 ? 0 : (CGRectGetHeight(self.tabBarController.tabBar.bounds))) + [KSFoundationCommon getAdapterHeight];
    ;
    if (!CGRectEqualToRect(frame, self.view.frame)) {
        [self.view setFrame:frame];
    }
}

-(void)setupView{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
