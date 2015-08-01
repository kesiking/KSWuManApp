//
//  ManWuCommodityListView.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-24.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSCollectionViewController.h"

@interface ManWuCommodityListView : KSView{
    KSCollectionViewController* _collectionViewCtl;
}

@property (nonatomic,strong) KSCollectionViewController* collectionViewCtl;

-(void)setCollectionService:(KSAdapterService *)service;

-(KSAdapterService*)getCollectionService;

-(void)setupCollectionViewConfigObject:(KSCollectionViewConfigObject*)configObject;

@end
