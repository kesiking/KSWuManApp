//
//  ManWuAddressSetDefaultView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"

typedef void(^addressSwitchClick) (BOOL isOn);

@interface ManWuAddressSetDefaultView : KSView

@property (nonatomic, assign) BOOL                       isDefaultAddress;

@property (nonatomic, strong) addressSwitchClick         addressSwitchClick;

@end
