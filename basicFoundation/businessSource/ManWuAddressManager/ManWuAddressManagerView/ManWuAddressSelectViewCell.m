//
//  ManWuAddressManagerViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressSelectViewCell.h"
#import "ManWuAddressInfoModel.h"

@implementation ManWuAddressSelectViewCell

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
    self = [ManWuAddressSelectViewCell createView];
    if (self) {
        self.frame = frame;
        [self setupView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.seprateBackgroundView setFrame:CGRectMake(self.seprateBackgroundView.origin.x, self.height - self.seprateBackgroundView.height, self.width, self.seprateBackgroundView.height)];
    [self.phoneNumLabel setOrigin:CGPointMake(self.width - self.phoneNumLabel.width - 18, self.phoneNumLabel.origin.y)];
    [self.addressLabel setWidth:self.width - 15 * 2];

}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    ManWuAddressInfoModel* addressInfoComponentItem = (ManWuAddressInfoModel*)componentItem;
    if (addressInfoComponentItem.defaultAddress) {
        self.addressIcon.backgroundColor = [UIColor redColor];
    }else{
        self.addressIcon.backgroundColor = [UIColor greenColor];
    }
    self.fullNameLabel.text = [NSString stringWithFormat:@"收货人:%@",addressInfoComponentItem.recvName];
    self.phoneNumLabel.text = [NSString stringWithFormat:@"联系方式:%@",addressInfoComponentItem.phoneNum];
    self.addressLabel.text = [NSString stringWithFormat:@"收货地址:%@",addressInfoComponentItem.address];
    
    self.fullNameLabel.hidden = addressInfoComponentItem.recvName ? NO : YES;
    self.phoneNumLabel.hidden = addressInfoComponentItem.phoneNum ? NO : YES;
    self.addressLabel.hidden = addressInfoComponentItem.address ? NO : YES;

}

- (void)didSelectCellWithCellView:(id<KSViewCellProtocol>)cell componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    
}

@end
