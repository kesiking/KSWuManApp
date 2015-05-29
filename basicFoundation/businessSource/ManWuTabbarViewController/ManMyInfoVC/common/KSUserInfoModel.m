//
//  KSUserInfoModel.m
//  basicFoundation
//
//  Created by 许学 on 15/5/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSUserInfoModel.h"

@implementation KSUserInfoModel

static KSUserInfoModel *userInfoModel=nil;

+(KSUserInfoModel *)sharedConstant{
    
    if (!userInfoModel) {
        userInfoModel=[[KSUserInfoModel alloc] init];
    }
    [userInfoModel initUserInfo];
    return userInfoModel;
}

- (void)initUserInfo
{
    if([[NSFileManager defaultManager]fileExistsAtPath:[LOGIN_FLAG filePathOfCaches]])
        userInfoModel.isLogined = YES;
    else
        userInfoModel.isLogined = NO;
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *dict=[userDefaults objectForKey:@"userInfo"];
    userInfoModel.userId = dict[@"userId"];
    userInfoModel.userName = dict[@"userName"];
    userInfoModel.phone = dict[@"phone"];
    userInfoModel.imgUrl = dict[@"imgUrl"];
    userInfoModel.email = dict[@"email"];
    userInfoModel.inviteCode = dict[@"inviteCode"];
    userInfoModel.sex = dict[@"sex"];
}

@end
