//
//  ManWuVoucherView.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuBuyBasicView.h"

@class ManWuVoucherView;

typedef void (^selectVoucherViewBlock)(ManWuVoucherView *voucherView);

@interface ManWuVoucherView : ManWuBuyBasicView

@property (nonatomic, strong)   NSString*           voucherId;

@property (nonatomic, assign)   float               voucherPrice;

@property (nonatomic, copy)   selectVoucherViewBlock selectVoucherViewBlock;

@end
