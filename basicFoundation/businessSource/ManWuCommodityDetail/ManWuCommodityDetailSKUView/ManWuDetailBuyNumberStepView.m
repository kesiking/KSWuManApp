//
//  ManWuDetailBuyNumberStepView.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDetailBuyNumberStepView.h"

@implementation ManWuDetailBuyNumberStepView

-(void)setupView{
    [super setupView];
    [self addSubview:self.buyTitleLabel];
    [self addSubview:self.buyLimitLabel];
    [self addSubview:self.numberStepper];
    
    /*初始化添加分割线*/
    CGRect frame = CGRectMake(0, self.bottom - 0.5, self.width, 0.5);
    UIView *bottomLine=[[UIView alloc] initWithFrame:frame];
    bottomLine.backgroundColor = [TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Title0
                                                           alpha:0.2];
    [self addSubview:bottomLine];
}

- (PAStepperDetail *)numberStepper {
    if (!_numberStepper) {
        CGRect frame = CGRectMake(self.width - TBSKU_NUMBER_STEPPER_WIDTH - 15, (self.height - 36)/2, TBSKU_NUMBER_STEPPER_WIDTH, 36);
        _numberStepper = [[PAStepperDetail alloc] initWithFrame:frame];
        
        /*倍数购买*/
        _numberStepper.stepValue          = 1;
        _numberStepper.minimumValue       = _numberStepper.stepValue;
        _numberStepper.maximumValue       = 100;
        _numberStepper.continuous         = NO;
        _numberStepper.autorepeat         = YES;
        _numberStepper.autorepeatInterval = 0.2;
        WEAKSELF
        _numberStepper.onValueChange = ^(double value){
            STRONGSELF
            if (strongSelf.valueDidChangeBlock) {
                strongSelf.valueDidChangeBlock(value);
            }
        };
        _numberStepper.onEnd = ^(double value){
            STRONGSELF
            if (strongSelf.valueDidChangeBlock) {
                strongSelf.valueDidChangeBlock(value);
            }
        };
        [_numberStepper setValueWithoutEvents:_numberStepper.stepValue];
    }
    return _numberStepper;
}

- (UILabel *)buyTitleLabel {
    if (!_buyTitleLabel) {
        _buyTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, (self.height - 36)/2, 60, 36)];
        _buyTitleLabel.backgroundColor=[UIColor clearColor];
        _buyTitleLabel.text = @"购买数量";
        _buyTitleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        [_buyTitleLabel setTextColor:RGB(0x99, 0x99, 0x99)];
    }
    return _buyTitleLabel;
}

// 限制购买的数量
- (UILabel *)buyLimitLabel {
    if (!_buyLimitLabel) {
        float width = self.numberStepper.left - self.buyTitleLabel.right - 10;
        CGFloat y   = self.buyTitleLabel.top + (self.buyTitleLabel.height - 36) / 2;
        CGRect frame = CGRectMake(self.buyTitleLabel.right + 5, y, width, 36);
        _buyLimitLabel           = [[UILabel alloc] initWithFrame:frame];
        _buyLimitLabel.font      = [UIFont systemFontOfSize:10.0];
        _buyLimitLabel.textColor = RGB(170, 170, 170);
        
        _buyLimitLabel.numberOfLines   = 2;
        _buyLimitLabel.backgroundColor = [UIColor clearColor];
        _buyLimitLabel.textAlignment   = NSTextAlignmentLeft;
    }
    return _buyLimitLabel;
}

@end
