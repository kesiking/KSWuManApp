//
//  ManWuHongBaoView.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "ManWuHomeVoucherModel.h"

typedef NS_ENUM(NSInteger, ManWuVoucherType) {
    ManWuVoucherTypeInviteCode        = 1,
    ManWuVoucherTypeRegister          = 2,
    ManWuVoucherTypeBuyBuyBuy         = 3,
};

@interface ManWuHongBaoView : KSView

@property (nonatomic, strong) ManWuHomeVoucherModel       *voucherModel;

@end
