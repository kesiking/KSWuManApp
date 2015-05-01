//
//  TBDetailJumpUrlUtil.h
//  TBDetailViewSDK
//
//  Created by chen shuting on 15/1/28.
//  Copyright (c) 2015年 zhangtianshun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBDetailModel.h"

@interface TBDetailJumpUrlUtil : NSObject

+(NSString *)getGotoShopCategoryUrl:(TBDetailSellerModel *)sellerModel;

+(NSString *)getGotoAllItemsUrl:(TBDetailSellerModel *)sellerModel;

+(NSString *)getGotoShopUrl:(TBDetailSellerModel *)sellerModel;

/**
 *  将使用通配符的url转化成可跳转的URL
 *
 *  @param url         url基类
 *  @param urlParams   url参数
 *  @param replaceDic  详情数据结构
 *
 *  @return url
 */
+(NSString *)translateUrlFromTemplate:(NSString *)url
                            urlParams:(NSDictionary *)urlParams
                           replaceDic:(NSDictionary *)replaceDic;

@end
