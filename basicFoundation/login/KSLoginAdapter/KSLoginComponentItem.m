//
//  KSLoginComponentItem.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSLoginComponentItem.h"
#import "KSLoginKeyChain.h"

@implementation KSLoginComponentItem

static KSLoginComponentItem *userInfoModel=nil;

+(KSLoginComponentItem *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfoModel=[[KSLoginComponentItem alloc] init];
        [userInfoModel initUserInfo];
    });
    
    return userInfoModel;
}

- (void)initUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSDictionary   *dict         = [userDefaults objectForKey:@"userInfo"];
    
    [userInfoModel setFromDictionary:dict];
    
    userInfoModel.isLogined  = [userDefaults boolForKey:@"userLogined"];
}

- (void)setFromDictionary:(NSDictionary *)dict
{
    [super setFromDictionary:dict];
        
    [[NSUserDefaults standardUserDefaults] setObject:[self toDictionary] forKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)updateUserLogin:(BOOL)isLogin{
    userInfoModel.isLogined  = isLogin;
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"userLogined"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setPassword:(NSString *)password{
    [[KSLoginKeyChain sharedInstance] setPassword:password];
}

-(void)setAccountName:(NSString*)accountName{
    [[KSLoginKeyChain sharedInstance] setAccountName:accountName];
}

-(NSString*)getAccountName{
    return [[KSLoginKeyChain sharedInstance] getAccountName];
}

-(NSString*)getPassword{
    return [[KSLoginKeyChain sharedInstance] getPassword];
}

-(void)clearPassword{
    [[KSLoginKeyChain sharedInstance] clear];
}

@end
