//
//  ManWuPraiseService.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuPraiseService.h"

@implementation ManWuPraiseService

-(void)addPraiseWithItemId:(NSString*)itemId{
    [self doPraiseWithApiName:@"collection/addItem.do" itemId:itemId];
}

-(void)unAddPraiseWithItemId:(NSString*)itemId{
    if (itemId == nil) {
        return;
    }
    [self unAddPraiseWithItemIds:@[itemId]];
//    [self doPraiseWithApiName:@"collection/unAddItem.do" itemId:itemId];
}

-(void)unAddPraiseWithItemIds:(NSArray*)itemIds{
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
    [params setObject:@"praise" forKey:@"action"];
    [params setObject:[itemIdStr URLEncodedString] forKey:@"itemIds"];
    [params setObject:@1 forKey:@"__unNeedEncode__"];
    
    if ([KSAuthenticationCenter userId]) {
        [params setObject:[KSAuthenticationCenter userId] forKey:@"userId"];
    }
    
    self.needLogin = YES;
    
    [self loadItemWithAPIName:@"collection/unAddItem.do" params:params version:nil];
}

-(void)doPraiseWithApiName:(NSString*)apiName itemId:(NSString*)itemId{
    if (itemId == nil) {
        [WeAppToast toast:@"没有宝贝信息"];
        return;
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:@"praise" forKey:@"action"];
    [params setObject:itemId forKey:@"itemId"];
    
    if ([KSAuthenticationCenter userId]) {
        [params setObject:[KSAuthenticationCenter userId] forKey:@"userId"];
    }
    
    self.needLogin = YES;
    
    [self loadItemWithAPIName:apiName params:params version:nil];
}

-(void)modelDidFinishLoad:(WeAppBasicRequestModel *)model{
    if ([model.apiName isEqualToString:@"collection/addItem.do"]) {
        // 发送赞成功消息
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserAddPraiseSuccessNotification object:nil userInfo:model.params];
    }else if ([model.apiName isEqualToString:@"collection/unAddItem.do"]){
        // 发送赞取消消息
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserUnAddPraiseSuccessNotification object:nil userInfo:model.params];
    }
    [super modelDidFinishLoad:model];
}

@end
