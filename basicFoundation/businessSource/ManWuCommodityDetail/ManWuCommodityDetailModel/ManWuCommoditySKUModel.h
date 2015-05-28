//
//  ManWuCommoditySKUModel.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@protocol ManWuCommoditySKUModel <NSObject>

@end

@interface ManWuCommoditySKUModel : WeAppComponentBaseItem

//属性值列表;例如：颜色属性：红色，蓝色
@property (nonatomic, strong) NSMutableArray        *values;

//属性名称
@property (nonatomic, strong) NSString              *propName;

//属性名称
@property (nonatomic, strong) NSString              *propId;


@end
