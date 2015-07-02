//
//  ManWuOrderDetailViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/6/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSOrderModel.h"

@interface ManWuOrderDetailViewController : UIViewController<WeAppBasicServiceDelegate>

@property (nonatomic, strong) KSOrderModel *orderModel;
@property (nonatomic, strong) KSAdapterService *service;

@end
