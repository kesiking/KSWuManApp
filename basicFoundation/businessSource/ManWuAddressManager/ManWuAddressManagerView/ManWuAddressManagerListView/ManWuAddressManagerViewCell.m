//
//  ManWuAddressManagerViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressManagerViewCell.h"
#import "ManWuAddressInfoModel.h"

@implementation ManWuAddressManagerViewCell

+(id)createView{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    if ([nibContents count] > 0) {
        id object = [nibContents objectAtIndex:0];
        if (object && [object isKindOfClass:[self class]])
        {
            return object;
        }
    }
    return nil;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.seprateBackgroundView setFrame:CGRectMake(self.seprateBackgroundView.origin.x, self.height - self.seprateBackgroundView.height, self.width, self.seprateBackgroundView.height)];
    [self.phoneNumLabel setOrigin:CGPointMake(self.width - self.phoneNumLabel.width - 18 * SCREEN_SCALE, self.phoneNumLabel.origin.y)];
    [self.addressLabel setFrame:CGRectMake(self.addressLabel.origin.x, self.fullNameLabel.bottom + 10 * SCREEN_SCALE, self.width - 15 * 2 * SCREEN_SCALE, self.addressLabel.height)];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [ManWuAddressManagerViewCell createView];
    if (self) {
        self.frame = frame;
        [self setupView];
    }
    return self;
}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    ManWuAddressInfoModel* addressInfoComponentItem = (ManWuAddressInfoModel*)componentItem;
    if (addressInfoComponentItem.defaultAddress) {
        self.phoneNumLabel.textColor = RGB(0xff, 0xff, 0xff);
        self.addressLabel.textColor = RGB(0xff, 0xff, 0xff);
        self.fullNameLabel.textColor = RGB(0xff, 0xff, 0xff);
        self.backgroundColor = RGB(0xfb, 0x88, 0x54);
    }else{
        self.phoneNumLabel.textColor = RGB(0x66, 0x66, 0x66);
        self.addressLabel.textColor = RGB(0x66, 0x66, 0x66);
        self.fullNameLabel.textColor = RGB(0x66, 0x66, 0x66);
        self.backgroundColor = RGB(0xff, 0xff, 0xff);
    }
    
    self.fullNameLabel.text = [NSString stringWithFormat:@"收货人：%@",addressInfoComponentItem.recvName];
    self.phoneNumLabel.text = [NSString stringWithFormat:@"联系方式：%@",addressInfoComponentItem.phoneNum];
    self.addressLabel.text = [[NSString stringWithFormat:@"收货地址：%@",addressInfoComponentItem.address] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    self.fullNameLabel.hidden = addressInfoComponentItem.recvName ? NO : YES;
    self.phoneNumLabel.hidden = addressInfoComponentItem.phoneNum ? NO : YES;
    self.addressLabel.hidden = addressInfoComponentItem.address ? NO : YES;
}

- (void)didSelectCellWithCellView:(id<KSViewCellProtocol>)cell componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    
}

@end
