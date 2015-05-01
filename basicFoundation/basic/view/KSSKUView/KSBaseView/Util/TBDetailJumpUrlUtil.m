//
//  TBDetailJumpUrlUtil.m
//  TBDetailViewSDK
//
//  Created by chen shuting on 15/1/28.
//  Copyright (c) 2015年 zhangtianshun. All rights reserved.
//

#import "TBDetailJumpUrlUtil.h"
#import "NSStringHelper.h"

@implementation TBDetailJumpUrlUtil

+(NSString *)getGotoShopCategoryUrl:(TBDetailSellerModel *)sellerModel
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:sellerModel.userNumId forKey:@"user_id"];
    [params setValue:sellerModel.shopId forKey:@"shop_id"];
    [params setValue:@"1" forKey:@"gotoSearch"];
    [params setValue:@"1" forKey:@"expandSecCat"];
    NSString *shopUrl = @"http://shop.m.taobao.com/category/index.htm";
    
    return [NSStringHelper tbStringByAddingURLEncodedQueryDictionary:params sourceString:shopUrl];
}

+(NSString *)getGotoAllItemsUrl:(TBDetailSellerModel *)sellerModel
{
    return [NSString stringWithFormat:@"http://shop.m.taobao.com/goods/index.htm?shop_id=%@", sellerModel.shopId];
}

+(NSString *)getGotoShopUrl:(TBDetailSellerModel *)sellerModel
{
    return [NSString stringWithFormat:@"http://shop.m.taobao.com/shop/shop_index.htm?user_id=%@", sellerModel.userNumId];
}

+ (NSString *)translateUrlFromTemplate:(NSString *)url
                             urlParams:(NSDictionary *)urlParams
                            replaceDic:(NSDictionary *)replaceDic
{
    if (url == nil || urlParams == nil || replaceDic == nil) {
        return url;
    }
    
    NSMutableDictionary *urlDic = [NSMutableDictionary dictionary];
    NSString *regex = @"#\\{[A-Z0-9a-z]+\\}";
    
    for (NSString *key in urlParams) {
        NSString *data = urlParams[key];
        NSRange range = [data rangeOfString:regex options:NSRegularExpressionSearch];
        if (range.location != NSNotFound && range.length > 3) {
            NSString *searchKey = [data substringWithRange:NSMakeRange(range.location + 2, range.length - 3)];
            if ([replaceDic objectForKey:searchKey]) {
                [urlDic setObject:replaceDic[searchKey]
                           forKey:key];
            }
        } else {
            [urlDic setObject:data forKey:key];
        }
    }
    
    return [NSStringHelper tbStringByAddingURLEncodedQueryDictionary:urlDic sourceString:url];
}

@end
