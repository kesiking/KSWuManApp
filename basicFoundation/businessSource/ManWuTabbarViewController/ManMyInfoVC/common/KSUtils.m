//
//  KSUtils.m
//  basicFoundation
//
//  Created by 许学 on 15/6/16.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSUtils.h"

#include <openssl/des.h>
#include<openssl/rsa.h>
#include<openssl/pem.h>
#include<openssl/err.h>

#import "base64.h"

#define LEN_OF_3DES_KEY 24

const char encodingTable[16] =  {
    '0', '1', '2', '3', '4', '5', '6', '7',
    '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'
};
const char decodingTable[128] =  {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0, 0, 0, 0,
    0, 10, 11, 12, 13, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 10, 11, 12, 13, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};

static NSString * const kMWCMRandomRangeString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@implementation KSUtils

+ (NSData*)BCDEncode:(NSString*)str
{
    int i = 0, j = 0;
    int len = (int)[str length];
    int max = len - (len % 2);
    
    
    int size = (int)(len + len % 2);
    int adjust = (size % 16) ? 1 : 0;
    size = (size / 16) * 8 +  adjust * 8;
    
    char *buf = (char*)malloc(size);
    while (i < max) {
        buf[j++] = (([str characterAtIndex:i] - '0') << 4) | ([str characterAtIndex:i+1] - '0');
        i += 2;
    }
    if ((len % 2) == 1) {
        buf[j] = (([str characterAtIndex:i] - '0') << 4) | 0x0A;
    }
    return [NSData dataWithBytes:buf length:size];
}

+ (NSString*)BCDDecode:(NSData*)data
{
    char* buf = (char *)malloc([data length] * 2);
    memset(buf, 0, [data length] * 2);
    char* pData = (char*)[data bytes];
    for (int i = 0; i < [data length]; ++i)
    {
        buf[2*i] = (char)(((pData[i]  & 0xf0) >> 4) + '0');
        if ((i != [data length]) && ((pData[i] & 0xf) != 0x0A))
            buf[2*i+1] = ((char) ((pData[i] & 0x0f) + '0'));
    }
    return [NSString stringWithUTF8String:buf];
}


+ (NSData*)desKey16to24:(NSData*)key
{
    NSMutableData* alignedKey = [NSMutableData data];
    
    unsigned long ulKeyLen = [key length];
    if (ulKeyLen == 16)
    {
        [alignedKey appendData:key];
        [alignedKey appendBytes:[key bytes] length:8];
    }
    else if (ulKeyLen == LEN_OF_3DES_KEY)
    {
        [alignedKey appendData:key];
    }
    
    return alignedKey;
}

+ (NSData*)string2ANSI98Block:(NSString*)srcStr offset:(NSInteger)offset
{
    NSInteger i = 0;
    NSInteger j = 0;
    
    NSInteger max = [srcStr length] - [srcStr length] % 2;
    
    NSInteger size = [srcStr length] + [srcStr length] % 2 + offset * 2;
    NSInteger adjust = (size % 16) ? 1 : 0;
    size = (size / 16) * 8 +  adjust * 8;
    
    char* buf = (char*)malloc(size);
    if (!buf) {
        return nil;
    }
    memset(buf, 0xff, size);
    
    j = offset;
    while (i < max) {
        
        buf[j++] = (([srcStr characterAtIndex:i] - '0') << 4) | ([srcStr characterAtIndex:i+1] - '0');
        i += 2;
    }
    
    if ([srcStr length] % 2 == 1) {
        buf[j] = (([srcStr characterAtIndex:i] - '0') << 4) | 0x0A;
    }
    
    return [NSData dataWithBytes:buf length:size];
}

+ (NSString*)do3DESEncrypt:(NSString*)plainStr key:(NSData*)key
{
    NSData* cipherData = [KSUtils do3DESEncrypt:[KSUtils string2ANSI98Block:plainStr offset:0] key:key isEncrypt:YES];
    
    return [[KSUtils bytesToHex:cipherData] uppercaseString];
}
+ (NSString*)do3DESDecrypt:(NSString*)cipherStr key:(NSData*)key
{
    NSData* cipherData = [KSUtils hexToBytes:cipherStr];
    NSData* plainData = [KSUtils do3DESEncrypt:cipherData key:key isEncrypt:NO];
    
    return [NSString stringWithUTF8String:[plainData bytes]];
}

+ (NSData*)do3DESEncrypt:(NSData*)plainData key:(NSData*)key isEncrypt:(BOOL)isEncrypt
{
    unsigned long ulDataLen;
    unsigned long ulAlignLen;
    
    char *pcSrc = NULL;
    char *pcDst = NULL;
    unsigned long ulEncryptLen;
    
    unsigned char alignedKey[LEN_OF_3DES_KEY] = {0};
    
    unsigned char block_key[9];
    DES_key_schedule ks,ks2,ks3;
    
    int enc = isEncrypt ? DES_ENCRYPT : DES_DECRYPT;
    
    key = [KSUtils desKey16to24:key];
    if ([key length] == 0)
    {
        return nil;
    }
    memcpy(alignedKey, [key bytes], LEN_OF_3DES_KEY);
    
    ulDataLen = [plainData length];
    ulAlignLen = ulDataLen % 8;
    ulEncryptLen = ulDataLen /*+ (8 - ulAlignLen)*/;
    
    pcSrc = malloc(ulEncryptLen+1);
    memset(pcSrc, 0, ulEncryptLen+1);
    pcDst = malloc(ulEncryptLen+1);
    memset(pcDst, 0, ulEncryptLen+1);
    if (NULL == pcSrc || NULL == pcDst)
    {
        return nil;
    }
    
    unsigned long ulCount;
    unsigned char tmp[8];
    unsigned char out[8];
    
    
    memcpy(pcSrc, [plainData bytes], ulDataLen);
    //memset(src + data_len, ch, 8 - data_rest);
    
    memset(block_key, 0, sizeof(block_key));
    memcpy(block_key, alignedKey + 0, 8);
    DES_set_key_unchecked((const_DES_cblock*)block_key, &ks);
    memcpy(block_key, alignedKey + 8, 8);
    DES_set_key_unchecked((const_DES_cblock*)block_key, &ks2);
    memcpy(block_key, alignedKey + 16, 8);
    DES_set_key_unchecked((const_DES_cblock*)block_key, &ks3);
    
    ulCount = ulEncryptLen / 8;
    for (int i = 0; i < ulCount; i++)
    {
        memset(tmp, 0, 8);
        memset(out, 0, 8);
        memcpy(tmp, pcSrc + 8 * i, 8);
        
        DES_ecb3_encrypt((const_DES_cblock*)&tmp, (DES_cblock*)&out, &ks, &ks2, &ks3, enc);
        memcpy(pcDst + 8 * i, out, 8);
    }
    
    NSData* encryptData = [NSData dataWithBytes:pcDst length:ulEncryptLen];
    if (NULL != pcSrc)
    {
        free(pcSrc);
        pcSrc = NULL;
    }
    if (NULL != pcDst)
    {
        free(pcDst);
        pcDst = NULL;
    }
    return encryptData;
}

+ (NSString *)getRandomStr:(NSInteger)length
{
    NSMutableString* randomStr = [NSMutableString string];
    int range = (int)[kMWCMRandomRangeString length];
    for (int i = 0; i < length; ++ i) {
        int index = arc4random() % range;
        [randomStr appendString:[kMWCMRandomRangeString substringWithRange:[kMWCMRandomRangeString rangeOfComposedCharacterSequenceAtIndex:index]]];
    }
    
    return randomStr;
}

+ (NSData *)createRandomSecret
{
    char oddRandom[16] = {0};
    for (int i = 0; i < 16; ++ i) {
        char random = arc4random() % 128;
        char ch = 0;
        char val = 0;
        ch = (random & 0xFFFFFFFE);
        for (int j = 7; j > 0; j--) {
            val = (val ^ 0x1 & ch >> j);
        }
        
        val = (val ^ 0x1);
        val = (ch | val);
        oddRandom[i] = val;
    }
    
    return [NSMutableData dataWithBytes:oddRandom length:16];
    
    //return randomKey;
    
}

+ (RSA*)createRsaPublicKey:(NSString*)pkvalue
{
    //NSData* pk = [KSUtils hexToBytes:pkvalue];
    NSData *pk = [Base64 decodeString:pkvalue];
    NSLog(@"%ld",[pk length]);
    unsigned char* pPubKey = (unsigned char*)malloc([pk length]);
    if (!pPubKey)
    {
        return NULL;
    }
    memcpy(pPubKey, [pk bytes], [pk length]);
    
    RSA* pRsa = RSA_new();
    pRsa = d2i_RSAPublicKey(&pRsa,(const unsigned char**)&pPubKey, [pk length]);
    
    return pRsa;
}


+ (NSData*)toPKCSLoginPwd:(NSString*)plainData
{
    char padding[256] = {0};
    
    int dataLen = (int)[plainData length];
    int fillLen = 256 - dataLen;
    
    padding[0] = 0x00;
    padding[1] = 0x02;
    
    //    NSString* fileStr = [MWUtils getRandomStr:fillLen];
    //    memcpy(padding+2, [fileStr UTF8String], fillLen);
    for (int i = 2; i < fillLen+2; i++) {
        padding[i] = 0xff;
    }
    
    
    int startIndex = 2 + fillLen;
    padding[startIndex] = 0x00;
    
    memcpy(padding+startIndex+1, [plainData UTF8String], dataLen);
    
    return [NSData dataWithBytes:padding length:256];
}

+ (NSData*)toPKCSEncode:(NSData*)plainData
{
    char prefix[98] = {0};
    
    prefix[0] = 0x00;
    prefix[1] = 0x02;
    
    for (int i = 2; i < 97; i++) {
        prefix[i] = 0xff;
    }
    
    prefix[97] = 0x00;
    
    NSMutableData* padding = [NSMutableData dataWithBytes:prefix length:98];
    
    NSData* data = [KSUtils toPKCSData:plainData];
    
    [padding appendData:data];
    
    return padding;
    
}

+ (NSData*)toPKCSData:(NSData*)plainData
{
    char padding[30] = {0};
    padding[0] = 0x30;
    padding[1] = 0x1c;
    padding[2] = 0x04;
    padding[3] = [plainData length];
    memcpy(padding+4, [plainData bytes], [plainData length]);
    padding[20] = 0x04;
    padding[21] = 0x08;
    for (int i = 22; i < 30; i++) {
        padding[i] = 0xff;
    }
    return [NSData dataWithBytes:padding length:30];
}

+ (NSString*)encryptPayKey:(NSData*)payKey pkvalue:(NSString*)pkvalue
{
    NSData* padding = [KSUtils toPKCSEncode:payKey];
    
    return [KSUtils doRSAPublicEncrypt:padding pkvalue:pkvalue];
}

+ (NSString*)encryptLoginPwd:(NSString*)loginPwd pkvalue:(NSString*)pkvalue
{
    //NSData* padding = [KSUtils toPKCSLoginPwd:loginPwd];
    
    NSData *padding = [loginPwd dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",padding);
    
    return [KSUtils doRSAPublicEncrypt:padding pkvalue:pkvalue];
}

+ (NSString*)doRSAPublicEncrypt:(NSData*)plainData pkvalue:(NSString*)pkvalue
{
    unsigned char *pDest;
    RSA *pRsa;
    int iSrcLen,iRsaLen;
    
    if((pRsa = [KSUtils createRsaPublicKey:pkvalue]) == NULL)
    {
        return @"";
    }
    
    iSrcLen=(int)[plainData length];
    iRsaLen=RSA_size(pRsa);
    
    pDest=(unsigned char *)malloc(iRsaLen+1);
    memset(pDest,0,iRsaLen+1);
    
    int ret = RSA_public_encrypt(iSrcLen, (unsigned char *)[plainData bytes], pDest, pRsa, RSA_NO_PADDING);
    //int ret = RSA_private_encrypt(iSrcLen, (unsigned char *)[plainData bytes], pDest, pRsa, RSA_NO_PADDING);
    if(ret < 0)
    {
        RSA_free(pRsa);
        return @"";
    }
    
    RSA_free(pRsa);
    
    NSData* encData = [NSData dataWithBytes:pDest length:iRsaLen];
    if (pDest)
    {
        free(pDest);
        pDest = NULL;
    }
    return [KSUtils bytesToHex:encData];
}

+ (NSString*)bytesToHex:(NSData*)bytesData
{
    NSMutableString *hex = [NSMutableString string];
    unsigned char *bytes = (unsigned char *)[bytesData bytes];
    char temp[3];
    int i = 0;
    
    for (i = 0; i < [bytesData length]; i++) {
        temp[0] = temp[1] = temp[2] = 0;
        (void)sprintf(temp, "%02x", bytes[i]);
        [hex appendString:[NSString stringWithUTF8String:temp]];
    }
    
    return [hex uppercaseString];
}

+ (NSData*)hexToBytes:(NSString*)strHex
{
    NSMutableData* data = [[NSMutableData alloc] init];
    int idx;
    for (idx = 0; idx+2 <= strHex.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [strHex substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

+ (BOOL)isPureDigit:(NSString*)str
{
    NSScanner* scan = [NSScanner scannerWithString:str];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isPureLetter:(NSString*)str
{
    for(int i=0;i<str.length;i++)
    {
        unichar c=[str characterAtIndex:i];
        if((c<'A'||c>'Z')&&(c<'a'||c>'z'))
        {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)isEmptyString:(NSString*)str
{
    if (str == nil || [str length] == 0)
    {
        return YES;
    }
    
    return NO;
}


+ (NSString*)getCurrentTime
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    
    NSString *  currentTime =[dateformatter stringFromDate:senddate];
    
    return currentTime;
    
}

//现有手机号段:
//移动：139   138   137   136   135   134   147   150   151   152   157   158    159   178  182   183   184   187   188
//联通： 130   131   132   155   156   185   186   145   176
//电信： 133   153   177   180   181   189
+ (BOOL)isValidMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])| (17[678])|(14[57]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}




@end
