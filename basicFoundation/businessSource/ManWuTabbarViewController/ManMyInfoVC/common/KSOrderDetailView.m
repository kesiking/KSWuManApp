//
//  KSOrderDetailView.m
//  basicFoundation
//
//  Created by 许学 on 15/6/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSOrderDetailView.h"
#import "KSOrderModel.h"

#define kSpacePaddingX 15
#define kSpacePaddingY 15
#define kPadding       10
#define itemView_orderType_height    80
#define itemView_addressInfo_height  120
#define itemView_orderInfo_height    300
#define itemView_orderDeal_height    80

@implementation KSOrderDetailView
{
    CSLinearLayoutView *myInfoContainer;
    KSOrderModel *orderModel;
    UIView *itemView_orderType;
    UIView *itemView_addressInfo;
    UIView *itemView_orderInfo;
    UIView *itemView_orderDeal;
    
    NSString *orderType;
    
}

- (id)initWithFrame:(CGRect)frame OrderModel:(KSOrderModel *)ordermodel
{
    self = [super initWithFrame:frame];
    if(self)
    {
        orderModel = ordermodel;
        switch ([orderModel.status integerValue]) {
            case 0:
            {
                orderType = @"待付款";
            }
                break;
            case 1:
            {
                orderType = @"待发货";
            }
                break;
            case 2:
            {
                orderType = @"待收货";
            }
                break;
            case 3:
            {
                orderType = @"已收货";
            }
                break;
            case 4:
            {
                orderType = @"退/换货";
            }
                break;
                
            default:
                break;
        }

        [self initCSLinearLayoutView];
    }
    
    return self;
}

- (void)initCSLinearLayoutView
{
    myInfoContainer = [[CSLinearLayoutView alloc]initWithFrame:self.frame];
    myInfoContainer.orientation = CSLinearLayoutViewOrientationVertical;
    myInfoContainer.scrollEnabled = YES;

    [self initItemView_orderType];
    [self initItemView_addressInfo];
    [self initItemView_orderInfo];
    [self initItemView_orderDeal];
}

- (void)initItemView_orderType
{
    if(!itemView_orderType)
    {
        itemView_orderType = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, itemView_orderType_height)];
        [itemView_orderType setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
        UILabel *orderTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacePaddingX, kSpacePaddingY, 200, 15)];
        [orderTypeLabel setFont:[UIFont systemFontOfSize:15]];
        [orderTypeLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#ffffff"]];
        orderTypeLabel.text = [NSString stringWithFormat:@"订单类型：%@",orderType];
        [itemView_orderType addSubview:orderTypeLabel];

        UILabel *orderPayLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacePaddingX, CGRectGetMaxY(orderTypeLabel.frame) + 10, 200, 15)];
        [orderPayLabel setFont:[UIFont systemFontOfSize:15]];
        [orderPayLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#ffffff"]];
        orderPayLabel.text = [NSString stringWithFormat:@"订单总金额：￥%@",orderModel.payPrice];
        [itemView_orderType addSubview:orderPayLabel];

    }
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:itemView_orderType];
    item.padding = CSLinearLayoutMakePadding(kPadding, 0,kPadding, 0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    item.verticalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
    [myInfoContainer addItem:item];

}

- (void)initItemView_addressInfo
{
    if(!itemView_addressInfo)
    {
        itemView_addressInfo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, itemView_addressInfo_height)];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacePaddingX, kSpacePaddingY, 200, 14)];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        titleLabel.text = [NSString stringWithFormat:@"收货人信息"];
        [itemView_addressInfo addSubview:titleLabel];
        
        UILabel *buyerLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacePaddingX, CGRectGetMaxY(titleLabel.frame) + 10, 150, 12)];
        [buyerLabel setFont:[UIFont systemFontOfSize:12]];
        [buyerLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        buyerLabel.text = [NSString stringWithFormat:@"收件人：%@",orderModel.buyerName];
        [itemView_addressInfo addSubview:buyerLabel];
        
        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - kSpacePaddingX - 150, CGRectGetMinY(buyerLabel.frame), 150, 12)];
        [phoneLabel setFont:[UIFont systemFontOfSize:12]];
        phoneLabel.textAlignment = NSTextAlignmentRight;
        [phoneLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        phoneLabel.text = [NSString stringWithFormat:@"联系方式：%@",orderModel.buyerPhone];
        [itemView_addressInfo addSubview:phoneLabel];
        
        UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacePaddingX, CGRectGetMaxY(phoneLabel.frame) + 10, self.width - 2*kSpacePaddingX, 12)];
        [addressLabel setFont:[UIFont systemFontOfSize:12]];
        [addressLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",orderModel.buyerAddress];
        [itemView_addressInfo addSubview:addressLabel];
        
        UIView *LineView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addressLabel.frame) + 10, self.width, 0.5)];
        LineView.opaque = YES;
        LineView.backgroundColor =[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [itemView_addressInfo addSubview:LineView];

        UILabel *logisticsInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacePaddingX, CGRectGetMaxY(LineView.frame) + 10, self.width - 2*kSpacePaddingX, 14)];
        [logisticsInfoLabel setFont:[UIFont systemFontOfSize:14]];
        [logisticsInfoLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        logisticsInfoLabel.text = [NSString stringWithFormat:@"物流信息：%@",orderModel.buyerAddress];
        [itemView_addressInfo addSubview:logisticsInfoLabel];

    }
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:itemView_addressInfo];
    item.padding = CSLinearLayoutMakePadding(kPadding, 0,kPadding, 0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    item.verticalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
    [myInfoContainer addItem:item];
}

- (void)initItemView_orderInfo
{
    if(!itemView_orderInfo)
    {
        itemView_orderInfo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, itemView_orderInfo_height)];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kSpacePaddingX, kSpacePaddingY, 50, 50)];
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:orderModel.imgUrl]]];
        [itemView_orderInfo addSubview:imageView];
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - kSpacePaddingX - 80, kSpacePaddingY, 80, 12)];
        priceLabel.textAlignment = NSTextAlignmentRight;
        [priceLabel setFont:[UIFont systemFontOfSize:12]];
        [priceLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
        priceLabel.text = [NSString stringWithFormat:@"￥%@",orderModel.oriPrice];
        [itemView_orderInfo addSubview:priceLabel];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, kSpacePaddingY, CGRectGetMinX(priceLabel.frame) - CGRectGetMaxX(imageView.frame) - 15, 12)];
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        [titleLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        titleLabel.text = orderModel.title;
        [self addSubview:titleLabel];
        
        UILabel *sizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, CGRectGetMaxY(titleLabel.frame) + 10, 60, 12)];
        [sizeLabel setFont:[UIFont systemFontOfSize:12]];
        [sizeLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
        [itemView_orderInfo addSubview:sizeLabel];
        
        UILabel *buyNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sizeLabel.frame) + 10, CGRectGetMinY(sizeLabel.frame), 60, 12)];
        [buyNumLabel setFont:[UIFont systemFontOfSize:12]];
        [buyNumLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
        [itemView_orderInfo addSubview:buyNumLabel];
        
        UILabel *colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, CGRectGetMaxY(sizeLabel.frame) + 5, 100, 12)];
        [colorLabel setFont:[UIFont systemFontOfSize:12]];
        [colorLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
        [itemView_orderInfo addSubview:colorLabel];
        
        NSArray *skuList = orderModel.skuList;
        for(KSOrderSKUModel *orderSku in skuList)
        {
            NSString *propertyName = orderSku.propertyName;
            if([propertyName isEqualToString:@"颜色"])
            {
                colorLabel.text = [NSString stringWithFormat:@"颜色：%@",orderSku.value];
                
            }else if ([propertyName isEqualToString:@"尺码"])
            {
                sizeLabel.text = [NSString stringWithFormat:@"尺码：%@",orderSku.value];
            }
        }
        
        buyNumLabel.text = [NSString stringWithFormat:@"数量：%@",orderModel.buyNum];
        
        UIButton *btn_service = [[UIButton alloc]initWithFrame:CGRectMake(self.width - kSpacePaddingX - 70, CGRectGetMaxY(colorLabel.frame) - 22, 70, 22)];
        [btn_service.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn_service setTitle:@"申请售后" forState:UIControlStateNormal];
        btn_service.layer.borderWidth = 0.5;
        btn_service.layer.cornerRadius = 3;
        [btn_service setTitleColor:[TBDetailUIStyle colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        btn_service.layer.borderColor = [[TBDetailUIStyle colorWithHexString:@"#666666"]CGColor];
        [itemView_orderInfo addSubview:btn_service];

        UIView *LineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, self.width, 0.5)];
        LineView1.opaque = YES;
        LineView1.backgroundColor =[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [itemView_orderInfo addSubview:LineView1];
        
        UILabel *expenseLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacePaddingX, CGRectGetMaxY(LineView1.frame) + 10, 50, 12)];
        [expenseLabel setFont:[UIFont systemFontOfSize:12]];
        [expenseLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        expenseLabel.text = @"运费：";
        [itemView_orderInfo addSubview:expenseLabel];
        
        UILabel *expenseValueLable = [[UILabel alloc]initWithFrame:CGRectMake(self.width - kSpacePaddingX - 100, CGRectGetMinY(expenseLabel.frame), 100, 12)];
        [expenseValueLable setFont:[UIFont systemFontOfSize:12]];
        [expenseValueLable setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        expenseValueLable.textAlignment = NSTextAlignmentRight;
        expenseValueLable.text = @"免邮";
        [itemView_orderInfo addSubview:expenseValueLable];
        
        UILabel *discountLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacePaddingX, CGRectGetMaxY(expenseLabel.frame) + 10, 50, 12)];
        [discountLabel setFont:[UIFont systemFontOfSize:12]];
        [discountLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        discountLabel.text = @"优惠折扣：";
        [itemView_orderInfo addSubview:discountLabel];
        
        UILabel *discountValueLable = [[UILabel alloc]initWithFrame:CGRectMake(self.width - kSpacePaddingX - 100, CGRectGetMinY(discountLabel.frame), 100, 12)];
        [discountValueLable setFont:[UIFont systemFontOfSize:12]];
        [discountValueLable setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        discountValueLable.textAlignment = NSTextAlignmentRight;
        NSInteger discountValue = [orderModel.discount integerValue];
        discountValue = discountValue * 10;
        discountValueLable.text = [NSString stringWithFormat:@"%ld折",(long)discountValue];
        [itemView_orderInfo addSubview:discountValueLable];

        UILabel *redPacketLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacePaddingX, CGRectGetMaxY(discountLabel.frame) + 10, 50, 12)];
        [redPacketLabel setFont:[UIFont systemFontOfSize:12]];
        [redPacketLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        redPacketLabel.text = @"红包：";
        [itemView_orderInfo addSubview:redPacketLabel];
        
        UILabel *redPacketValueLable = [[UILabel alloc]initWithFrame:CGRectMake(self.width - kSpacePaddingX - 100, CGRectGetMinY(redPacketLabel.frame), 100, 12)];
        [redPacketValueLable setFont:[UIFont systemFontOfSize:12]];
        [redPacketValueLable setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        redPacketValueLable.textAlignment = NSTextAlignmentRight;
        redPacketValueLable.text = [NSString stringWithFormat:@"￥%@",orderModel.voucher];
        [itemView_orderInfo addSubview:redPacketValueLable];
        
        UILabel *payLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacePaddingX, CGRectGetMaxY(redPacketLabel.frame) + 10, 50, 12)];
        [payLabel setFont:[UIFont systemFontOfSize:12]];
        [payLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        payLabel.text = @"实付款：";
        [itemView_orderInfo addSubview:payLabel];
        
        UILabel *payValueLable = [[UILabel alloc]initWithFrame:CGRectMake(self.width - kSpacePaddingX - 100, CGRectGetMinY(payLabel.frame), 100, 12)];
        [payValueLable setFont:[UIFont systemFontOfSize:12]];
        [payValueLable setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
        payValueLable.textAlignment = NSTextAlignmentRight;
        payValueLable.text = [NSString stringWithFormat:@"￥%@",orderModel.payPrice];
        [itemView_orderInfo addSubview:payValueLable];

        UIView *LineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(payLabel.frame) + 10, self.width, 0.5)];
        LineView2.opaque = YES;
        LineView2.backgroundColor =[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [itemView_orderInfo addSubview:LineView2];
    }
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:itemView_orderInfo];
    item.padding = CSLinearLayoutMakePadding(kPadding, 0,kPadding, 0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    item.verticalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
    [myInfoContainer addItem:item];
}

- (void)initItemView_orderDeal
{
    
}

- (void)didSelectedServiceButton
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
