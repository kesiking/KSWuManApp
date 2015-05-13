//
//  ManWuAddressManagerListView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "KSTableViewController.h"
#import "ManWuAddressInfoModel.h"
#import "ManWuAddressManagerMaroc.h"

@interface ManWuAddressManagerListView : KSView{
    KSTableViewController* _collectionViewCtl;
}

@property (nonatomic,strong) KSTableViewController* collectionViewCtl;

@property (nonatomic,strong) addressDidChangeBlock  addressDidChangeBlock;

@end
