//
//  KSViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSViewController.h"
#import "KSModelStatusBasicInfo.h"

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

#pragma mark- TBModelStatusHandler

- (TBModelStatusHandler*)statusHandler{
    if (_statusHandler == nil) {
        KSModelStatusBasicInfo *info = [[KSModelStatusBasicInfo alloc] init];
        
        info.titleForErrorBlock=^(NSError*error){
            return @"服务器正忙，请稍微再试";
        };
        info.subTitleForErrorBlock=^(NSError*error){
            return @"";
        };
        info.actionButtonTitleForErrorBlock=^(NSError*error){
            return @"立刻刷新";
        };
        
        WEAKSELF
        _statusHandler = [[TBModelStatusHandler alloc] initWithStatusInfo:info];
        _statusHandler.selectorForErrorBlock=^(NSError *error){
            STRONGSELF
            [strongSelf refreshDataRequest];
        };
    }
    return _statusHandler;
}

#pragma mark- override by subclass

-(void)refreshDataRequest{
    
}

#pragma mark- used by subclass

-(void)showLoadingView{
    [self.statusHandler showLoadingViewInView:self.view];
}

-(void)hideLoadingView{
    [self.statusHandler hideLoadingView];
}

-(void)showErrorView:(NSError*)error{
    [self.statusHandler showViewforError:error inView:self.view frame:self.view.frame];
}

-(void)hideErrorView{
    [self.statusHandler removeStatusViewFromView:self.view];
}

-(void)showEmptyView{
    [self.statusHandler showEmptyViewInView:self.view frame:self.view.frame];
}

-(void)hideEmptyView{
    [self.statusHandler removeStatusViewFromView:self.view];
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
