//
//  ManWuFavService.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuFavService.h"

@implementation ManWuFavService

-(void)addFavorateWithItemId:(NSString*)itemId{
    [self doFavorateWithApiName:@"user/addItem.do" itemId:itemId];
}

-(void)unAddFavorateWithItemId:(NSString*)itemId{
    [self doFavorateWithApiName:@"user/unAddItem.do" itemId:itemId];
}

-(void)doFavorateWithApiName:(NSString*)apiName itemId:(NSString*)itemId{
    if (itemId == nil) {
        return;
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:@"store" forKey:@"action"];
    [params setObject:itemId forKey:@"itemId"];
    
    if ([KSAuthenticationCenter userId]) {
        [params setObject:[KSAuthenticationCenter userId] forKey:@"userId"];
    }
    
    [self loadItemWithAPIName:apiName params:params version:nil];
}

@end
