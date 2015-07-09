//
//  KSAdapterNetWork.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterNetWork.h"
#import "AFHTTPRequestOperationManager.h"
#import "KSAuthenticationCenter.h"
#import "KSNetworkDataMock.h"

//#define MOCKDATA

@implementation KSAdapterNetWork

-(void)request:(NSString *)apiName withParam:(NSDictionary *)param onSuccess:(NetworkSuccessBlock)successBlock onError:(NetworkErrorBlock)errorBlock onCancel:(NetworkCancelBlock)cancelBlock{
    
#ifdef MOCKDATA
    NSString* jsonData = [[KSNetworkDataMock sharedInstantce] getJsonDataWithKey:apiName];
    if (jsonData) {
        NSError* error = nil;
        NSData *data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (responseDict) {
            successBlock(responseDict);
            return;
        }
    }
#endif
    // 检查是否需要登陆
    self.needLogin = [param objectForKey:@"needLogin"];
    // 统一调用登陆逻辑
    [self callWithAuthCheck:apiName method:^{
        NSMutableDictionary* newParams = nil;

        if (param) {
            BOOL unNeedEncode = [param objectForKey:@"__unNeedEncode__"];
            if (!unNeedEncode) {
                newParams = [NSMutableDictionary dictionary];
                for (NSString* key in [param allKeys]) {
                    id value = [param objectForKey:key];
                    if ([value isKindOfClass:[NSString class]]) {
                        [newParams setObject:[(NSString*)value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:key];
                    }else{
                        [newParams setObject:value forKey:key];
                    }
                }
            }else{
                newParams = [NSMutableDictionary dictionaryWithDictionary:param];
            }
        }
        if (self.needLogin && ![newParams objectForKey:@"userId"] && [KSAuthenticationCenter userId]) {
            [newParams setObject:[KSAuthenticationCenter userId] forKey:@"userId"];
        }
        
        [newParams removeObjectForKey:@"needLogin"];
        [newParams removeObjectForKey:@"__unNeedEncode__"];
        NSString* path = [NSString stringWithFormat:@"%@%@",DEFAULT_PARH,apiName];
        // 默认为json序列化
        AFHTTPRequestOperationManager *httpRequestOM = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KS_MANWU_BASE_URL]];
        [httpRequestOM POST:path parameters:newParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary* responseDict = (NSDictionary*)responseObject;
                NSString* resultstring = [responseDict objectForKey:@"resultString"];
                NSString* resultcode = [responseDict objectForKey:@"resultCode"];
                NSString* resultApiName = apiName;
                if ([resultcode isEqualToString:@"100"]) {
                    successBlock(responseDict);
                }else{
                    if (resultstring == nil) {
                        resultstring = @"连接成功，请求数据不存在";
                    }
                    NSError *error = [NSError errorWithDomain:@"apiRequestErrorDomain" code:[resultcode integerValue] userInfo:@{NSLocalizedDescriptionKey: resultstring,@"apiName":resultApiName?:@""}];
                    NSMutableDictionary* errorDic = [NSMutableDictionary dictionary];
                    if (error) {
                        [errorDic setObject:error forKey:@"responseError"];
                    }
                    errorBlock(errorDic);
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSMutableDictionary* errorDic = [NSMutableDictionary dictionary];
            if (error) {
                [errorDic setObject:error forKey:@"responseError"];
            }
            errorBlock(errorDic);
        }];
    } onError:errorBlock];
}

// 判断是否需要登陆才能操作，如果需要登陆，则先登陆，登陆成功后在回调接口；否则直接访问
-(void)callWithAuthCheck:(NSString*) apiName method:(CallMethod)callMethod onError:(NetworkErrorBlock)errorBlock{
    
    if (self.needLogin)
    {
        [[KSAuthenticationCenter sharedCenter] authenticateWithLoginActionBlock:^(BOOL loginSuccess) {
            if (loginSuccess)
                callMethod();
            else if (self.needLogin && errorBlock){
                NSDictionary* errorDic = [self getLoginErrorDict];
                errorBlock(errorDic);
            }
        } cancelActionBlock:^{
            if (errorBlock) {
                NSDictionary* errorDic = [self getLoginErrorDict];
                errorBlock(errorDic);
            }
        }];
    }
    else {
        callMethod();
    }
}

-(NSMutableDictionary*)getLoginErrorDict{
    NSError* error = [NSError errorWithDomain:loginFailDomain code:loginFailCode userInfo:nil];
    NSMutableDictionary* errorDic = [NSMutableDictionary dictionary];
    if (error) {
        [errorDic setObject:error forKey:@"responseError"];
    }
    return errorDic;
}

@end
