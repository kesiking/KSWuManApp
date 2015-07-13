//
//  KSSafePayUtility.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-29.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSSafePayUtility.h"
#import "DataSigner.h"
#import "DataVerifier.h"
#import "Order.h"


@implementation KSSafePayUtility

static NSDictionary* aliPayFile;
static NSString    * aliPayKey;
static NSString    * aliPayPublicKey;

+(void)initialize{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"aliPayfile" ofType:@"plist"];
    aliPayFile = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    if (aliPayFile == nil) {
        aliPayFile = [[NSDictionary alloc] init];
    }
    aliPayKey = [aliPayFile objectForKey:@"aliPayKey"];
    aliPayPublicKey = [aliPayFile objectForKey:@"aliPayPublicKey"];
}

/*
 * key-value传入
 * 必须包含：tradeNO（订单号），price（价格）
 * 可包含：  productDescription（商品描述），productName（商品标题）
 */
+(void)aliPayForParams:(NSDictionary *)params callbackBlock: (CompletionBlock)callbackBlock{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911272587293";
    NSString *seller = @"hzwuman@126.com";
    
    NSString *privateKey = aliPayKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    NSString* tradeNO = [params objectForKey:@"tradeNO"];
    if (tradeNO == nil) { // 没有订单ID则随机生成一个
        tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    }
    order.tradeNO = tradeNO;
    NSString* productName = [params objectForKey:@"productName"];
    if (productName == nil) { // 没有订单ID则随机生成一个
        productName = @"商品标题"; //订单ID（由商家自行制定）
    }
    order.productName = productName; //商品标题
    NSString* productDescription = [params objectForKey:@"productDescription"];
    if (productDescription == nil) {    // 没有商品描述则用默认
        productDescription = @"商品描述"; // 商品描述
    }
    order.productDescription = productDescription; //商品描述
    NSString* price = [params objectForKey:@"price"];
    if (price == nil) { // 没有价格直接返回
        return;
    }
    order.amount = price; //商品价格

    order.notifyURL =  @"http://115.29.227.64/wuman/order/callbackOrder.do"; //回调URL 服务器异步通知页面路径
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在Info.plist定义URL types
    NSString *appScheme = @"manwualipaysdk";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            BOOL isSuccess = [self processResultStatus:resultDic];
            NSMutableDictionary* resultMutableDict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
            [resultMutableDict setObject:[NSNumber numberWithBool:isSuccess] forKey:@"isSuccess"];
            if (callbackBlock) {
                callbackBlock(resultMutableDict);
            }
        }];
    }
}

+(BOOL)processResultStatus:(NSDictionary*)resultDic{
    int statusCode = [[resultDic objectForKey:@"resultStatus"] intValue];
    NSString* result = [resultDic objectForKey:@"result"];
    NSString* memo = [resultDic objectForKey:@"memo"];
    NSRange range = [result rangeOfString:@"success=\"true\""];
    NSRange signRange = [result rangeOfString:@"sign=\""];
    
    BOOL signSuccess = YES;
    // 用支付宝公钥验证签名
    if (signRange.location != NSNotFound) {
        NSString* sign = [result substringFromIndex:signRange.location + signRange.length];
        signRange = [sign rangeOfString:@"\""];
        if (signRange.location != NSNotFound) {
            [sign substringToIndex:signRange.location];
        }
        NSString* message = [NSString string];
        id<DataVerifier> verifier = CreateRSADataVerifier(aliPayPublicKey);
//        signSuccess = [verifier verifyString:message withSign:sign];
    }
    
    //是否支付成功
    if (9000 == statusCode/* && range.location != NSNotFound && signSuccess*/) {
        [WeAppToast toast:@"支付成功"];
        return YES;
    }else if(8000 == statusCode){
        [WeAppToast toast:@"正在处理中，请稍等"];
    }else if(6002 == statusCode){
        [WeAppToast toast:@"请检查网路连接"];
    }else if(6001 == statusCode){
        [WeAppToast toast:@"支付取消"];
    }else{
        [WeAppToast toast:@"支付失败"];
    }
    
    return NO;
}

#pragma mark -
#pragma mark   ==============产生随机订单号==============


+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
