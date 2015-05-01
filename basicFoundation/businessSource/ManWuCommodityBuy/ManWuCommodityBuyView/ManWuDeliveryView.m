//
//  TBBuyDeliveryMethodCell.m
//  TBBuy
//
//  Created by christ.yuj on 14-1-7.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "ManWuDeliveryView.h"

#define kCellNormalHeight         86.0f
#define kCellSuperHeight         104.0f
#define kLocationIconSize         23.0f
#define kLocationIconMarginLeft   12.0f
#define kIndicatorIconSize        17.0f
#define kShipInfoMarginLeft       42.0f
#define kShipInfoMarginRight      33.0f
#define kShipInfoMarginTop        16.0f
#define kShipInfoMarginBottom     16.0f
#define kFullNameLabelWidth      140.0f
#define kFullNameLabelHeight      16.0f
#define kFullNameFontSize         16.0f
#define kPhoneNumFontSize         16.0f
#define kAddressLabelMarginTop     6.0f
#define kAddressLabelHeight       32.0f
#define kAddressFontSize          13.0f
#define kAgencyInfoLabelMarginTop  6.0f
#define kAgencyInfoLabelHeight    12.0f
#define kAgencyInfoFontSize       12.0f


@interface ManWuDeliveryView ()

@property (nonatomic, strong) UIButton          *selectBtn;
@property (nonatomic, strong) UIImageView       *accessoryView;
@property (nonatomic, strong) UILabel           *textLabel;
@property (nonatomic, strong) UILabel           *detailTextLabel;

@end

@implementation ManWuDeliveryView

////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setupView{
    [super setupView];
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    CGFloat w = kArrowSize;
    CGFloat h = kArrowSize;
    CGRect frame = CGRectMake(x, y, w, h);
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:frame];
    arrow.image = [UIImage imageNamed:kArrowFileName];
    self.accessoryView = arrow;
    [self addSubview:self.accessoryView];
    
    self.textLabel.font = [UIFont systemFontOfSize:TBBUY_FONT_4];
    self.textLabel.textColor = kTBBuyColorNA;
    [self addSubview:self.textLabel];
    
    self.detailTextLabel.font = [UIFont systemFontOfSize:TBBUY_FONT_4];
    self.detailTextLabel.textColor = kTBBuyColorNA;
    self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping
    | NSLineBreakByTruncatingTail;
    [self addSubview:self.detailTextLabel];
}

- (UILabel *)detailTextLabel {
    if (!_detailTextLabel) {
        CGFloat x = kShipInfoMarginLeft;
        CGFloat y = self.textLabel.bottom;
        CGFloat w = kFullNameLabelWidth;
        CGFloat h = kFullNameLabelHeight;
        CGRect frame = CGRectMake(x, y, w, h);
        
        _detailTextLabel = [[UILabel alloc] initWithFrame:frame];
        _detailTextLabel.backgroundColor = [UIColor whiteColor];
        _detailTextLabel.textColor = kTBBuyColorNA;
        _detailTextLabel.font = [UIFont systemFontOfSize:kFullNameFontSize];
    }
    return _detailTextLabel;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        CGFloat x = kShipInfoMarginLeft;
        CGFloat y = kShipInfoMarginTop;
        CGFloat w = kFullNameLabelWidth;
        CGFloat h = kFullNameLabelHeight;
        CGRect frame = CGRectMake(x, y, w, h);
        
        _textLabel = [[UILabel alloc] initWithFrame:frame];
        _textLabel.backgroundColor = [UIColor whiteColor];
        _textLabel.textColor = kTBBuyColorNA;
        _textLabel.font = [UIFont systemFontOfSize:kFullNameFontSize];
    }
    return _textLabel;
}


#pragma mark - Override

- (void)setObject:(id)object {
//    self.model = object;
//    
//    TBTradeDeliveryMethodModel *deliveryModel = (TBTradeDeliveryMethodModel *)self.model;
//    TBTradeDeliveryMethodOption *option = (TBTradeDeliveryMethodOption *)[deliveryModel getSelectOptionById:deliveryModel.selectedId];
//    
//    self.textLabel.text = deliveryModel.title;
//    
//    NSString *name = option.name, *date = @"", *period = @"";
//    if (option.enableDataPicker) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"M月d日"];
//        
//        NSString *dateString = [formatter stringFromDate:option.datePicker.selectedDate];
//        date = dateString ? dateString : @"";
//        period = option.datePicker.selectedPeriods;
//    }
//    self.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ %@", name, date, period];
//    
//    self.selectBtn.enabled = deliveryModel.status != TBTradeComponentStatusDisable;
}

@end
