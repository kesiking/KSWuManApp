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

@property (nonatomic, assign) CSLinearLayoutItemPadding    linearLayoutPadding;

- (void)reloadData;

// override for 设置model类对象
- (void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel;
// override for 根据内容获取CSLinearLayoutItemPadding属性
- (CSLinearLayoutItemPadding)getLayoutPaddingWithIndex:(NSUInteger)index description:(NSString*)description;
// override for 根据内容获取展示view
- (UIView*)getDescriptionViewWithWithIndex:(NSUInteger)index description:(NSString*)description;

@end
