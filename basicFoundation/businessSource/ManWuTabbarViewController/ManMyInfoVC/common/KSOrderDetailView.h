//
//  KSOrderDetailView.h
//  basicFoundation
//
//  Created by 许学 on 15/6/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSOrderModel.h"

typedef NS_ENUM(NSInteger, ButtonSelectedStyle) {
    ButtonSelectedStylePay,
    ButtonSelectedStyleCancelOrder,
    ButtonSelectedStyleNoteSend,
    ButtonSelectedStyleReceived,
    ButtonSelectedStyleDeleteOrder,
    ButtonSelectedStyleService
};

@protocol KSOrderDetailViewDelegate <NSObject>

- (void)didSelectedButtonStyle:(ButtonSelectedStyle)style;
- (void)didSelectedOrderInfoItem:(KSOrderModel *)orderModel;

@end

@interface KSOrderDetailView : UIView

@property (nonatomic, assign) id<KSOrderDetailViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame OrderModel:(KSOrderModel *)ordermodel;
- (void)updateViewWithOrderModel:(KSOrderModel*)model;

@end
