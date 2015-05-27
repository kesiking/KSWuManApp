//
//  ManWuSpecialForTodayView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"

@interface ManWuSpecialForTodayView : KSView

// 设置图片数据
-(void)setLeftDescriptionModel:(WeAppComponentBaseItem*)leftDescriptionModel rightDescriptionModel:(WeAppComponentBaseItem*)rightDescriptionModel;

// 不用于展示，主要用于跳转到活动商品列表时需要折上折的图片信息
-(void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel;

-(void)refresh;

@end
