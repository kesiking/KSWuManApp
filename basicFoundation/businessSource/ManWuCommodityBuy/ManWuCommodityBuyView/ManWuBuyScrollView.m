//
//  ManWuBuyScrollView.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuBuyScrollView.h"
#import "ManWuAddressView.h"
#import "ManWuBuyItemInfoView.h"
#import "ManWuQuantityView.h"
#import "ManWuDeliveryView.h"
#import "ManWuConfirmView.h"

@interface ManWuBuyScrollView()

@property (nonatomic, strong) CSLinearLayoutView           *skuContainer;
@property (nonatomic, strong) ManWuAddressView             *addressView;
@property (nonatomic, strong) ManWuBuyItemInfoView         *commodityInfoItem;
@property (nonatomic, strong) ManWuQuantityView            *quantityView;
@property (nonatomic, strong) ManWuDeliveryView            *deliveryView;
@property (nonatomic, strong) ManWuConfirmView             *comfirmView;

@end

@implementation ManWuBuyScrollView

-(void)setupView{
    [self addSubview:self.skuContainer];
    [self reloadData];
}

-(ManWuAddressView *)addressView{
    if (!_addressView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 100);
        _addressView = [[ManWuAddressView alloc] initWithFrame:frame];
    }
    return _addressView;
}

-(ManWuBuyItemInfoView *)commodityInfoItem{
    if (!_commodityInfoItem) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 100);
        _commodityInfoItem = [[ManWuBuyItemInfoView alloc] initWithFrame:frame];
    }
    return _commodityInfoItem;
}

-(ManWuQuantityView *)quantityView{
    if (!_quantityView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 60);
        _quantityView = [[ManWuQuantityView alloc] initWithFrame:frame];
    }
    return _quantityView;
}

-(ManWuDeliveryView *)deliveryView{
    if (!_deliveryView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 44);
        _deliveryView = [[ManWuDeliveryView alloc] initWithFrame:frame];
    }
    return _deliveryView;
}

-(ManWuConfirmView *)comfirmView{
    if (!_comfirmView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 44);
        _comfirmView = [[ManWuConfirmView alloc] initWithFrame:frame];
    }
    return _comfirmView;
}

- (CSLinearLayoutView *)skuContainer {
    if (!_skuContainer) {
        float containerHeight = self.height;
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, containerHeight);
        _skuContainer = [[CSLinearLayoutView alloc] initWithFrame:frame];
        _skuContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _skuContainer.backgroundColor  = [TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg1];
    }
    return _skuContainer;
}

-(void)reloadData{
    /*重新布局*/
    [self.addressView setObject:nil];
    [self.commodityInfoItem setObject:nil];
    [self.quantityView setObject:nil];
    [self.deliveryView setObject:nil];
    [self.comfirmView setObject:nil];


    CGPoint skuContentOffset          = self.skuContainer.contentOffset;
    [self.skuContainer removeAllItems];
    CSLinearLayoutItemPadding padding = CSLinearLayoutMakePadding(0, 0, 0, 0.0);
    
    
    /*收获地址*/
    if (1) {
        CSLinearLayoutItem *addressViewItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.addressView];
        addressViewItem.padding = padding;
        [self.skuContainer addItem:addressViewItem];
    }
    
    /*购买信息*/
    if (1) {
        CSLinearLayoutItem *commodityInfoItem = [[CSLinearLayoutItem alloc]
                                             initWithView:self.commodityInfoItem];
        commodityInfoItem.padding             = padding;
        [self.skuContainer addItem:commodityInfoItem];
    }
    
    /*购买数量*/
    if (1) {
        CSLinearLayoutItem *quantityViewItem = [[CSLinearLayoutItem alloc]
                                                 initWithView:self.quantityView];
        quantityViewItem.padding             = padding;
        [self.skuContainer addItem:quantityViewItem];
    }
    
    /*送货方式*/
    if (1) {
        CSLinearLayoutItem *deliveryViewItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.deliveryView];
        deliveryViewItem.padding             = padding;
        [self.skuContainer addItem:deliveryViewItem];
    }
    
    /*确认付款*/
    if (1) {
        CSLinearLayoutItem *comfirmViewItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.comfirmView];
        comfirmViewItem.padding             = padding;
        [self.skuContainer addItem:comfirmViewItem];
    }
    
    /*调整布局*/
    if (self.skuContainer.contentSize.height > self.skuContainer.height) {
        [self.skuContainer setContentOffset:skuContentOffset];
    }
}

@end
