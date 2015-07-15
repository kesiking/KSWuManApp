//
//  ManWuPreferentialView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuPreferentialView.h"
#import "ManWuCommodityDetailModel.h"

#define kCellNormalHeight         86.0f
#define kCellSuperHeight         104.0f
#define kLocationIconSize         23.0f
#define kLocationIconMarginLeft   12.0f
#define kIndicatorIconSize        17.0f
#define kShipInfoMarginLeft       15.0f
#define kShipInfoMarginRight      33.0f
#define kShipInfoMarginTop        16.0f
#define kShipInfoMarginBottom     16.0f
#define kFullNameLabelWidth      140.0f
#define kFullNameLabelHeight      16.0f
#define kFullNameFontSize         15.0f
#define kPhoneNumFontSize         16.0f
#define kAddressLabelMarginTop     6.0f
#define kAddressLabelHeight       32.0f
#define kAddressFontSize          13.0f
#define kAgencyInfoLabelMarginTop  6.0f
#define kAgencyInfoLabelHeight    12.0f
#define kAgencyInfoFontSize       12.0f

@interface ManWuPreferentialView()

@property (nonatomic, strong) UILabel           *textLabel;
@property (nonatomic, strong) UILabel           *detailTextLabel;

@end

@implementation ManWuPreferentialView

////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setupView{
    [super setupView];
    [self addSubview:self.textLabel];
    [self addSubview:self.detailTextLabel];
}

- (UILabel *)detailTextLabel {
    if (!_detailTextLabel) {
        CGFloat x = self.width - kFullNameLabelWidth - kShipInfoMarginLeft;
        CGFloat y = self.textLabel.top;
        CGFloat w = kFullNameLabelWidth;
        CGFloat h = kFullNameLabelHeight;
        CGRect frame = CGRectMake(x, y, w, h);
        
        _detailTextLabel = [[UILabel alloc] initWithFrame:frame];
        _detailTextLabel.backgroundColor = [UIColor whiteColor];
        _detailTextLabel.textColor = kTBBuyColorNA;
        _detailTextLabel.font = [UIFont systemFontOfSize:kFullNameFontSize];
        _detailTextLabel.textAlignment = NSTextAlignmentRight;
        _detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    }
    return _detailTextLabel;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        CGFloat x = kShipInfoMarginLeft;
        CGFloat y = (self.height - kFullNameLabelHeight)/2;
        CGFloat w = kFullNameLabelWidth;
        CGFloat h = kFullNameLabelHeight;
        CGRect frame = CGRectMake(x, y, w, h);
        
        _textLabel = [[UILabel alloc] initWithFrame:frame];
        _textLabel.backgroundColor = [UIColor whiteColor];
        _textLabel.textColor = kTBBuyColorNB;
        _textLabel.font = [UIFont boldSystemFontOfSize:kFullNameFontSize];
    }
    return _textLabel;
}


#pragma mark - Override

- (void)setObject:(id)object dict:(NSDictionary *)dict {
    if (![object isKindOfClass:[ManWuCommodityDetailModel class]]) {
        return;
    }
    ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)object;

    self.textLabel.text = @"优惠折扣";
    
    NSNumber* salePrice = [dict objectForKey:@"skuPrice"]?:detailModel.sale;
    
    if (salePrice == nil) {
        salePrice = detailModel.price;
    }
    CGFloat discount = 0;
    NSString* discountStr = [NSString stringWithFormat:@"%@",detailModel.discount];
    if (detailModel.price && [detailModel.price floatValue] != 0) {
        discount = [salePrice floatValue] / [detailModel.price floatValue];
    }
    if (discount > 0 && discount < 1) {
        discountStr = [NSString stringWithFormat:@"%.1f折",discount * 10];
    }
    self.detailTextLabel.text = discountStr;
}

@end
