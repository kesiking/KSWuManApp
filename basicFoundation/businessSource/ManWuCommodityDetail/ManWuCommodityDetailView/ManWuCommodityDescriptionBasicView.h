//
//  ManWuCommodityDescriptionBasicView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"

@interface ManWuCommodityDescriptionBasicView : KSView

@property (nonatomic, strong) NSMutableArray              *descriptionArray;

@property (nonatomic, strong) UILabel                     *titleLabel;

- (void)reloadData;

- (void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel;


@end
