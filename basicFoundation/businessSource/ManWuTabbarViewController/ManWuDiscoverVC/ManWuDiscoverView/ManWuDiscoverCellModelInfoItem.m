//
//  ManWuDiscoverCellModelInfoItem.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiscoverCellModelInfoItem.h"
#import "ManWuDiscoverModel.h"

@implementation ManWuDiscoverCellModelInfoItem

// 配置初始化KSCellModelInfoItem，在modelInfoItem中可以配置cell需要的参数
-(void)setupCellModelInfoItemWithComponentItem:(WeAppComponentBaseItem*)componentItem{
    /*
     * 注释 mock
    NSMutableArray* arrayData = [[NSMutableArray alloc] init];
    NSUInteger count = rand()%12;
    if (count == 0) {
        count = 3;
    }
    for (int i = 0; i < count ; i++) {
        WeAppComponentBaseItem* component = [[WeAppComponentBaseItem alloc] init];
        [arrayData addObject:component];
    }
    self.discoverCollectionArray = arrayData;
    self.discoverCollectionHeight = (count / 4 + (NSUInteger)(count % 4 == 0 ? 0 : 1))*73;
     */
    ManWuDiscoverModel* discoverModel = (ManWuDiscoverModel*)componentItem;
    NSUInteger count = [discoverModel.leafCategoryList count];
    if (count > 0) {
        self.discoverCollectionArray = discoverModel.leafCategoryList;
        self.discoverCollectionHeight = (count / 4 + (NSUInteger)(count % 4 == 0 ? 0 : 1)) * 73;
    }
    
    self.frame = CGRectMake(0, 0, 320, self.discoverCollectionHeight + 40);
}

@end
