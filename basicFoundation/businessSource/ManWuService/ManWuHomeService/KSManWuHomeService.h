//
//  KSManWuHomeService.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"
#import "ManWuHomeActivityInfoModel.h"
#import "ManWuHomeAdvertisementModel.h"
#import "ManWuHomeVoucherModel.h"

@interface KSManWuHomeService : KSAdapterService

-(void)loadHomeActivityData;

-(void)loadBannerVoucherData;

-(void)loadAdvertisementsData;

@end
