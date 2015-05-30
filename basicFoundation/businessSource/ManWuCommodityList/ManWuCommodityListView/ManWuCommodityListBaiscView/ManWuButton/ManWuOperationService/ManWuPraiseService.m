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
    [self doPraiseWithApiName:@"collection/unAddItem.do" itemId:itemId];
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

@end
