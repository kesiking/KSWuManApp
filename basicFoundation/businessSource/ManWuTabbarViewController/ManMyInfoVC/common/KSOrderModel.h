//
//  KSOrderModel.h
//  basicFoundation
//
//  Created by 许学 on 15/5/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSOrderModel : NSObject

@property (nonatomic,strong) NSString* orderId;
@property (nonatomic,strong) NSString* productId;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* imgUrl;
@property (nonatomic,strong) NSString* basicInfo;
@property (nonatomic,strong) NSString* price;
@property (nonatomic,strong) NSString* realPrice;
@property (nonatomic,strong) NSString* recvName;
@property (nonatomic,strong) NSString* phoneNum;
@property (nonatomic,strong) NSString* address;
@property (nonatomic,strong) NSString* expressName;
@property (nonatomic,strong) NSString* expressPrice;
@property (nonatomic,strong) NSString* discount;
@property (nonatomic,strong) NSString* expressNum;
@property (nonatomic,strong) NSString* orderTime;
@property (nonatomic,strong) NSString* state;

@end
