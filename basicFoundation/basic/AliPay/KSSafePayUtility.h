//
//  KSSafePayUtility.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-29.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

@interface KSSafePayUtility : NSObject

/*
 * key-value传入
 * 必须包含：tradeNO（订单号），price（价格）
 * 可包含：  productDescription（商品描述），productName（商品标题）
 */
+(void)aliPayForParams:(NSDictionary *)params callbackBlock: (CompletionBlock)callbackBlock;

@end
