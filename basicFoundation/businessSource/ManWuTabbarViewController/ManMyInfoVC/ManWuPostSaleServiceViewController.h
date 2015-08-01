//
//  ManWuPostSaleServiceViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/7/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSOrderModel.h"

typedef void(^PostSaleServiceSuccess)(BOOL ret);///申请退款回调

@interface ManWuPostSaleServiceViewController : UIViewController<WeAppBasicServiceDelegate>

@property (nonatomic, strong) KSOrderModel *orderModel;
@property (nonatomic, strong) KSAdapterService *service;
@property (nonatomic, copy) PostSaleServiceSuccess postSaleServeSuccess;///申请退款回调

@end
