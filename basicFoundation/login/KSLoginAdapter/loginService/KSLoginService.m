//
//  KSLoginService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSLoginService.h"
#import "KSLoginComponentItem.h"

@interface KSLoginService()

@property (nonatomic, strong) NSString          *accountName;

@property (nonatomic, strong) NSString          *password;

@end

@implementation KSLoginService

-(void)setupService{
    [super setupService];
}

-(void)loginWithAccountName:(NSString*)accountName password:(NSString*)password{
    if (accountName == nil || password == nil) {
        return;
    }
    self.accountName = accountName;
    self.password = password;
    [self setItemClass:[KSLoginComponentItem class]];
    [self loadItemWithAPIName:login_api_name params:@{@"phone":self.accountName, @"pwd":self.password} version:nil];
}

-(void)logoutWithUserId:(NSString*)userId{
    [[KSLoginComponentItem sharedInstance] updateUserLogin:NO];
}

-(void)sendValidateCodeWithAccountName:(NSString*)accountName{
    if (accountName == nil) {
        return;
    }
    [self loadNumberValueWithAPIName:sendValidateCode_api_name params:@{@"phoneNum":accountName} version:nil];
}

-(void)resetPasswordWithAccountName:(NSString*)accountName oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword{
    if (accountName == nil) {
        accountName = [KSLoginComponentItem sharedInstance].phone;
    }
    if (accountName == nil
        || oldPassword == nil
        || newPassword == nil) {
        return;
    }
    [self loadItemWithAPIName:reset_api_name params:@{@"phone":accountName,@"pwd":oldPassword,@"newPwd":newPassword} version:nil];
}

-(void)registerWithAccountName:(NSString*)accountName password:(NSString*)password userName:(NSString*)userName validateCode:(NSString*)validateCode inviteCode:(NSString*)inviteCode{
    if ([WeAppUtils isEmpty:accountName]
        && [WeAppUtils isEmpty:password]
        && [WeAppUtils isEmpty:validateCode]
        && [WeAppUtils isEmpty:inviteCode]
        && [WeAppUtils isEmpty:userName]) {
        return;
    }
    self.accountName = accountName;
    self.password = password;
    [self setItemClass:[KSLoginComponentItem class]];
    [self loadItemWithAPIName:register_api_name params:@{@"phoneNum":accountName, @"pwd":password, @"validateCode":validateCode, @"code":inviteCode, @"userName":userName} version:nil];
}

-(void)modelDidFinishLoad:(WeAppBasicRequestModel *)model{
    if ([model.apiName isEqualToString:login_api_name]) {
        // 返回成功后记录下登陆账号与密码
        [[KSLoginComponentItem sharedInstance] setPassword:self.password];
        [[KSLoginComponentItem sharedInstance] setAccountName:self.accountName];
        // 更新userInfo信息，更新登陆信息
        [[KSLoginComponentItem sharedInstance] updateUserLogin:YES];
    }else if([model.apiName isEqualToString:logout_api_name]){
        [[KSLoginComponentItem sharedInstance] updateUserLogin:NO];
    }else if ([model.apiName isEqualToString:register_api_name]){
        // 返回成功后记录下登陆账号与密码
        [[KSLoginComponentItem sharedInstance] setPassword:self.password];
        [[KSLoginComponentItem sharedInstance] setAccountName:self.accountName];
    }
    [super modelDidFinishLoad:model];
}

@end
