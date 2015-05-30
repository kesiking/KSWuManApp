//
//  ManWuVoucherView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuVoucherView.h"
#import "LMComBoxView.h"

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

@interface ManWuVoucherView() <LMComBoxViewDelegate>

@property (nonatomic, strong) UILabel           *textLabel;
@property (nonatomic, strong) UILabel           *detailTextLabel;
@property (nonatomic, strong) LMComBoxView      *comBox;
@property (nonatomic, strong) NSMutableArray    *voucherList;

@end


@implementation ManWuVoucherView

////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setupView{
    [super setupView];
    [self setClipsToBounds:NO];
    [self addSubview:self.textLabel];
    [self addSubview:self.detailTextLabel];
    [self addSubview:self.comBox];
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

- (LMComBoxView *)comBox {
    if (_comBox == nil) {
        _comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(self.width - 15 - caculateNumber(63), (self.height - 24)/2, caculateNumber(63), 24)];
        _comBox.backgroundColor = [UIColor whiteColor];
        _comBox.arrowImgName = @"down_dark0.png";
        _comBox.titlesList = self.voucherList;
        _comBox.delegate = self;
        _comBox.supView = self;
        [_comBox defaultSettings];
    }
    return _comBox;
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
//    if (![object isKindOfClass:[ManWuCommodityDetailModel class]]) {
//        return;
//    }
//    ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)object;
    
    if (![object isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.textLabel.text = @"红包";
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@",@""];
    self.voucherList = [object mutableCopy];
    self.comBox.titlesList = self.voucherList;
    [self.comBox reloadData];
}

#pragma mark -LMComBoxViewDelegate
-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    if (self.voucherList == nil || index >= [self.voucherList count]) {
        return;
    }
    self.voucherId =  [self.voucherList objectAtIndex:index];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 如果点击事件在currentSectionView中，则指定currentSectionView为响应对象
    CGPoint hitPoint = [self convertPoint:point fromView:self];
    BOOL isTextViewInsideHitPoint = CGRectContainsPoint(self.comBox.listTable.frame, hitPoint);
    if (isTextViewInsideHitPoint) {
        return self.comBox.listTable;
    }
    return [super hitTest:point withEvent:event];
}

@end
