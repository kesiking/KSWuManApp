//
//  MWUtils.h
//  MobileWallet
//
//  Created by louzhenhua on 8/18/14.
//  Copyright (c) 2014 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWUtils : NSObject

+ (NSData *)createRandomSecret;

+ (NSString*)bytesToHex:(NSData*)bytesData;
+ (NSData*)hexToBytes:(NSString*)strHex;

+ (BOOL)isValidMobile:(NSString *)mobile;
+ (BOOL)isValidPassword:(NSString *)password;
+ (BOOL)isPureDigit:(NSString*)str;
+ (BOOL)isPureLetter:(NSString*)str;

+ (BOOL)isEmptyString:(NSString*)str;

+ (void)showSecondTimeout:(NSUInteger)time timerOutHandler:(void(^)(BOOL end, NSUInteger remaintime))timerOutHandler;

+ (NSString*)getCurrentTime;
@end
