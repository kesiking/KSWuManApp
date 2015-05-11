//
//  KSAdapterNetWork.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterNetWork.h"
#import "AFHTTPRequestOperationManager.h"

@implementation KSAdapterNetWork

-(void)request:(NSString *)apiName withParam:(NSDictionary *)param onSuccess:(NetworkSuccessBlock)successBlock onError:(NetworkErrorBlock)errorBlock onCancel:(NetworkCancelBlock)cancelBlock{
    // 默认为json序列化
    self.needLogin = [param objectForKey:@"needLogin"];
    [self callWithAuthCheck:apiName method:^{
        NSString* path = [NSString stringWithFormat:@"%@%@",DEFAULT_PARH,apiName];
        AFHTTPRequestOperationManager *httpRequestOM = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KS_MANWU_BASE_URL]];
        [httpRequestOM POST:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary* responseDict = (NSDictionary*)responseObject;
                NSString* resultstring = [responseDict objectForKey:@"resultString"];
                NSString* resultcode = [responseDict objectForKey:@"resultCode"];
                if ([resultcode isEqualToString:@"200"]
                    || [resultcode isEqualToString:@"100"]) {
                    successBlock(responseDict);
                }else{
                    if (resultstring == nil) {
                        resultstring = @"连接成功，请求数据不存在";
                    }
                    NSError *error = [NSError errorWithDomain:@"apiRequestErrorDomain" code:[resultcode integerValue] userInfo:@{NSLocalizedDescriptionKey: resultstring}];
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
//        [self.loginService authenticateWithCompletion:^(BOOL succeed)
//         {
//             if (succeed)
//                 callMethod();
//             else if (self.needLogin && errorBlock){
//                 errorBlock(nil);
//             }
//         }];
    }
    else {
        callMethod();
    }
}

@end
