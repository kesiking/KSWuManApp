//
//  TBBuyAddressCell.m
//  TBBuy
//
//  Created by christ.yuj on 14-1-6.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "ManWuAddressView.h"

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

@interface ManWuAddressView ()

@property (nonatomic, strong) UIImageView *locationIcon;
@property (nonatomic, strong) UIImageView *indicatorIcon;
@property (nonatomic, strong) UILabel     *fullNameLabel;
@property (nonatomic, strong) UILabel     *phoneNumLabel;
@property (nonatomic, strong) UILabel     *addressLabel;
@property (nonatomic, strong) UILabel     *agencyInfoLabel;

@end

@implementation ManWuAddressView

#pragma mark - Initialize

-(void)setupView{
    [super setupView];
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:self.locationIcon];
    [self addSubview:self.fullNameLabel];
    [self addSubview:self.phoneNumLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.agencyInfoLabel];
}

#pragma mark - Private Accessor

- (UIImageView *)seperateLine {
    return nil;
}

- (UIImageView *)locationIcon {
    if (!_locationIcon) {
        CGFloat cellHeight = self.bounds.size.height;
        
        CGFloat x = kLocationIconMarginLeft;
        CGFloat y = (cellHeight / 2) - (kLocationIconSize / 2);
        CGFloat w = kLocationIconSize;
        CGFloat h = kLocationIconSize;
        
        CGRect frame = CGRectMake(x, y, w, h);
        _locationIcon = [[UIImageView alloc] initWithFrame:frame];
        _locationIcon.image = [UIImage imageNamed:kLocationFileName];
        _locationIcon.contentMode = UIViewContentModeScaleAspectFit;
        _locationIcon.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
                | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _locationIcon;
}

- (UIImageView *)indicatorIcon {
    if (!_indicatorIcon) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat w = kIndicatorIconSize;
        CGFloat h = kIndicatorIconSize;
        CGRect frame = CGRectMake(x, y, w, h);
        
        _indicatorIcon = [[UIImageView alloc] initWithFrame:frame];
        _indicatorIcon.image = [UIImage imageNamed:kArrowFileName];
    }
    return _indicatorIcon;
}

- (UILabel *)fullNameLabel {
    if (!_fullNameLabel) {
        CGFloat x = kShipInfoMarginLeft;
        CGFloat y = kShipInfoMarginTop;
        CGFloat w = kFullNameLabelWidth;
        CGFloat h = kFullNameLabelHeight;
        CGRect frame = CGRectMake(x, y, w, h);
        
        _fullNameLabel = [[UILabel alloc] initWithFrame:frame];
        _fullNameLabel.backgroundColor = [UIColor whiteColor];
        _fullNameLabel.textColor = kTBBuyColorNA;
        _fullNameLabel.font = [UIFont systemFontOfSize:kFullNameFontSize];
    }
    return _fullNameLabel;
}

- (UILabel *)phoneNumLabel {
    if (!_phoneNumLabel) {
        CGFloat contentViewWidth = self.bounds.size.width;
        
        CGRect  fullNameLabelFrame   = self.fullNameLabel.frame;
        CGFloat fullNameLabelOriginX = fullNameLabelFrame.origin.x;
        CGFloat fullNameLabelOriginY = fullNameLabelFrame.origin.y;
        CGFloat fullNameLabelWidth   = fullNameLabelFrame.size.width;
        CGFloat fullNameLabelHeight  = fullNameLabelFrame.size.height;
        CGFloat fullNameLabelRight   = fullNameLabelOriginX + fullNameLabelWidth;
        
        CGFloat x = fullNameLabelRight;
        CGFloat y = fullNameLabelOriginY;
        CGFloat w = contentViewWidth - fullNameLabelRight;
        CGFloat h = fullNameLabelHeight;
        
        CGRect frame = CGRectMake(x, y, w, h);
        
        _phoneNumLabel = [[UILabel alloc] initWithFrame:frame];
        _phoneNumLabel.backgroundColor = [UIColor whiteColor];
        _phoneNumLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _phoneNumLabel.textAlignment = NSTextAlignmentRight;
        _phoneNumLabel.textColor = kTBBuyColorNA;
        _phoneNumLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                              size:kPhoneNumFontSize];
    }
    return _phoneNumLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        CGFloat contentViewWidth = self.bounds.size.width;
        
        CGRect  fullNameLabelFrame   = self.fullNameLabel.frame;
        CGFloat fullNameLabelOriginY = fullNameLabelFrame.origin.y;
        CGFloat fullNameLabelHeight  = fullNameLabelFrame.size.height;
        
        CGFloat x = kShipInfoMarginLeft;
        CGFloat y = fullNameLabelOriginY + fullNameLabelHeight + kAddressLabelMarginTop;
        CGFloat w = contentViewWidth - kShipInfoMarginLeft;
        CGFloat h = kAddressLabelHeight;
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _addressLabel.backgroundColor = [UIColor whiteColor];
        _addressLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _addressLabel.numberOfLines = 2;
        _addressLabel.textColor = kTBBuyColorNA;
        _addressLabel.font = [UIFont systemFontOfSize:kAddressFontSize];
    }
    return _addressLabel;
}

- (UILabel *)agencyInfoLabel {
    if (!_agencyInfoLabel) {
        CGRect  addressLabelFrame   = self.addressLabel.frame;
        CGFloat addressLabelOriginX = addressLabelFrame.origin.x;
        CGFloat addressLabelOriginY = addressLabelFrame.origin.y;
        CGFloat addressLabelHeight  = addressLabelFrame.size.height;
        CGFloat addressLabelWidth   = addressLabelFrame.size.width;
        
        CGFloat x = addressLabelOriginX;
        CGFloat y = addressLabelOriginY + addressLabelHeight + kAgencyInfoLabelMarginTop;
        CGFloat w = addressLabelWidth;
        CGFloat h = kAgencyInfoLabelHeight;
        
        CGRect frame = CGRectMake(x, y, w, h);
        
        _agencyInfoLabel = [[UILabel alloc] initWithFrame:frame];
        _agencyInfoLabel.backgroundColor = [UIColor whiteColor];
        _agencyInfoLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _agencyInfoLabel.font = [UIFont systemFontOfSize:kAgencyInfoFontSize];
        _agencyInfoLabel.textColor = kTBBuyColorNB;
    }
    return _agencyInfoLabel;
}

#pragma mark  - TBTradeCellDelegate

//- (void)setObject:(id)object {
//    self.model = object;
    
//    TBTradeAddressModel *addressModel = (TBTradeAddressModel *)object;
//    TBTradeAddressOption *option = addressModel.selectedOption;
//    if (!option) {
//        return;
//    }
//    
//    self.fullNameLabel.text = [NSString stringWithFormat:@"收货人：%@", option.fullName ?: @""];
//    self.phoneNumLabel.text = option.mobile ?: @"";
//            
//    self.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@%@%@%@%@%@",
//            option.countryName ?: @"", option.provinceName  ?: @"",
//            option.cityName    ?: @"", option.areaName      ?: @"",
//            option.townName    ?: @"", option.addressDetail ?: @""];
//            
//    if (addressModel.agencyReceive != TBTradeAgencyReceiveTypeNotSupport) {
//        self.agencyInfoLabel.text = option.agencyReceiveDesc;
//    } else {
//        self.agencyInfoLabel.text = @"";
//    }
//}

@end
