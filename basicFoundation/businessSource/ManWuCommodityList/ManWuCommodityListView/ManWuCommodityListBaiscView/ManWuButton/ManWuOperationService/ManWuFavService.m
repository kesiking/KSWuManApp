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
    [self doFavorateWithApiName:@"collection/addItem.do" itemId:itemId];
}

-(void)unAddFavorateWithItemId:(NSString*)itemId{
    if (itemId == nil) {
        return;
    }
    [self unAddFavorateWithItemIds:@[itemId]];
//    [self doFavorateWithApiName:@"collection/unAddItem.do" itemId:itemId];
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
    
    self.needLogin = YES;
    
    [self loadItemWithAPIName:apiName params:params version:nil];
}

-(void)unAddFavorateWithItemIds:(NSArray*)itemIds{
    if (itemIds == nil || [itemIds count] == 0) {
        return;
    }
    NSMutableString* itemIdStr = [NSMutableString string];
    
    NSUInteger count = [itemIds count];
    
    for (NSString* itemId in itemIds) {
        if (itemId == nil || ![itemId isKindOfClass:[NSString class]]) {
            continue;
        }
        [itemIdStr appendString:itemId];
        NSUInteger index = [itemIds indexOfObject:itemId];
        if (index < count - 1) {
            [itemIdStr appendString:@","];
        }
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:@"store" forKey:@"action"];
    [params setObject:[itemIdStr URLEncodedString] forKey:@"itemIds"];
    [params setObject:@1 forKey:@"__unNeedEncode__"];
    
    if ([KSAuthenticationCenter userId]) {
        [params setObject:[KSAuthenticationCenter userId] forKey:@"userId"];
    }
    
    self.needLogin = YES;
    
    [self loadItemWithAPIName:@"collection/unAddItem.do" params:params version:nil];
}

-(void)modelDidFinishLoad:(WeAppBasicRequestModel *)model{
    if ([model.apiName isEqualToString:@"collection/addItem.do"]) {
        // 发送收藏成功消息
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserAddFavSuccessNotification object:nil userInfo:model.params];
    }else if ([model.apiName isEqualToString:@"collection/unAddItem.do"]){
        // 发送收藏取消消息
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserUnAddFavSuccessNotification object:nil userInfo:model.params];
    }
    [super modelDidFinishLoad:model];
}

@end
