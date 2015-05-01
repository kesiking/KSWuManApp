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
}

@end
