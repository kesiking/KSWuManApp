//
//  KSRedPacketModel.h
//  basicFoundation
//
//  Created by 许学 on 15/7/1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSRedPacketModel : WeAppComponentBaseItem

@property (nonatomic, strong) NSString *redpacektId;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *status;  //正常0，已使用1，已过期2
@property (nonatomic, strong) NSString *desc;

@end
