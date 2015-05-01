//
//  KSScrollViewConfigObject.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-25.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSScrollViewConfigObject : NSObject

@property (nonatomic, assign) BOOL                 needNextPage;
@property (nonatomic, assign) BOOL                 needRefreshView;
@property (nonatomic, assign) BOOL                 needFootView;
@property (nonatomic, assign) BOOL                 needQueueLoadData;

-(void)setupStandConfig;

@end
