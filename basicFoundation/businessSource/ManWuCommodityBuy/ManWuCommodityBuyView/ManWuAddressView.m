//
//  TBBuyAddressCell.m
//  TBBuy
//
//  Created by christ.yuj on 14-1-6.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "ManWuAddressView.h"
#import "ManWuAddressInfoModel.h"
#import "ManWuAddressManagerMaroc.h"
#import "ManWuAddressService.h"

#define kCellNormalHeight         86.0f
#define kCellSuperHeight         104.0f
#define kLocationIconSize         23.0f
#define kLocationIconMarginLeft   15.0f
#define kLocationIconMarginTop    12.0f
#define kTakeDeliveryLabelFontSize 16.0f
#define kIndicatorIconSize        17.0f
#define kOtherAddressButtonTop    10.0f
#define kOtherAddressButtonRight  15.0f
#define kOtherAddressButtonWidth  70.0f
#define kOtherAddressButtonHeight 23.0f
#define kAddAddressButtonWidth    110.f
#define kAddAddressButtonHeight   32.0f
#define kShipInfoMarginLeft       42.0f
#define kShipInfoMarginRight      33.0f
#define kShipInfoMarginTop        16.0f
#define kShipInfoMarginBottom     16.0f
#define kFullNameLabelWidth      140.0f
#define kFullNameLabelHeight      16.0f
#define kFullNameFontSize         12.0f
#define kPhoneNumFontSize         16.0f
#define kAddressLabelMarginTop     6.0f
#define kAddressLabelHeight       32.0f
#define kAddressFontSize          13.0f
#define kAgencyInfoLabelMarginTop  6.0f
#define kAgencyInfoLabelHeight    12.0f
#define kAgencyInfoFontSize       12.0f
#define kSeprateBackgroundViewHeight 14.0f

@interface ManWuAddressView ()

@property (nonatomic, strong) UIImageView *locationIcon;
@property (nonatomic, strong) UIImageView *indicatorIcon;
@property (nonatomic, strong) UILabel     *takeDeliveryLabel;
@property (nonatomic, strong) UIButton    *addAddressButton;
@property (nonatomic, strong) UIButton    *otherAddressButton;
@property (nonatomic, strong) UIView      *seprateLine;
@property (nonatomic, strong) UILabel     *fullNameLabel;
@property (nonatomic, strong) UILabel     *phoneNumLabel;
@property (nonatomic, strong) UILabel     *addressLabel;
@property (nonatomic, strong) UILabel     *agencyInfoLabel;
@property (nonatomic, strong) UIView      *seprateBackgroundView;
@property (nonatomic, strong) ManWuAddressService      *addressService;

@end

@implementation ManWuAddressView

#pragma mark - Initialize

-(void)setupView{
    [super setupView];
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:self.locationIcon];
    [self addSubview:self.takeDeliveryLabel];
    [self addSubview:self.addAddressButton];
    [self addSubview:self.otherAddressButton];
    [self addSubview:self.seprateLine];
    [self addSubview:self.fullNameLabel];
    [self addSubview:self.phoneNumLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.seprateBackgroundView];
    [self.addressService loadDefaultAddress];
}

#pragma mark - Private Accessor

- (UIImageView *)seperateLine {
    return nil;
}

- (UIImageView *)locationIcon {
    if (!_locationIcon) {
        CGFloat x = kLocationIconMarginLeft;
        CGFloat y = kLocationIconMarginTop;
        CGFloat w = kLocationIconSize;
        CGFloat h = kLocationIconSize;
        
        CGRect frame = CGRectMake(x, y, w, h);
        _locationIcon = [[UIImageView alloc] initWithFrame:frame];
        _locationIcon.image = [UIImage imageNamed:kLocationFileName];
        _locationIcon.contentMode = UIViewContentModeScaleAspectFit;
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

-(UILabel *)takeDeliveryLabel{
    if (!_takeDeliveryLabel) {
        CGFloat x = self.locationIcon.right + 4;
        CGFloat y = self.locationIcon.top + (self.locationIcon.height - kFullNameLabelHeight)/2;
        CGFloat w = kFullNameLabelWidth;
        CGFloat h = kFullNameLabelHeight;
        CGRect frame = CGRectMake(x, y, w, h);
        
        _takeDeliveryLabel = [[UILabel alloc] initWithFrame:frame];
        _takeDeliveryLabel.backgroundColor = [UIColor whiteColor];
        _takeDeliveryLabel.textColor = kTBBuyColorNB;
        _takeDeliveryLabel.font = [UIFont boldSystemFontOfSize:kTakeDeliveryLabelFontSize];
        _takeDeliveryLabel.text = @"收货";
    }
    return _takeDeliveryLabel;
}

-(UIButton *)otherAddressButton{
    if (_otherAddressButton == nil) {
        _otherAddressButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - kOtherAddressButtonWidth - kOtherAddressButtonRight, kOtherAddressButtonTop, kOtherAddressButtonWidth, kOtherAddressButtonHeight)];
        
        _otherAddressButton.titleLabel.font          = [TBDetailUIStyle fontWithStyle:TBDetailFontStyle_Chinese
                                                                    size:TBDetailFontSize_Title2];
        _otherAddressButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_otherAddressButton setTitle:@"其他地址" forState:UIControlStateNormal];
        
        [_otherAddressButton setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_SKUButtonColor]
                     forState:UIControlStateNormal];
        [_otherAddressButton.layer setBorderColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Price2].CGColor];
        [_otherAddressButton setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg2]];
        
        _otherAddressButton.layer.borderWidth  = 1.0;
        _otherAddressButton.layer.cornerRadius = 3.0;
        
        [_otherAddressButton addTarget:self action:@selector(otherAddressButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherAddressButton;
}

-(UIButton *)addAddressButton{
    if (_addAddressButton == nil) {
        _addAddressButton = [[UIButton alloc] initWithFrame:CGRectMake(self.locationIcon.left , self.locationIcon.bottom + 18, kAddAddressButtonWidth, kAddAddressButtonHeight)];
        
        _addAddressButton.titleLabel.font          = [TBDetailUIStyle fontWithStyle:TBDetailFontStyle_Chinese
                                                                                 size:TBDetailFontSize_Title2];
        _addAddressButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_addAddressButton setTitle:@"+ 添加收货地址" forState:UIControlStateNormal];
        
        [_addAddressButton setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_SKUButtonColor]
                                  forState:UIControlStateNormal];
        [_addAddressButton.layer setBorderColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Price2].CGColor];
        [_addAddressButton setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg2]];
        
        _addAddressButton.layer.borderWidth  = 1.0;
        _addAddressButton.layer.cornerRadius = 3.0;
        
        [_addAddressButton addTarget:self action:@selector(addAddressButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressButton;
}

-(UIView *)seprateLine{
    if (_seprateLine == nil) {
        _seprateLine = [TBDetailUITools drawDivisionLine:kLocationIconMarginLeft
                                                yPos:self.locationIcon.bottom + 8
                                           lineWidth:self.width - kLocationIconMarginLeft * 2];
        [_seprateLine setBackgroundColor:RGB(0xc7, 0xc7, 0xc7)];
    }
    return _seprateLine;
}

- (UILabel *)fullNameLabel {
    if (!_fullNameLabel) {
        CGFloat x = self.locationIcon.left;
        CGFloat y = self.locationIcon.bottom + 16;
        CGFloat w = kFullNameLabelWidth;
        CGFloat h = kFullNameLabelHeight;
        CGRect frame = CGRectMake(x, y, w, h);
        
        _fullNameLabel = [[UILabel alloc] initWithFrame:frame];
        _fullNameLabel.backgroundColor = [UIColor whiteColor];
        _fullNameLabel.textColor = kTBBuyColorNG;
        _fullNameLabel.font = [UIFont systemFontOfSize:kFullNameFontSize];
        _fullNameLabel.numberOfLines = 1;
    }
    return _fullNameLabel;
}

- (UILabel *)phoneNumLabel {
    if (!_phoneNumLabel) {
        CGFloat contentViewWidth = self.bounds.size.width;
        
        CGRect  fullNameLabelFrame   = self.fullNameLabel.frame;
        CGFloat fullNameLabelOriginY = fullNameLabelFrame.origin.y;
        CGFloat fullNameLabelWidth   = fullNameLabelFrame.size.width;
        CGFloat fullNameLabelHeight  = fullNameLabelFrame.size.height;
        CGFloat fullNameLabelRight   = self.width - fullNameLabelWidth - kLocationIconMarginLeft;
        
        CGFloat x = fullNameLabelRight;
        CGFloat y = fullNameLabelOriginY;
        CGFloat w = contentViewWidth - fullNameLabelRight;
        CGFloat h = fullNameLabelHeight;
        
        CGRect frame = CGRectMake(x, y, w, h);
        
        _phoneNumLabel = [[UILabel alloc] initWithFrame:frame];
        _phoneNumLabel.backgroundColor = [UIColor whiteColor];
        _phoneNumLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _phoneNumLabel.textAlignment = NSTextAlignmentRight;
        _phoneNumLabel.textColor = self.fullNameLabel.textColor;
        _phoneNumLabel.font = self.fullNameLabel.font;
    }
    return _phoneNumLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        CGFloat contentViewWidth = self.bounds.size.width;
        CGFloat x = self.fullNameLabel.left;
        CGFloat y = self.fullNameLabel.bottom;
        CGFloat w = contentViewWidth - self.fullNameLabel.left * 2;
        CGFloat h = kAddressLabelHeight;
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _addressLabel.backgroundColor = [UIColor whiteColor];
        _addressLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _addressLabel.numberOfLines = 4;
        _addressLabel.textColor = self.fullNameLabel.textColor;
        _addressLabel.font = self.fullNameLabel.font;
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

-(UIView *)seprateBackgroundView{
    if (_seprateBackgroundView == nil) {
        _seprateBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - kSeprateBackgroundViewHeight, self.width, kSeprateBackgroundViewHeight)];
        _seprateBackgroundView.backgroundColor = RGB(0xF0,0xF0,0xF0);
    }
    return _seprateBackgroundView;
}

-(ManWuAddressService *)addressService{
    if (_addressService == nil) {
        _addressService = [[ManWuAddressService alloc] init];
        WEAKSELF
        _addressService.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            if (service && service.item) {
                ManWuAddressInfoModel* addressModel = (ManWuAddressInfoModel*)service.item;
                [strongSelf setObject:addressModel dict:nil];
            }
        };
    }
    return _addressService;
}

-(void)otherAddressButtonClicked:(id)sender{
    WEAKSELF
    void (^successWrapper)(ManWuAddressInfoModel *addressModel) = ^(ManWuAddressInfoModel *addressModel) {
        STRONGSELF
        if (strongSelf.viewController) {
            [strongSelf.viewController.navigationController popToViewController:strongSelf.viewController animated:YES];
        }
        [strongSelf setObject:addressModel];
    };
    
    void (^failureWrapper)() = ^() {
        STRONGSELF
        if (strongSelf.viewController) {
            [strongSelf.viewController.navigationController popToViewController:strongSelf.viewController animated:YES];
        }
        [WeAppToast toast:@"出错误啦"];
    };
    NSDictionary *callBacks =[NSDictionary dictionaryWithObjectsAndKeys:successWrapper, kAddressSelectedSuccessBlock,failureWrapper, kAddressSelectedFailureBlock, nil];
    TBOpenURLFromTargetWithNativeParams(kManWuAddressSelect, self, nil, callBacks);
}

-(void)addAddressButtonClicked:(id)sender{
    WEAKSELF
    addressDidChangeBlock addressDidChangeBlock = ^(BOOL addressDidChange,WeAppComponentBaseItem* addressComponentItem){
        STRONGSELF
        [strongSelf setObject:addressComponentItem];
    };
    NSDictionary *callBacks =[NSDictionary dictionaryWithObjectsAndKeys:addressDidChangeBlock, kAddressSelectedSuccessBlock, nil];
    TBOpenURLFromSourceAndParams(kManWuAddressManager, self, callBacks);
}

#pragma mark  - TBTradeCellDelegate

- (void)setObject:(id)object {
    if (![object isKindOfClass:[ManWuAddressInfoModel class]]) {
        return;
    }
    ManWuAddressInfoModel* addressModel = (ManWuAddressInfoModel*)object;
    
    self.addressId = addressModel.addressId;
    
    self.addAddressButton.hidden = YES;
    self.fullNameLabel.text = [NSString stringWithFormat:@"收货人：%@", addressModel.recvName ?: @""];
    self.phoneNumLabel.text = [NSString stringWithFormat:@"联系方式：%@", addressModel.phoneNum];
    self.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",
                              addressModel.address];
    
    [self.fullNameLabel sizeToFit];
    [self.phoneNumLabel sizeToFit];
    [self.addressLabel sizeToFit];

    CGFloat phoneNumLabelOrigineX = self.width - self.phoneNumLabel.width - kLocationIconMarginLeft;
    [self.phoneNumLabel setOrigin:CGPointMake(phoneNumLabelOrigineX, self.phoneNumLabel.origin.y)];
    
    [self sizeToFit];
    
    [self.endline setOrigin:CGPointMake(self.endline.origin.x, self.height - self.endline.height - self.seprateBackgroundView.height)];
    [self.seprateBackgroundView setOrigin:CGPointMake(self.seprateBackgroundView.origin.x, self.height - self.seprateBackgroundView.height)];
//    self.model = object;
//    
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
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Override

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGSize newSize = size;
    
    if (self.addressLabel.text || self.fullNameLabel.text) {
        newSize.height = 80 + self.seprateBackgroundView.height + self.addressLabel.height;
    }else{
        newSize.height = 63 + self.seprateBackgroundView.height;
    }
    
    return newSize;
}

@end
