//
//  KSCollectionViewConfigObject.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-25.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSCollectionViewConfigObject.h"

@implementation KSCollectionViewConfigObject

-(void)setupStandConfig{
    [super setupStandConfig];
    self.minimumInteritemSpacing = 8;
    self.minimumLineSpacing = 4;
    self.collectionColumn = 2;
}

@end
