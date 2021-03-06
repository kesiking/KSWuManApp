/*
 @author: ideawu
 @link: https://github.com/ideawu/Objective-C-RSA
*/

#import <Foundation/Foundation.h>

@interface RSAEncrypt : NSObject

+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSString *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;

@end
