//
//  ManWuAddressBottomVIew.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressBottomVIew.h"
#import "TBDetailSKUButton.h"

@interface ManWuAddressBottomVIew()

@property (nonatomic, strong) TBDetailSKUButton          *selectBtn;

@end

@implementation ManWuAddressBottomVIew

-(void)setupView{
    [super setupView];
    [self setBackgroundColor:RGB(0xf8, 0xf8, 0xf8)];
    [self addSubview:self.selectBtn];
}

- (TBDetailSKUButton *)selectBtn {
    if (!_selectBtn) {
        CGRect frame = CGRectMake((self.width - 290)/2, (self.height - 30)/2, 290, 30);
        _selectBtn = [[TBDetailSKUButton alloc] initWithFrame:frame];
        _selectBtn.layer.cornerRadius = 5.0;
        _selectBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _selectBtn.layer.borderWidth = 0.5;
        [_selectBtn setTitleColor:RGB(0x66, 0x66, 0x66)
                         forState:UIControlStateNormal];
        [_selectBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:RGB(0xf5, 0xf5, 0xf5) forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(void)selectBtnClick:(TBDetailSKUButton*)sender{
    if (self.addressBottomClick) {
        self.addressBottomClick();
    }
}

@end
