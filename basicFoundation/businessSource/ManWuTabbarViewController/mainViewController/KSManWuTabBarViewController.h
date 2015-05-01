//
//  KSManWuTabBarViewController.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "RDVTabBarController.h"

@interface KSManWuTabBarViewController : RDVTabBarController

-(UIViewController*)getViewControllerWithURL:(NSString*)url;

@end

@interface UIViewController (KSManWuTabBarViewController)

-(UINavigationController *)KSNavigationController;

@end
