//
//  NSString+MD5.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/12.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString *)md5HexDigest

{
    
    const char *original_str = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
    
}

@end
