//
//  ManWuAddressEditView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "ManWuAddressInfoModel.h"
#import "ManWuAddressManagerMaroc.h"

@interface ManWuAddressEditView : KSView

@property (nonatomic,strong) addressDidChangeBlock  addressDidChangeBlock;

@property (nonatomic,strong) ManWuAddressInfoModel *addressInfoModel;

@end
