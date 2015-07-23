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
#import "ManWuPreferentialView.h"
#import "ManWuVoucherView.h"
#import "ManWuBuyOrderPayView.h"
#import "ManWuConfirmView.h"
#import "ManWuCommodityDetailModel.h"
#import "ManWuOrderService.h"
#import "ManWuVoucherService.h"
#import "KSSafePayUtility.h"
#import "ManWuOrderDetailViewController.h"

@interface ManWuBuyScrollView(){

}

@property (nonatomic, strong) CSLinearLayoutView           *skuContainer;
@property (nonatomic, strong) ManWuAddressView             *addressView;
@property (nonatomic, strong) ManWuBuyItemInfoView         *commodityInfoItem;
@property (nonatomic, strong) ManWuQuantityView            *quantityView;
@property (nonatomic, strong) ManWuDeliveryView            *deliveryView;
@property (nonatomic, strong) ManWuPreferentialView        *preferentialView;
@property (nonatomic, strong) ManWuVoucherView             *voucherView;
@property (nonatomic, strong) ManWuBuyOrderPayView         *orderPayView;
@property (nonatomic, strong) ManWuConfirmView             *comfirmView;

@property (nonatomic, strong) ManWuOrderService            *createOrderService;
@property (nonatomic, strong) ManWuOrderService            *loadOrderService;
@property (nonatomic, strong) ManWuVoucherService          *voucherService;

@property (nonatomic, assign) BOOL                          hasVoucher;

@end

@implementation ManWuBuyScrollView

-(void)setupView{
    self.backgroundColor = RGB(0xf8, 0xf8, 0xf8);
    _dict = [NSMutableDictionary dictionary];
    [self addSubview:self.skuContainer];
    _commodityPriceCaculate = [ManWuCommodityPriceCaculate new];
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
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 85);
        _commodityInfoItem = [[ManWuBuyItemInfoView alloc] initWithFrame:frame];
    }
    return _commodityInfoItem;
}

-(ManWuQuantityView *)quantityView{
    if (!_quantityView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 56);
        _quantityView = [[ManWuQuantityView alloc] initWithFrame:frame];
        WEAKSELF
        _quantityView.buyNumberStepView.numberStepper.onPop = ^(){
            /*设置视图的状态*/
            CGPoint p = [weakSelf.quantityView.buyNumberStepView.numberStepper convertPoint:CGPointMake(0, 0) fromView:weakSelf.skuContainer];
            if (weakSelf.skuContainer.contentOffset.y > 0) {
                weakSelf.quantityView.buyNumberStepView.numberStepper.tag = weakSelf.skuContainer.contentOffset.y + weakSelf.quantityView.buyNumberStepView.numberStepper.height;
            }
            
            /*由于iOS8系统支持输入法插件，比原来的系统默认输入法要高，因此需要调整计数器的高度，否则会被遮挡住
             TODO：尝试获得系统输入键盘的高度，让计数器区域位于输入键盘之上
             */
            CGPoint point = CGPointMake(0, -weakSelf.skuContainer.height - p.y + 310);
            [weakSelf.skuContainer setContentOffset:point animated:YES];
            weakSelf.skuContainer.scrollEnabled = NO;
        };
        
        _quantityView.buyNumberStepView.numberStepper.onEnd = ^(){
            /*设置视图的状态*/
            
            weakSelf.skuContainer.scrollEnabled = YES;
            
            CGFloat  offsetY = weakSelf.skuContainer.contentSize.height - weakSelf.skuContainer.frame.size.height;
            offsetY = offsetY > 0 ? offsetY : 0;
            [weakSelf.skuContainer setContentOffset:CGPointMake(0, offsetY) animated:YES];
        };
        
        _quantityView.valueDidChangeBlock = ^(double value){
            [weakSelf.dict setObject:[NSNumber numberWithDouble:value] forKey:@"buyNumber"];
            [weakSelf setObject:weakSelf.detailModel dict:weakSelf.dict];
        };
    }
    return _quantityView;
}

-(ManWuDeliveryView *)deliveryView{
    if (!_deliveryView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 40);
        _deliveryView = [[ManWuDeliveryView alloc] initWithFrame:frame];
    }
    return _deliveryView;
}

-(ManWuPreferentialView *)preferentialView{
    if (_preferentialView == nil) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 40);
        _preferentialView = [[ManWuPreferentialView alloc] initWithFrame:frame];
    }
    return _preferentialView;
}

-(ManWuVoucherView *)voucherView{
    if (_voucherView == nil) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 40);
        _voucherView = [[ManWuVoucherView alloc] initWithFrame:frame];
        WEAKSELF
        _voucherView.selectVoucherViewBlock = ^(ManWuVoucherView *voucherView){
            STRONGSELF
            [strongSelf.orderPayView setVoucherPrice:voucherView.voucherPrice];
        };
    }
    return _voucherView;
}

-(ManWuBuyOrderPayView *)orderPayView{
    if (!_orderPayView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 45);
        _orderPayView = [[ManWuBuyOrderPayView alloc] initWithFrame:frame];
    }
    return _orderPayView;
}

-(ManWuConfirmView *)comfirmView{
    if (!_comfirmView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, 68);
        _comfirmView = [[ManWuConfirmView alloc] initWithFrame:frame];
        WEAKSELF
        _comfirmView.confirmButtonClick = ^(){
            STRONGSELF
            NSString* skuId = [strongSelf.dict objectForKey:@"skuId"]?:@"1";
            NSString* itemId = strongSelf.detailModel.itemId;
            NSNumber* buyNum = [strongSelf.commodityPriceCaculate getCommodityCount];
            NSNumber* activityId = strongSelf.detailModel.activityId;
            
            float payPrice = [strongSelf.commodityPriceCaculate getTruePriceWithVoucherPrice:0];
            
            if (strongSelf.hasVoucher) {
                payPrice = [strongSelf.commodityPriceCaculate getTruePriceWithVoucherPrice:strongSelf.voucherView.voucherPrice];
            }
            
            if (strongSelf.addressView.addressId == nil || strongSelf.addressView.addressId.length == 0) {
                [WeAppToast toast:@"请先输入您的收货地址"];
                return;
            }
            
            [strongSelf.createOrderService createOrderWithUserId:[KSAuthenticationCenter userId] addressId:strongSelf.addressView.addressId skuId:skuId itemId:itemId buyNum:buyNum payPrice:[NSNumber numberWithFloat:payPrice] activityId:activityId voucherId:strongSelf.voucherView.voucherId];
        };
    }
    return _comfirmView;
}

- (CSLinearLayoutView *)skuContainer {
    if (!_skuContainer) {
        float containerHeight = self.height;
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, containerHeight);
        _skuContainer = [[CSLinearLayoutView alloc] initWithFrame:frame];
        _skuContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _skuContainer.backgroundColor  = RGB(0xf8, 0xf8, 0xf8);
    }
    return _skuContainer;
}

-(ManWuOrderService *)createOrderService{
    if (_createOrderService == nil) {
        _createOrderService = [[ManWuOrderService alloc] init];
        WEAKSELF
        _createOrderService.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            if (service && service.numberValue) {
                NSString* tradeNO = [NSString stringWithFormat:@"%@",service.numberValue];
                NSDictionary* params = @{@"tradeNO":tradeNO?:@"",@"productName":strongSelf.detailModel.title?:@"",@"productDescription":strongSelf.detailModel.title?:@"",@"price":[NSString stringWithFormat:@"%@",strongSelf.orderPayView.payPrice?:@0.01]};
                
                [KSSafePayUtility aliPayForParams:params callbackBlock:^(NSDictionary *resultDic) {
                    // 支付成功后 todo
                    [strongSelf.loadOrderService loadOrderItemWithOrderId:tradeNO];
                    [strongSelf showLoadingView];
                }];
            }
        };
        _createOrderService.serviceDidFailLoadBlock = ^(WeAppBasicService* service, NSError* error){
            STRONGSELF
            [WeAppToast toast:[NSString stringWithFormat:@"服务器在偷懒，请稍微再试"]];
        };
    }
    return _createOrderService;
}

-(ManWuOrderService *)loadOrderService{
    if (_loadOrderService == nil) {
        _loadOrderService = [ManWuOrderService new];
        WEAKSELF
        _loadOrderService.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            if (service && service.item) {
                [strongSelf hideLoadingView];
                ManWuOrderDetailViewController *orderDetailVC = [[ManWuOrderDetailViewController alloc]init];
                orderDetailVC.orderModel = (KSOrderModel*)service.item;
                [strongSelf.viewController.navigationController pushViewController:orderDetailVC animated:YES];
            }
        };
        
        _loadOrderService.serviceDidFailLoadBlock = ^(WeAppBasicService* service, NSError* error){
            STRONGSELF
            [strongSelf hideLoadingView];
        };
    }
    return _loadOrderService;
}

-(ManWuVoucherService *)voucherService{
    if (_voucherService == nil) {
        _voucherService = [[ManWuVoucherService alloc] init];
        WEAKSELF
        _voucherService.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            if (service && service.dataList) {
                strongSelf.hasVoucher = YES;
                [strongSelf.voucherView setObject:service.dataList dict:nil];
                [strongSelf reloadData];
            }
        };
    }
    return _voucherService;
}

- (void)setObject:(ManWuCommodityDetailModel *)object dict:(NSDictionary *)dict{
    if (![object isKindOfClass:[ManWuCommodityDetailModel class]]) {
        return;
    }
    if (self.detailModel != object) {
        self.detailModel = object;
    }
    if (self.dict != dict) {
        [self.dict addEntriesFromDictionary:dict];
    }
    [self.commodityPriceCaculate setObject:object dict:dict];

    [self.commodityInfoItem setObject:object dict:dict];
    [self.quantityView setObject:object dict:dict];
    [self.deliveryView setObject:object dict:dict];
    [self.preferentialView setObject:object dict:dict];
    [self.orderPayView setObject:object dict:dict];
    [self.comfirmView setObject:object dict:dict];
//    [self.voucherService loadVoucherWithItemId:object.itemId buyNum:[self.dict objectForKey:@"buyNum"]?:@1];
    [self.voucherService fetchVoucherWithCidId:object.cid userId:[KSAuthenticationCenter userId] activityTypeId:self.detailModel.activityTypeId payPrice:self.orderPayView.payPrice];
    [self reloadData];
}

-(void)reloadData{
    /*重新布局*/

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
    
    if (self.hasVoucher) {
        CSLinearLayoutItem *voucherViewItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.voucherView];
        voucherViewItem.padding             = padding;
        [self.skuContainer addItem:voucherViewItem];
    }
    
    /*优惠信息*/
    if (1) {
        CSLinearLayoutItem *orderPayViewItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.preferentialView];
        orderPayViewItem.padding             = padding;
        [self.skuContainer addItem:orderPayViewItem];
    }
    
    /*合计价格*/
    if (1) {
        CSLinearLayoutItem *orderPayViewItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.orderPayView];
        orderPayViewItem.padding             = padding;
        [self.skuContainer addItem:orderPayViewItem];
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
    
    [self.skuContainer bringSubviewToFront:self.voucherView];
}

@end
