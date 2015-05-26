//
//  ManWuAddressInfoModel.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@interface ManWuAddressInfoModel : WeAppComponentBaseItem

@property(nonatomic,strong) NSString*       address;

@property(nonatomic,strong) NSString*       phoneNum;

@property(nonatomic,strong) NSString*       recvName;

@property(nonatomic,strong) NSString*       addressId;

@property(nonatomic,assign) BOOL            defaultAddress;

@end
