//
//  KSLoginComponentItem.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@interface KSLoginComponentItem : WeAppComponentBaseItem

@property (nonatomic,strong) NSString* email;
@property (nonatomic,strong) NSString* imgUrl;
@property (nonatomic,strong) NSString* inviteCode;
@property (nonatomic,strong) NSString* phone;
@property (nonatomic,strong) NSString* userName;
@property (nonatomic,strong) NSString* userId;
@property (nonatomic,strong) NSString* sex;
@property (nonatomic,assign) BOOL isLogined;

+(KSLoginComponentItem *)sharedInstance;

-(void)updateUserInfo:(NSDictionary*)userInfo;

-(void)updateUserLogin:(BOOL)isLogin;

-(void)setPassword:(NSString *)password;

-(void)setAccountName:(NSString*)accountName;

-(NSString*)getAccountName;

-(NSString*)getPassword;

-(void)clearPassword;

@end
