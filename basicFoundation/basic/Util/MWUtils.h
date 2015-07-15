//
//  MWUtils.h
//  MobileWallet
//
//  Created by louzhenhua on 8/18/14.
//  Copyright (c) 2014 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWUtils : NSObject

+ (BOOL)isValidMobile:(NSString *)mobile;
+ (BOOL)isValidPassword:(NSString *)password;
+ (BOOL)isEmptyString:(NSString*)str;

@end
