//
//  ManWuAddressBottomVIew.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"

typedef void(^addressBottomClick) (void);

@interface ManWuAddressBottomVIew : KSView

@property (nonatomic, strong) addressBottomClick           addressBottomClick;

@end
