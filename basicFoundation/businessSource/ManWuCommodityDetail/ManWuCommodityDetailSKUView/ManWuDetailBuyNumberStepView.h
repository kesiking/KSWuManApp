//
//  ManWuDetailBuyNumberStepView.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "PAStepperDetail.h"

@interface ManWuDetailBuyNumberStepView : KSView

@property (nonatomic, strong) UILabel                 *buyLimitLabel;
@property (nonatomic, strong) UILabel                 *buyTitleLabel;
@property (nonatomic, strong) PAStepperDetail         *numberStepper;
@property (strong, nonatomic) valueChange              valueDidChangeBlock;

@end
