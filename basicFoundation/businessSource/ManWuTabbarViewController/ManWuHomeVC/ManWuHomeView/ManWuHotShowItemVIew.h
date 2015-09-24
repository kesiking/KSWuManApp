//
//  ManWuHotShowItemVIew.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/9/24.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "ManWuHomeAdvertisementModel.h"

@class ManWuHotShowItemVIew;

typedef void (^doButtonClicedBlock)        (ManWuHotShowItemVIew* hotShowItemVIew);

@interface ManWuHotShowItemVIew : KSView

@property (nonatomic, copy  ) doButtonClicedBlock buttonClicedBlock;

@property (nonatomic, strong) ManWuHomeAdvertisementModel  *     advertisementModel;

@end
