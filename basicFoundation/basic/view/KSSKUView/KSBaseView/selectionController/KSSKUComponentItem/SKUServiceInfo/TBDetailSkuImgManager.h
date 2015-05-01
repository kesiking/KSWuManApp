//
//  TBDetailSkuImgManager.h
//  TBTradeSDK
//
//  Created by neo on 14-1-24.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBDetailSKUModelAndService.h"
#import "TBTradeDetailSKUService.h"

@interface TBDetailSkuImgManager : NSObject

- (id)initWithDetailResult:(TBDetailSKUModelAndService *) tbDetailModel;

- (void)resetTBDetailModel:(TBDetailSKUModelAndService *) tbDetailModel;

- (void)getSkuPicSelected:(TBDetailPidVidPair *) pair;

- (void)getSkuPicUnSelected:(TBDetailPidVidPair *) pair;

- (NSString *)selectPic;

@end
