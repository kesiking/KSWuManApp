//
//  TBDetailSKUInfo.m
//  TBTradeSDK
//
//  Created by neo on 14-1-23.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "TBDetailSKUInfo.h"

@implementation TBDetailSKUInfo

- (NSDictionary *)enableMap{
    if (_enableMap == nil) {
        _enableMap = [NSMutableDictionary dictionary];
    }
    return _enableMap;
}

@end
