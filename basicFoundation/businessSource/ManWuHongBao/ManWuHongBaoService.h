//
//  ManWuHongBaoService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"

@interface ManWuHongBaoService : KSAdapterService

-(void)loadVoucherDataWithVoucherId:(NSString*)voucherId;

@end
