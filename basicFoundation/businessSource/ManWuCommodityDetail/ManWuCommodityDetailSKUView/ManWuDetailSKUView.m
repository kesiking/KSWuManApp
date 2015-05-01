//
//  ManWuDetailSKUView.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDetailSKUView.h"
#import "TBTradeSKUSelectionControl.h"
#import "ManWuDetailBuyNumberStepView.h"
#import "ManWuDetailBottomBarView.h"

#define NEED_BUYNUMBERSTEPVIEW_COMPONENT (1)

@interface ManWuDetailSKUView()

@property (nonatomic, strong) CSLinearLayoutView               *skuContainer;

@property (nonatomic, strong) TBTradeSKUSelectionControl       *skuSelectionControl;

@property (nonatomic, strong) ManWuDetailBuyNumberStepView     *buyNumberStepView;

@property (nonatomic, strong) ManWuDetailBottomBarView         *bottomView;

@end

@implementation ManWuDetailSKUView

-(void)setupView{
    [self addSubview:self.skuContainer];
    [self addSubview:self.bottomView];
    [self reloadData];
}

- (void)setSkuDetailModel:(TBDetailSKUModelAndService *)skuDetailModel {
    _skuDetailModel = skuDetailModel;
    [self reloadData];
}

- (TBTradeSKUSelectionControl *)skuSelectionControl {
    if (!_skuSelectionControl) {
        CGRect frame = CGRectMake(TBSKU_BORDER_GAP, 0, TBSKU_CONTROL_WIDTH, 200);
        _skuSelectionControl = [[TBTradeSKUSelectionControl alloc] initWithFrame:frame];
        [_skuSelectionControl addTarget:self action:@selector(skuPropChanged:) forControlEvents:UIControlEventValueChanged];
        _skuSelectionControl.backgroundColor = [UIColor clearColor];
    }
    return _skuSelectionControl;
}

- (CSLinearLayoutView *)skuContainer {
    if (!_skuContainer) {
        float containerHeight = self.height -  TBSKU_BOTTOM_HEIGHT;
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, containerHeight);
        _skuContainer = [[CSLinearLayoutView alloc] initWithFrame:frame];
        _skuContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _skuContainer.backgroundColor  = [TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg1];
    }
    return _skuContainer;
}

- (ManWuDetailBuyNumberStepView *)buyNumberStepView {
    if (!_buyNumberStepView) {
        _buyNumberStepView=[[ManWuDetailBuyNumberStepView alloc] initWithFrame:CGRectMake(0, 0, TBSKU_CONTROL_WIDTH, 55+15)];
        __weak __typeof(self) weakSelf = self;
        _buyNumberStepView.numberStepper.onPop = ^(){
            /*设置视图的状态*/
            CGPoint p = [weakSelf.buyNumberStepView.numberStepper convertPoint:CGPointMake(0, 0) fromView:weakSelf.skuContainer];
            if (weakSelf.skuContainer.contentOffset.y > 0) {
                weakSelf.buyNumberStepView.numberStepper.tag = weakSelf.skuContainer.contentOffset.y + weakSelf.buyNumberStepView.numberStepper.height;
            }
            
            /*由于iOS8系统支持输入法插件，比原来的系统默认输入法要高，因此需要调整计数器的高度，否则会被遮挡住
             TODO：尝试获得系统输入键盘的高度，让计数器区域位于输入键盘之上
             */
            CGPoint point = CGPointMake(0, -weakSelf.skuContainer.height - p.y + 260);
            [weakSelf.skuContainer setContentOffset:point animated:YES];
            weakSelf.skuContainer.scrollEnabled = NO;
        };
        
        _buyNumberStepView.numberStepper.onEnd = ^(){
            /*设置视图的状态*/
            
            weakSelf.skuContainer.scrollEnabled = YES;
            
            CGFloat  offsetY = weakSelf.skuContainer.contentSize.height - weakSelf.skuContainer.frame.size.height;
            offsetY = offsetY > 0 ? offsetY : 0;
            [weakSelf.skuContainer setContentOffset:CGPointMake(0, offsetY) animated:YES];
        };
    }
    return _buyNumberStepView;
}

- (ManWuDetailBottomBarView *)bottomView {
    if (!_bottomView) {
        CGRect frame = CGRectMake(0, self.height - TBSKU_BOTTOM_HEIGHT, self.frame.size.width, TBSKU_BOTTOM_HEIGHT);
        _bottomView  = [[ManWuDetailBottomBarView alloc] initWithFrame:frame];
    }
    return _bottomView;
}

- (void)reloadData {
    /*属性部分*/
    self.skuSelectionControl.detailModel              = self.skuDetailModel;
    
    /*更新最大值*/
    self.buyNumberStepView.numberStepper.maximumValue = 10;//self.detailModel.itemInfoModel.quantity;
    
    if (self.skuDetailModel.skuService.currentSKUInfo.selectSkuId.length > 0) {
//        self.buyNumberStepView.numberStepper.maximumValue = self.skuDetailModel.skuService.currentSKUInfo.quantity;
    }
    
    /*重新布局*/
    CGPoint skuContentOffset          = self.skuContainer.contentOffset;
    [self.skuContainer removeAllItems];
    CSLinearLayoutItemPadding padding = CSLinearLayoutMakePadding(0, TBSKU_BORDER_GAP, 5.0, 0.0);
    
    
    /*sku选择*/
    if (self.skuDetailModel.skuModel.skuProps.count > 0) {
        CSLinearLayoutItem *skuSelectionItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.skuSelectionControl];
        skuSelectionItem.padding             = padding;
        [self.skuContainer addItem:skuSelectionItem];
    }
    
    /*购买数量组件*/
    if (NEED_BUYNUMBERSTEPVIEW_COMPONENT) {
        CSLinearLayoutItem *buyNumberItem = [[CSLinearLayoutItem alloc]
                                             initWithView:self.buyNumberStepView];
        buyNumberItem.padding             = padding;
        [self.skuContainer addItem:buyNumberItem];
    }
    
    /*调整布局*/
    if (self.skuContainer.contentSize.height > self.skuContainer.height) {
        [self.skuContainer setContentOffset:skuContentOffset];
    }
    
    /*配置底部工具视图*/
    [self configBottomView];
}

/**
 * 底下的部分：
 *   0 立即购买 1 加入购物车 2 点击sku更多 3 购物车
 */
- (void)configBottomView {
    
    /*buyButton 在不同情况下注册了不同的事件，因此要先移除再注册*/
    [self.bottomView.buyButton removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.buyButton addTarget:self action:@selector(buyNowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)triggerBuyBtn:(id)sender {
    [self buyNowBtnClick:sender];
}

- (void)skuPropChanged:(id)sender {
    [self reloadData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tradeSkuValueDidChange:)]) {
        [self.delegate tradeSkuValueDidChange:self];
    }
}

- (void)buyNowBtnClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(tradeSkuBuyButtonClicked:)]) {
        [self.delegate tradeSkuBuyButtonClicked:self];
    }
    
    if (![self isSKUSelected]) {
        return;
    }
    
    [self gotoBuy];
}

- (BOOL)isSKUSelected {
    NSString *msg = nil;
    if (self.skuDetailModel.skuService.currentSKUInfo.selectSkuId.length == 0
        && [self.skuDetailModel.skuService hasSKU]) {
        msg = self.skuDetailModel.skuService.currentSKUInfo.skuPopUpString;
        if (msg.length == 0) {
            msg = @"购买失败";
        }
        [WeAppToast toast:msg toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
    return YES;
}

-(void)gotoBuy {
    // 跳转到下单页面
//    NSString *itemId = self.detailModel.itemInfoModel.itemId;
    NSString *skuId = self.skuDetailModel.skuService.currentSKUInfo.selectSkuId;
    NSString *quantity = @"1";
    
    /*现在数量都是1*/
    if (self.buyNumberStepView.numberStepper.value>0) {
        quantity = [NSString stringWithFormat:@"%f",(double)self.buyNumberStepView.numberStepper.value];
    }
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:quantity,@"quantity",skuId, @"skuId",nil];
    
    // 获取weakSelfViewController是为了防止在block执行时当前skuView没法获取到viewController
    __weak __block UIViewController* weakSelfViewController = self.viewController;
    dispatch_block_t  gotoBuyBlock = ^(){
        __strong __block UIViewController* sSelfViewController = weakSelfViewController;
        // 跳转下单
        TBOpenURLFromTargetWithNativeParams(internalURL(kManWuCommodityBuyInfo), sSelfViewController,nil,params);
    };
    
    if(self.window){
        if (self.delegate && [self.delegate respondsToSelector:@selector(tradeSkuView:dismissSkuViewHandleBlock:)]) {
            [self.delegate tradeSkuView:self dismissSkuViewHandleBlock:gotoBuyBlock];
        }
    }else{
        gotoBuyBlock();
    }
}

@end
