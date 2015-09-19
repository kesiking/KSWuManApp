//
//  KSWebViewController.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/9/19.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSWebViewController.h"

@implementation KSWebViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    UINavigationController* navigationController = self.navigationController;
    if([navigationController.navigationBar respondsToSelector:@selector(barTintColor)]){
        navigationController.navigationBar.barTintColor = RGB(0xf8, 0xf8, 0xf8);
    }
    if([navigationController.navigationBar respondsToSelector:@selector(tintColor)]){
        navigationController.navigationBar.tintColor  =  RGB(0x66, 0x66, 0x66);
    }
    
    // 修改navbar title颜色
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               RGB(0x66, 0x66, 0x66), NSForegroundColorAttributeName,
                                               [UIFont boldSystemFontOfSize:18], NSFontAttributeName,nil];
    [navigationController.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];
}

@end
