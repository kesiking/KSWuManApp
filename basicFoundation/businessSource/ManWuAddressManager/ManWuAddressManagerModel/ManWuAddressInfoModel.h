//
//  ManWuAddressInfoModel.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@interface ManWuAddressInfoModel : WeAppComponentBaseItem

@property(nonatomic,assign) BOOL            isDefaultAddress;

@property(nonatomic,strong) NSString*       addressDetail;

@property(nonatomic,strong) NSString*       phoneNum;

@end
