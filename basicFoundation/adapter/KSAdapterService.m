//
//  KSAdapterService.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"
#import "KSAdapterNetWork.h"

@implementation KSAdapterService

-(instancetype)init{
    if (self = [super init]) {
        [self setupService];
    }
    return self;
}

-(void)setupService{
    KSAdapterNetWork* network = [[KSAdapterNetWork alloc] init];
    [self setNetwork:network];
}

@end
