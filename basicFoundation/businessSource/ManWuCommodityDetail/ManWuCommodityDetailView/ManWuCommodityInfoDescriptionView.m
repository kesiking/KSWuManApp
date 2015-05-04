//
//  ManWuCommodityDescriptionView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityInfoDescriptionView.h"

@implementation ManWuCommodityInfoDescriptionView

-(void)setupView{
    [super setupView];
    [self.titleLabel setText:@"商品详情"];
}

-(void)setDescriptionModel:(WeAppComponentBaseItem *)descriptionModel{
    for (NSUInteger index = 0; index < 5 ; index++) {
        NSString* string = [NSString stringWithFormat:@"测试发大水发的撒:%lu",(unsigned long)index];
        [self.descriptionArray addObject:string];
    }
    [self reloadData];
}

@end
