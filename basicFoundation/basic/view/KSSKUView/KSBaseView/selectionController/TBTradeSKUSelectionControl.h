//
//  TBTradeSKUSelectionControl.h
//  TBTrade
//
//  Created by christ.yuj on 14-1-21.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBDetailSKUModelAndService.h"

//  该控件是多个属性sku的父容器，为了保证sku属性之间互斥的方案。
@interface TBTradeSKUSelectionControl : UIControl

@property (nonatomic, strong) TBDetailSKUModelAndService *detailModel;

@end
