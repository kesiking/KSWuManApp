//
//  ManWuAddressService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/26.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"
#import "ManWuAddressInfoModel.h"

@interface ManWuAddressService : KSAdapterService

-(void)loadAddressList;

-(void)loadDefaultAddress;

@end
