//
//  TBBuyQuantityCell.m
//  TBBuy
//
//  Created by christ.yuj on 14-3-7.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "ManWuQuantityView.h"
#import "ManWuCommodityDetailModel.h"

#define CELL_HEIGHT           60
#define HONRIZONTAL_MARGIN    12
#define TITLE_WIDTH           64
#define NUM_STEPPER_WIDTH    120
#define NUM_STEPPER_HEIGHT    36
#define NUM_STEPPER_ORIGIN_Y  12

@interface ManWuQuantityView ()

@property (nonatomic, strong) ManWuCommodityDetailModel         *commodityDetailModel;

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
        _buyNumberStepView = [[ManWuDetailBuyNumberStepView alloc] initWithFrame:CGRectMake(15, 0, self.width - 15 * 2, self.height)];
        _buyNumberStepView.valueDidChangeBlock = self.valueDidChangeBlock;
        WEAKSELF
        _buyNumberStepView.numberStepper.showAleartViewBlock = ^(double value){
            STRONGSELF
            if (strongSelf.commodityDetailModel.activityBuyLimit != nil && [strongSelf.commodityDetailModel.activityBuyLimit unsignedIntegerValue] == [[self.commodityPriceCaculate getCommodityQuantity] unsignedIntegerValue]) {
                [WeAppToast toast:[NSString stringWithFormat:@"最多购买%@件商品",strongSelf.commodityDetailModel.activityBuyLimit] toView:strongSelf.window];
            }else{
                [WeAppToast toast:@"无库存啦~~" toView:strongSelf.window];
            }
        };
    }
    return _buyNumberStepView;
}

-(void)setValueDidChangeBlock:(valueChange)valueDidChangeBlock{
    _valueDidChangeBlock = valueDidChangeBlock;
    self.buyNumberStepView.valueDidChangeBlock = valueDidChangeBlock;
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

- (void)setObject:(id)object dict:(NSDictionary *)dict{
    [super setObject:object dict:dict];
    if (![object isKindOfClass:[ManWuCommodityDetailModel class]]) {
        return;
    }

    self.commodityDetailModel = (ManWuCommodityDetailModel*)object;
    
    NSUInteger count = [[self.commodityPriceCaculate getCommodityCount] unsignedIntegerValue];
    NSUInteger quantity = [[self.commodityPriceCaculate getCommodityQuantity] unsignedIntegerValue];

    self.buyNumberStepView.numberStepper.value = count;
    self.buyNumberStepView.numberStepper.maximumValue = quantity;
    self.buyNumberStepView.numberStepper.minimumValue = 1;


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
