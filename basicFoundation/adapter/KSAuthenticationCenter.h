//
//  KSAuthenticationCenter.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManWuLoginContent.h"

@interface KSAuthenticationCenter : NSObject

+ (instancetype)sharedCenter;

+ (NSString*)userId;

- (void)authenticateWithLoginActionBlock:(loginActionBlock)loginActionBlock cancelActionBlock:(cancelActionBlock)cancelActionBlock;

@end
