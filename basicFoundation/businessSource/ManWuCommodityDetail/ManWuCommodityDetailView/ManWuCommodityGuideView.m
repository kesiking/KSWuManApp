//
//  ManWuCommodityGuideView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityGuideView.h"

@implementation ManWuCommodityGuideView

-(void)setupView{
    [super setupView];
    [self.titleLabel setText:@"商家声明"];
}

-(void)setDescriptionModel:(WeAppComponentBaseItem *)descriptionModel{
    
    [self.descriptionArray addObject:@"1.全场包邮。"];
    [self.descriptionArray addObject:@"2.签收后如发现质量问题，请24小时内联系售后反馈。在不影响二次销售情况下，无理由退货或者换货。"];
    [self.descriptionArray addObject:@"3.购买后两个工作日内发货，节假日除外。"];
    [self.descriptionArray addObject:@"4.屋满商家具有最终解释权，详见“关于我们”说明。"];
    
    [self reloadData];
}

@end
