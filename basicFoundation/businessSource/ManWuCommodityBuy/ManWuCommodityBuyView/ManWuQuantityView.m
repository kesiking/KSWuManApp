//
//  TBBuyQuantityCell.m
//  TBBuy
//
//  Created by christ.yuj on 14-3-7.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "ManWuQuantityView.h"

#define CELL_HEIGHT           60
#define HONRIZONTAL_MARGIN    12
#define TITLE_WIDTH           64
#define NUM_STEPPER_WIDTH    120
#define NUM_STEPPER_HEIGHT    36
#define NUM_STEPPER_ORIGIN_Y  12

@interface ManWuQuantityView ()

@end

@implementation ManWuQuantityView

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Initialize

-(void)setupView{
    [super setupView];
    [self addSubview:self.buyNumberStepView];
}

- (ManWuDetailBuyNumberStepView *)buyNumberStepView {
    if (!_buyNumberStepView) {
        _buyNumberStepView=[[ManWuDetailBuyNumberStepView alloc] initWithFrame:CGRectMake(15, 0, self.width - 15 * 2, self.height)];
    }
    return _buyNumberStepView;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Private Accessor

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Public

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Private


////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - TBTradeCellDelegate

//+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object{
//    TBTradeQuantityModel *quantityModel = (TBTradeQuantityModel *)object;
//    return quantityModel.status == TBTradeComponentStatusHidden ? 0 : CELL_HEIGHT;
//}

- (void)setObject:(id)object{
    self.buyNumberStepView.numberStepper.value = 2;
    self.buyNumberStepView.numberStepper.maximumValue = 10;

//    self.model = (TBTradeQuantityModel *)object;
//    TBTradeQuantityModel *model = (TBTradeQuantityModel *)self.model;
//
//    self.countView.numberStepper.num = model.quantity;
//    self.countView.maxAmount = [NSString stringWithFormat:@"%d",model.max];
//
//    BOOL enable = model.status != TBTradeComponentStatusDisable;
//    self.countView.userInteractionEnabled = enable;
}

@end
