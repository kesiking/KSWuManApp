//
//  KSUserInfoModel.h
//  basicFoundation
//
//  Created by 许学 on 15/5/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSUserInfoModel : WeAppComponentBaseItem

@property (nonatomic,strong) NSString* email;
@property (nonatomic,strong) NSString* imgUrl;
@property (nonatomic,strong) NSString* inviteCode;
@property (nonatomic,strong) NSString* phone;
@property (nonatomic,strong) NSString* userName;
@property (nonatomic,strong) NSString* userId;
@property (nonatomic,strong) NSString* sex;
@property (nonatomic,assign) BOOL isLogined;


+(KSUserInfoModel *)sharedConstant;

- (void)updateUserInfo:(NSDictionary *)userInfoDic;

@end
