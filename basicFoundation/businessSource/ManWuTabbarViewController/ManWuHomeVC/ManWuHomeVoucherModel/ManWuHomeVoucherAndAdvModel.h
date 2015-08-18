//
//  ManWuHomeVoucherAndAdvModel.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/8/18.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"
#import "ManWuHomeVoucherModel.h"
#import "ManWuHomeAdvertisementModel.h"

@interface ManWuHomeVoucherAndAdvModel : WeAppComponentBaseItem

@property (nonatomic, strong) ManWuHomeAdvertisementModel*  advertisementModel;
@property (nonatomic, strong) ManWuHomeVoucherModel*        voucherModel;

@end
