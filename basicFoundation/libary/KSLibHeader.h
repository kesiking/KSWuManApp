//
//  KSLibHeader.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-20.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#ifndef basicFoundation_KSLibHeader_h
#define basicFoundation_KSLibHeader_h

#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "RDVTabBarController.h"
#import "SVWebViewController.h"
#import "SVModalWebViewController.h"
#import "SVPullToRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIView+Geometry.h"
#import "WeAppComponentBaseItem.h"
#import "NSArray+TBJSONModel.h"
#import "NSDictionary+TBJSONModel.h"
#import "WeAppBasicService.h"
#import "Routable.h"
#import "WeAppConstant.h"
#import "NSDictionary+JSONSerialize.h"
#import "UIViewController+KSNavigator.h"
#import "KSNavigator.h"
#import "MBProgressHUD.h"
#import "WeAppToast.h"

#define WEAKSELF typeof(self) __weak __block weakSelf = self;
#define STRONGSELF typeof(self) __strong strongSelf = weakSelf;

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#endif
