//
//  KSLoginKeyChain.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSLoginKeyChain.h"
#import "KeychainItemWrapper.h"

#define keyChainIdentifier @"kesiking.login.identifier"

#define keyChainGroup      @"com.kesiking.login.group"

@interface KSLoginKeyChain(){
    KeychainItemWrapper *       _keyChainItem;
}

@end

@implementation KSLoginKeyChain

+(KSLoginKeyChain *)sharedInstance{
    static KSLoginKeyChain* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    _keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:keyChainIdentifier accessGroup:keyChainGroup];
}

-(void)setAccountName:(NSString*)accountName{
    if (accountName && accountName.length > 0) {
        [_keyChainItem setObject:accountName forKey:(__bridge id)kSecAttrAccount];
    }
}

-(void)setPassword:(NSString *)password{
    if (password && password.length > 0) {
        [_keyChainItem setObject:password forKey:(__bridge id)kSecValueData];
    }
}

-(NSString*)getAccountName{
    return [_keyChainItem objectForKey:(__bridge id)kSecAttrAccount];
}

-(NSString*)getPassword{
    id passwordObj = [_keyChainItem objectForKey:(__bridge id)kSecValueData];
    if ([passwordObj isKindOfClass:[NSString class]]) {
        return passwordObj;
    }else if ([passwordObj isKindOfClass:[NSData class]]){
        return [[NSString alloc] initWithData:passwordObj encoding:NSUTF8StringEncoding];
    }else if ([passwordObj isKindOfClass:[NSNumber class]]){
        return [(NSNumber*)passwordObj stringValue];
    }
    return nil;
}

#pragma mark - 清空记录
-(void)clear{
    [_keyChainItem resetKeychainItem];
}


@end
