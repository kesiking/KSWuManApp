//
//  ManWuAddressManagerListView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "KSTableViewController.h"
#import "ManWuAddressInfoModel.h"

typedef void(^addressSelectBlock) (ManWuAddressInfoModel* addressComponentItem);

@interface ManWuAddressSelectListView : KSView{
    KSTableViewController* _collectionViewCtl;
}

@property (nonatomic,strong) KSTableViewController* collectionViewCtl;

@property (nonatomic,strong) addressSelectBlock     addressSelectBlock;

@end
