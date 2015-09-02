//
//  ServerMacro.h
//  GuangguangDemo
//
//  Created by zws on 6/30/14.
//  Copyright (c) 2014 ICSCN. All rights reserved.
//

#ifndef GuangguangDemo_ServerMacro_h
#define GuangguangDemo_ServerMacro_h

#import "KSAdapterService.h"
#import "ManWuBasicModel.h"
#import "KSAuthenticationCenter.h"

#define CategoryNeedCache

#define DEFAULT_SCHEME @"http"
#define DEFAULT_HOST @"115.29.227.64"
#define DEFAULT_PORT @"8080"
#define DEFAULT_PARH @"wuman/"
#define KS_MANWU_BASE_URL [NSString stringWithFormat:@"%@://%@/",DEFAULT_SCHEME,DEFAULT_HOST]

#define defaultSortKey @"1"

#define defaultCidKey @"0"

#define defaultActIdKey @"0"

#define WriteTag 1
#define ReadTag 2

#define DEFAULT_LOGIN_HEAD @{@"CMD":@"LOGIN_REQ",@"VERSION":@"V1.0",@"FLOWID":@"12",@"CHKSUM":@"123",@"LENGTH":@"111",@"CLIENTNO":@"112"}  //登录请求头

#define DEFAULT_GET_USERINFO_REQ_HEAD   //个人资料查询

#define DEFAULT_MODIFY_USERINFO_REQ_HEAD  //个人资料修改请求

#define KEYCHAIN_USER_ACOUNT @"Account Number" //这个值换成其他的程序会出错
#define KEYCHAIN_USER_PASSWORD @"Password"     //这个值换成其他的程序会出错
#define KEYCHAIN_GROUP nil

#endif
