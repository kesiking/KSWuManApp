//
//  ManWuDiscoverModel.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/25.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@protocol ManWuDiscoverModel <NSObject>

@end

@interface ManWuDiscoverModel : WeAppComponentBaseItem

@property (nonatomic, strong) NSString*                       parent;
@property (nonatomic, strong) NSString*                       cid;
@property (nonatomic, strong) NSString*                       name;
@property (nonatomic, strong) NSString*                       subTitleText;
@property (nonatomic, strong) NSString*                       img;
@property (nonatomic, strong) NSArray<ManWuDiscoverModel>*    leafCategoryList;

@end
