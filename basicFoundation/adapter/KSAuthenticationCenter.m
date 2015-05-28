//
//  KSAuthenticationCenter.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAuthenticationCenter.h"

@implementation KSAuthenticationCenter

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class Public



+ (instancetype)sharedCenter {
    static id sharedCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCenter = [[self alloc] init];
    });
    return sharedCenter;
}

+ (NSString*)userId{
    return @"18626876800";
}

- (void)authenticateWithLoginActionBlock:(loginActionBlock)loginActionBlock cancelActionBlock:(cancelActionBlock)cancelActionBlock{
    
    NSMutableDictionary* callBacks = [NSMutableDictionary dictionary];
    if (loginActionBlock) {
        [callBacks setObject:loginActionBlock forKey:kLoginSuccessBlock];
    }
    
    if (cancelActionBlock) {
        [callBacks setObject:cancelActionBlock forKey:kLoginCancelBlock];
    }
    
    TBOpenURLFromTargetWithNativeParams(loginURL, [UIApplication sharedApplication].keyWindow.rootViewController, nil, callBacks);
}

@end
