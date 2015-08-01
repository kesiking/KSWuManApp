//
//  ManWuBuyOrderPayView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuBuyBasicView.h"

@interface ManWuBuyOrderPayView : ManWuBuyBasicView

@property (nonatomic, strong)   NSNumber*                   payPrice;

@property (nonatomic, assign)   float                       voucherPrice;

-(NSNumber*)getTruePriceWithVoucherPrice;

@end
