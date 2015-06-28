//
//  ManWuPraiseService.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"

#define kUserAddPraiseSuccessNotification @"userAddPraiseSuccessNotification"
#define kUserUnAddPraiseSuccessNotification @"userUnAddPraiseSuccessNotification"

@interface ManWuPraiseService : KSAdapterService

-(void)addPraiseWithItemId:(NSString*)itemId;

-(void)unAddPraiseWithItemId:(NSString*)itemId;

@end
