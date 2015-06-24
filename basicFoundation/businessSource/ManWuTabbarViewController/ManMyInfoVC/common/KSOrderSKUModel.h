//
//  KSOrderSKUModel.h
//  basicFoundation
//
//  Created by 许学 on 15/6/22.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@protocol KSOrderSKUModel <NSObject>

@end

@interface KSOrderSKUModel : WeAppComponentBaseItem

@property (nonatomic, strong) NSString *propertyId;
@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *valueId;

@end
