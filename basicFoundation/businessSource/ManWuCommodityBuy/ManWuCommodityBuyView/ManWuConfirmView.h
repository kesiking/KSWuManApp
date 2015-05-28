//
//  ManWuConfirmView.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuBuyBasicView.h"

typedef void (^confirmButtonClick)(void);

@interface ManWuConfirmView : ManWuBuyBasicView

@property (nonatomic,strong) confirmButtonClick     confirmButtonClick;

@end
