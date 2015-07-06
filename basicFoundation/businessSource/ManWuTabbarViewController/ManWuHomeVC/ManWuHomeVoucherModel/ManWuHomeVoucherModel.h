//
//  ManWuHomeVoucherModel.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@interface ManWuHomeVoucherModel : WeAppComponentBaseItem

@property (nonatomic, strong) NSNumber*                       voucherId;
@property (nonatomic, strong) NSString*                       picUrl;
@property (nonatomic, strong) NSString*                       activityTime;
@property (nonatomic, strong) NSString*                       activityRule;
@property (nonatomic, strong) NSString*                       useRange;
@property (nonatomic, assign) NSUInteger                      type;

@end
