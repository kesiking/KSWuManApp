//
//  KSBasicURLResolver.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-22.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSBasicURLResolver.h"

@implementation KSBasicURLResolver

- (BOOL)handleURLAction:(TBURLAction*)urlAction{
    [self preprocessURLAction:urlAction];
    UIViewController* viewController = [self viewControllerWithAction:urlAction];
    if (viewController == nil) {
        return NO;
    }
    urlAction.targetController = viewController;
    return YES;
}

-(void)preprocessURLAction:(TBURLAction*)urlAction{
    if (urlAction.urlPath == nil) {
        return;
    }
    
    if (urlAction.navigationParams == nil) {
        urlAction.navigationParams = [[TBNavigationParams alloc] init];
    }
    urlAction.navigationParams.navigationType = TBNavigationTypePush;
    urlAction.navigationParams.animated = YES;
}

-(UIViewController *)viewControllerWithAction:(TBURLAction *)action {
    NSString* viewClassNamePath = [action isActionURLLegal] ? [action getURLPathWithoutSlash] : action.urlPath;
    UIViewController* viewController = [self viewControllerWithAction:action forPath:viewClassNamePath];
    return viewController;
}

-(UIViewController*)viewControllerWithAction:(TBURLAction*)action forPath:(NSString*)path{
    Class controllerClass = NSClassFromString([[[KSNavigator navigator] registeredPlugin] objectForKey:path]);
    if ([controllerClass isSubclassOfClass:[UIViewController class]]) {
        UIViewController* controller = [[controllerClass alloc] initWithNavigatorURL:action.URL query:action.extraInfo nativeParams:action.nativeParams];
        return controller;
    }else{
        return nil;
    }
}

@end
