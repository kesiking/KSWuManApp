//
//  KSUtils.h
//  basicFoundation
//
//  Created by 许学 on 15/6/16.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSUtils : NSObject

+ (BOOL)isValidMobile:(NSString *)mobile;

+ (NSString*)do3DESEncrypt:(NSString*)plainStr key:(NSData*)key;
+ (NSString*)do3DESDecrypt:(NSString*)cipherStr key:(NSData*)key;
+ (NSData*)do3DESEncrypt:(NSData*)plainData key:(NSData*)key isEncrypt:(BOOL)isEncrypt;

+ (NSData *)createRandomSecret;

+ (NSString*)encryptPayKey:(NSData*)payKey pkvalue:(NSString*)pkvalue;
+ (NSString*)encryptLoginPwd:(NSString*)loginPwd pkvalue:(NSString*)pkvalue;
+ (NSString*)doRSAPublicEncrypt:(NSData*)plainData pkvalue:(NSString*)pkvalue;

+ (NSString*)bytesToHex:(NSData*)bytesData;
+ (NSData*)hexToBytes:(NSString*)strHex;

+ (BOOL)isPureDigit:(NSString*)str;
+ (BOOL)isPureLetter:(NSString*)str;

+ (BOOL)isEmptyString:(NSString*)str;

+ (NSString*)getCurrentTime;

@end
