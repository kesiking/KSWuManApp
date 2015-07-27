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

static NSString* rsaPasswordKey = nil;

+(void)initialize{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"aliPayfile" ofType:@"plist"];
    NSDictionary* aliPayFile = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    if (aliPayFile == nil) {
        aliPayFile = [[NSDictionary alloc] init];
    }
    rsaPasswordKey = [aliPayFile objectForKey:@"passwordKey1"];
}

-(void)request:(NSString *)apiName withParam:(NSDictionary *)param onSuccess:(NetworkSuccessBlock)successBlock onError:(NetworkErrorBlock)errorBlock onCancel:(NetworkCancelBlock)cancelBlock{
    
    BOOL hasMockData = [self didLoadDataFromMockWithApiName:apiName withParam:param onSuccess:successBlock onError:errorBlock onCancel:cancelBlock];
    
    if (hasMockData) {
        return;
    }
    
    // 检查是否需要登陆
    self.needLogin = [param objectForKey:@"needLogin"];
    // 统一调用登陆逻辑
    [self callWithAuthCheck:apiName method:^{
        NSString* path = [NSString stringWithFormat:@"%@%@",DEFAULT_PARH,apiName];
        // 默认为json序列化
        
        AFHTTPRequestOperationManager *httpRequestOM = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KS_MANWU_BASE_URL]];
        
        // 获取加密
        NSMutableDictionary* newParams = [self getEncodeParamWithParam:param];
        NSString* method = [newParams objectForKey:@"__METHOD__"];
#ifdef METHOD_GET
        method = @"GET";
#endif
        [self preProccessParamWithParam:newParams];
        
        // 获取successCompleteBlock
        void(^successCompleteBlock)(AFHTTPRequestOperation *operation, id responseObject) = [self getSuccessCompleteBlockWithApiName:apiName onSuccess:successBlock onError:errorBlock onCancel:cancelBlock];
        
        // 获取errorCompleteBlock
        void(^errorCompleteBlock)(AFHTTPRequestOperation *operation, NSError *error) = [self getErrorCompleteBlockWithApiName:apiName onSuccess:successBlock onError:errorBlock onCancel:cancelBlock];
        
        if ([method isEqualToString:@"GET"]) {
            [httpRequestOM GET:path parameters:newParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (successCompleteBlock) {
                    successCompleteBlock(operation, responseObject);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (errorCompleteBlock) {
                    errorCompleteBlock(operation, error);
                }
            }];
        }else{
            [httpRequestOM POST:path parameters:newParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (successCompleteBlock) {
                    successCompleteBlock(operation, responseObject);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (errorCompleteBlock) {
                    errorCompleteBlock(operation, error);
                }
            }];
        }
    } onError:errorBlock];
}

-(BOOL)didLoadDataFromMockWithApiName:(NSString *)apiName withParam:(NSDictionary *)param onSuccess:(NetworkSuccessBlock)successBlock onError:(NetworkErrorBlock)errorBlock onCancel:(NetworkCancelBlock)cancelBlock{
#ifdef MOCKDATA
    NSString* jsonData = [[KSNetworkDataMock sharedInstantce] getJsonDataWithKey:apiName];
    if (jsonData) {
        NSError* error = nil;
        NSData *data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (responseDict) {
            successBlock(responseDict);
            return YES;
        }
    }
#endif
    return NO;
}

-(void(^)(AFHTTPRequestOperation *operation, id responseObject))getSuccessCompleteBlockWithApiName:(NSString *)apiName onSuccess:(NetworkSuccessBlock)successBlock onError:(NetworkErrorBlock)errorBlock onCancel:(NetworkCancelBlock)cancelBlock{
    return ^void(AFHTTPRequestOperation *operation, id responseObject){
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
    };
}

-(void(^)(AFHTTPRequestOperation *operation, NSError *error))getErrorCompleteBlockWithApiName:(NSString *)apiName onSuccess:(NetworkSuccessBlock)successBlock onError:(NetworkErrorBlock)errorBlock onCancel:(NetworkCancelBlock)cancelBlock{
    return ^void(AFHTTPRequestOperation *operation, NSError *error){
        NSMutableDictionary* errorDic = [NSMutableDictionary dictionary];
        if (error) {
            [errorDic setObject:error forKey:@"responseError"];
        }
        errorBlock(errorDic);
    };
}

-(NSMutableDictionary*)getEncodeParamWithParam:(NSDictionary*)param{
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
    return newParams;
}

-(void)preProccessParamWithParam:(NSMutableDictionary*)newParams{
    
    if (![newParams objectForKey:@"userId"] && [KSAuthenticationCenter userId]) {
        [newParams setObject:[KSAuthenticationCenter userId] forKey:@"userId"];
    }
    // 接口加密校验参数
    /*!
     *  @author 孟希羲, 15-07-19 15:07:43
     *
     *  @brief  接口加密校验参数
     *
     *  @since 1.0
     */
    static NSDateFormatter *inputFormatter = nil;
    
    if (inputFormatter == nil) {
        inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    }
    
    NSString* requestTime = [NSString stringWithFormat:@"%@",[inputFormatter stringFromDate:[NSDate date]]];
    NSMutableString* signStr = [NSMutableString string];
    NSArray* allKeys =  [newParams allKeys];
    for (NSString* key in allKeys) {
        id value = [newParams objectForKey:key];
        [signStr appendString:key];
        [signStr appendString:@"="];
        [signStr appendString:[NSString stringWithFormat:@"%@",value]];
        [signStr appendString:@"&"];
    }
    [signStr appendString:@"time"];
    [signStr appendString:@"="];
    [signStr appendString:requestTime];
    
    if (requestTime) {
        [newParams setObject:requestTime forKey:@"time"];
    }

    NSString *requestTimeRSA = [RSAEncrypt encryptString:signStr publicKey:rsaPasswordKey];
    [newParams setObject:[requestTimeRSA tbUrlEncoded] forKey:@"sign"];
    /****************************/
    // 删除不必要的参数
    [newParams removeObjectForKey:@"needLogin"];
    [newParams removeObjectForKey:@"__unNeedEncode__"];
    [newParams removeObjectForKey:@"__METHOD__"];
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
