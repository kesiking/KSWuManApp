//
//  ManWuAddAddressView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"

typedef void(^addressAddClick) (void);

@interface ManWuAddAddressView : KSView

@property (nonatomic, strong) addressAddClick         addressAddClick;

@end
