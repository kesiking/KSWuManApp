//
//  KSOrderModel.h
//  basicFoundation
//
//  Created by 许学 on 15/5/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSOrderSKUModel.h"

@interface KSOrderModel : WeAppComponentBaseItem

@property (nonatomic, strong) NSString* itemId;
@property (nonatomic, strong) NSString* buyNum;
@property (nonatomic, strong) NSString* buyerAddress;
@property (nonatomic, strong) NSString* buyerName;
@property (nonatomic, strong) NSString* buyerPhone;
@property (nonatomic, strong) NSString* createTime;
@property (nonatomic, strong) NSString* discount;
@property (nonatomic, strong) NSString* imgUrl;
@property (nonatomic, strong) NSString* orderId;
@property (nonatomic, strong) NSString* oriPrice;
@property (nonatomic, strong) NSString* payPrice;
@property (nonatomic, strong) NSArray <KSOrderSKUModel>* skuList ;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* status;
@property (nonatomic, strong) NSString* voucher;

@end
