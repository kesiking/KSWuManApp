//
//  ManWuLoginContent.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#ifndef basicFoundation_ManWuLoginContent_h
#define basicFoundation_ManWuLoginContent_h

#define loginFailCode      (1004)
#define loginFailDomain    @"login failed"

#define kLoginSuccessBlock @"loginSuccessBlock"
#define kLoginCancelBlock  @"loginCancelBlock"

typedef void (^loginActionBlock)(BOOL loginSuccess);
typedef void (^cancelActionBlock)(void);

#endif
