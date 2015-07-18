//
//  ManWuFavService.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"

#define kUserAddFavSuccessNotification @"userAddFavSuccessNotification"
#define kUserUnAddFavSuccessNotification @"userUnAddFavSuccessNotification"

@interface ManWuFavService : KSAdapterService

-(void)addFavorateWithItemId:(NSString*)itemId;

-(void)unAddFavorateWithItemId:(NSString*)itemId;

-(void)unAddFavorateWithItemIds:(NSArray*)itemIds;

@end
