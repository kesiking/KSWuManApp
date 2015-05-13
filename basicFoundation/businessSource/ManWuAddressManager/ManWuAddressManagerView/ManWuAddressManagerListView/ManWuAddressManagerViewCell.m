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
    if (addressInfoComponentItem.isDefaultAddress) {
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
    self.phoneNumLabel.text = [NSString stringWithFormat:@"联系方式：%@",addressInfoComponentItem.phoneNum];
}

- (void)didSelectCellWithCellView:(id<KSViewCellProtocol>)cell componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    
}

@end
