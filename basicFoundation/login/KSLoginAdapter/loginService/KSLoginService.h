//
//  KSLoginService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"

#define login_api_name            @"user/login.do"

#define logout_api_name           @"user/logout.do"

#define register_api_name         @"user/register.do"

#define reset_api_name            @"user/reset.do"

#define modifyPwd_api_name        @"user/modifyPwd.do"

#define sendValidateCode_api_name @"user/sendValidateCode.do"

@interface KSLoginService : KSAdapterService

-(void)loginWithAccountName:(NSString*)accountName password:(NSString*)password;

-(void)logoutWithUserId:(NSString*)userId;

-(void)sendValidateCodeWithAccountName:(NSString*)accountName;

-(void)resetPasswordWithAccountName:(NSString*)accountName validateCode:(NSString*)validateCode newPassword:(NSString*)newPassword;

-(void)modifyPasswordWithAccountName:(NSString*)accountName oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword;

-(void)registerWithAccountName:(NSString*)accountName password:(NSString*)password userName:(NSString*)userName validateCode:(NSString*)validateCode inviteCode:(NSString*)inviteCode;

@end
