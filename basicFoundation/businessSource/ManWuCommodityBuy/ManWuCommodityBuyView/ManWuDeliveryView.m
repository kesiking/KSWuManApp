//
//  TBBuyDeliveryMethodCell.m
//  TBBuy
//
//  Created by christ.yuj on 14-1-7.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "ManWuDeliveryView.h"
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
//    CGFloat x = self.width - kArrowSize - 8.0f;
//    CGFloat y = (self.height - kArrowSize)/2;
//    CGFloat w = kArrowSize;
//    CGFloat h = kArrowSize;
//    CGRect frame = CGRectMake(x, y, w, h);
    
//    UIImageView *arrow = [[UIImageView alloc] initWithFrame:frame];
//    arrow.image = [UIImage imageNamed:kArrowFileName];
//    self.accessoryView = arrow;
//    [self addSubview:self.accessoryView];
    
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

- (void)setObject:(id)object dict:(NSDictionary *)dict{
    [super setObject:object dict:dict];
    if (![object isKindOfClass:[ManWuCommodityDetailModel class]]) {
        return;
    }
    ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)object;
    NSString *name = @"快递", *date = @"", *period = @"";
    self.textLabel.text = @"配送方式";

    if (1) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"M月d日"];
        
        NSString *dateString = [formatter stringFromDate:@"2015-11-12"];
        date = dateString ? dateString : @"";
        period = @"免邮费";
    }
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ %@", name, date, period];

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
