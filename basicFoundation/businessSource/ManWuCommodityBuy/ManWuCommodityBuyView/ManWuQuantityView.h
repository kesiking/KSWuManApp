//
//  TBBuyQuantityCell.h
//  TBBuy
//
//  Created by christ.yuj on 14-3-7.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "ManWuBuyBasicView.h"
#import "ManWuDetailBuyNumberStepView.h"

@interface ManWuQuantityView : ManWuBuyBasicView

@property (nonatomic, strong) ManWuDetailBuyNumberStepView *buyNumberStepView;
@property (nonatomic, strong) valueChange                   valueDidChangeBlock;

@end
