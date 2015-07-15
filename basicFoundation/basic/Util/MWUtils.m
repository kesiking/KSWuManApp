//
//  MWUtils.m
//  MobileWallet
//
//  Created by louzhenhua on 8/18/14.
//  Copyright (c) 2014 CMCC. All rights reserved.
//

#import "MWUtils.h"

@implementation MWUtils

//现有手机号段:
//移动：139   138   137   136   135   134   147   150   151   152   157   158    159   178  182   183   184   187   188
//联通： 130   131   132   155   156   185   186   145   176
//电信： 133   153   177   180   181   189
+ (BOOL)isValidMobile:(NSString *)mobile
{
    if (mobile == nil || ![mobile isKindOfClass:[NSString class]] || mobile.length == 0) {
        return NO;
    }
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])| (17[678])|(14[57]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidPassword:(NSString *)password
{
    if (password == nil) {
        return NO;
    }
    if (![password isKindOfClass:[NSString class]]) {
        return NO;
    }
    return password.length >= 6 && password.length <= 20;
}

+ (BOOL)isEmptyString:(NSString*)str
{
    if (str == nil || [str length] == 0)
    {
        return YES;
    }
    
    return NO;
}

@end
