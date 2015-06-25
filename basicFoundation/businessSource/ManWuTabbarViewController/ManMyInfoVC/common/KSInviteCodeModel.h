//
//  KSInviteCodeModel.h
//  basicFoundation
//
//  Created by 许学 on 15/6/23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@interface KSInviteCodeModel : WeAppComponentBaseItem

@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *inviteCode;
@property (nonatomic, strong) NSString *description;

@end
