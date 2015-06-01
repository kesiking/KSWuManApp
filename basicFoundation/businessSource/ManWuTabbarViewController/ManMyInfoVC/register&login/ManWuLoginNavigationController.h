//
//  ManWuLoginNavigationController.h
//  basicFoundation
//
//  Created by 许学 on 15/5/31.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManWuLoginViewController.h"

@interface ManWuLoginNavigationController : UINavigationController

@property (nonatomic, strong) UIBarButtonItem *btn_cancel;

@property (nonatomic, strong) ManWuLoginViewController *loginVC;

@end
