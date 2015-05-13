//
//  ManWuAddressSetDefaultView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressSetDefaultView.h"

@interface ManWuAddressSetDefaultView()

@property (nonatomic, strong) UISwitch                   *addressSwitch;
@property (nonatomic, strong) UILabel                    *descriptionLabel;
@property (nonatomic, strong) UIView                     *endline;

@end

@implementation ManWuAddressSetDefaultView

-(void)setupView{
    [super setupView];
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.addressSwitch];
    [self addSubview:self.endline];
}

-(UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (self.height - 20)/2, 200, 20)];
        _descriptionLabel.text = @"设为默认收藏地址";
        [_descriptionLabel setTextColor:RGB(0x99, 0x99, 0x99)];
        _descriptionLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _descriptionLabel;
}

- (UISwitch *)addressSwitch {
    if (_addressSwitch == nil) {
        _addressSwitch = [[UISwitch alloc] init];
        [_addressSwitch setOrigin:CGPointMake(self.width - _addressSwitch.width - 15, (self.height - _addressSwitch.height)/2)];
        [_addressSwitch setOn:NO];
        [_addressSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _addressSwitch;
}

-(UIView *)endline{
    if (_endline == nil) {
        _endline = [TBDetailUITools drawDivisionLine:0
                                                yPos:self.height - 0.5
                                           lineWidth:self.width];
    }
    return _endline;
}

-(void)switchAction:(UISwitch*)sender{
    if (self.addressSwitchClick) {
        self.addressSwitchClick(sender.isOn);
    }
}

@end
