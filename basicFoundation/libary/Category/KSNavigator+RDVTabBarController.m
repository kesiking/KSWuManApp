//
//  KSNavigator+RDVTabBarController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSNavigator+RDVTabBarController.h"

@implementation RDVTabBarController (KSNavigator)

- (void)addSubcontroller:(UIViewController *)controller navigateType:(TBNavigationType)type animated:(BOOL)animated {
    if (TBNavigationTypeTabbarSelect == type) {
        [self setSelectedViewController:controller];
    } else if (TBNavigationTypePresent == type) {
        [self presentViewController:controller animated:animated completion:NULL];
    }
}

- (void)removeSubController:(UIViewController *)controller navigateType:(TBNavigationType)type animated:(BOOL)animated {
    if (TBNavigationTypeTabbarBack == type) {
    } else if (TBNavigationTypeDismiss == type) {
        [self dismissViewControllerAnimated:animated completion:NULL];
    }
}

@end
