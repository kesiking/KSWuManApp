//
//  ManWuDetailSKUView.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "TBDetailSKUModelAndService.h"

@class ManWuDetailSKUView;

typedef void(^gotoBuyBlock) (ManWuDetailSKUView* skuView,NSDictionary* params);

@protocol KSDetailTradeSKUViewDelegate;

@interface ManWuDetailSKUView : KSView

@property (nonatomic, strong)          TBDetailSKUModelAndService *skuDetailModel;
@property (nonatomic, strong)          gotoBuyBlock                gotoBuyBlock;
@property (nonatomic, assign)          id<KSDetailTradeSKUViewDelegate>    delegate;
@property (nonatomic, readonly, assign) NSUInteger                   quantity;

//! 程序内部触发购买按钮的点击动作
- (void)triggerBuyBtn:(id)sender;

@end

@protocol KSDetailTradeSKUViewDelegate <NSObject>

//! 需要调用方实现自己的dismiss skuView逻辑，dismiss成功后执行block()
- (void)tradeSkuView:(ManWuDetailSKUView *)skuView dismissSkuViewHandleBlock:(dispatch_block_t)block;

@optional

//! 业务场景：购物车，第二个参数为已选中的skuId
- (void)tradeSkuDidFinishChooseSku:(ManWuDetailSKUView *)skuView selectedSkuId:(NSString *)skuId;

//! sku发生变化
- (void)tradeSkuValueDidChange:(ManWuDetailSKUView *)skuView;

//! 立即购买按钮触发回调，便于业务层埋点
- (void)tradeSkuBuyButtonClicked:(ManWuDetailSKUView *)skuView;

//! 加入购物车按钮触发回调，便于业务层埋点
- (void)tradeSkuAddCartButtonClicked:(ManWuDetailSKUView *)skuView;

//! 非sku宝贝加入购物车动画需要业务层的View
- (UIView *)viewForAnimationInSkuView:(ManWuDetailSKUView *)skuView;

//!购物车是否在顶部：若在底部，则sku出现的时候，没有动画
- (BOOL)cartIsOnTop:(ManWuDetailSKUView *)skuView;

@end
