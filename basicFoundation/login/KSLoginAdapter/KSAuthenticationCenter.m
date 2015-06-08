//
//  KSAuthenticationCenter.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAuthenticationCenter.h"
#import "KSLoginComponentItem.h"

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
    if (![self isLogin]) {
        return nil;
    }
    id userIdObj = [KSLoginComponentItem sharedInstance].userId;
    if (userIdObj) {
        return [NSString stringWithFormat:@"%@",userIdObj];
    }
    return nil;
}

+ (BOOL)isLogin{
    return [KSLoginComponentItem sharedInstance].isLogined;
}

- (void)authenticateWithLoginActionBlock:(loginActionBlock)loginActionBlock cancelActionBlock:(cancelActionBlock)cancelActionBlock{
    if ([[self class] isLogin]) {
        loginActionBlock(YES);
    }else{
        NSMutableDictionary* callBacks = [NSMutableDictionary dictionary];
        if (loginActionBlock) {
            [callBacks setObject:loginActionBlock forKey:kLoginSuccessBlock];
        }
        
        if (cancelActionBlock) {
            [callBacks setObject:cancelActionBlock forKey:kLoginCancelBlock];
        }
        
        TBOpenURLFromTargetWithNativeParams(loginURL, [UIApplication sharedApplication].keyWindow.rootViewController, nil, callBacks);
    }
}

@end
