//
//  ManWuAddressEditService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/26.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"

@interface ManWuAddressEditService : KSAdapterService

-(void)editAddressInfoWithAddressId:(NSString *)addressId userId:(NSString *)userId recvName:(NSString *)recvName phoneNum:(NSString *)phoneNum address:(NSString *)address defaultAddress:(BOOL)defaultAddress;

-(void)deleteAddressInfoWithAddressId:(NSString *)addressId;

@end
