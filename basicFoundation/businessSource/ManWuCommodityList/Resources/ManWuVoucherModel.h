//
//  ManWuVoucherModel.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@interface ManWuVoucherModel : WeAppComponentBaseItem

@property (nonatomic, strong) NSNumber*                   voucherId;
@property (nonatomic, strong) NSString*                   voucherDescription;
@property (nonatomic, strong) NSString*                   startTime;
@property (nonatomic, strong) NSString*                   endTime;
@property (nonatomic, strong) NSNumber*                   price;
@end
