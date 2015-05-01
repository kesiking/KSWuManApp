//
//  KSCollectionViewConfigObject.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-25.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSScrollViewConfigObject.h"

@interface KSCollectionViewConfigObject : KSScrollViewConfigObject

//如果设置collectionColumn，优先级将高于collectionCellSize的设置，会根据frame控制collectionCellSize的宽度
@property (nonatomic, assign) NSUInteger           collectionColumn;
@property (nonatomic, assign) CGSize               collectionCellSize;
@property (nonatomic, assign) NSUInteger           minimumInteritemSpacing;
@property (nonatomic, assign) NSUInteger           minimumLineSpacing;

@end
