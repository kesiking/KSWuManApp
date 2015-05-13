//
//  ManWuAddAddressView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddAddressView.h"
#import "TBDetailSKUButton.h"

@interface ManWuAddAddressView()

@property (nonatomic, strong) TBDetailSKUButton          *selectBtn;
@property (nonatomic, strong) UIView                     *endline;

@end

@implementation ManWuAddAddressView

-(void)setupView{
    [super setupView];
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.selectBtn];
    [self addSubview:self.endline];
}

- (TBDetailSKUButton *)selectBtn {
    if (!_selectBtn) {
        CGRect frame = CGRectMake(0, 0, self.width, self.height);
        _selectBtn = [[TBDetailSKUButton alloc] initWithFrame:frame];
        _selectBtn.layer.cornerRadius = 5.0;
        [_selectBtn setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Title1 alpha:1]
                         forState:UIControlStateNormal];
        [_selectBtn setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Tag alpha:0.2]
                         forState:UIControlStateDisabled];
        [_selectBtn setTitleColor:[UIColor colorWithRed:225.0/255
                                                  green:225.0/255
                                                   blue:225.0/255 alpha:0.7f]
                         forState:UIControlStateSelected];
        
        [_selectBtn setTitle:@"添加常用收货地址" forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [TBDetailUIStyle fontWithStyle:TBDetailFontStyle_ChineseBold
                                                               size:TBDetailFontSize_Title0];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UIView *)endline{
    if (_endline == nil) {
        _endline = [TBDetailUITools drawDivisionLine:0
                                                yPos:0
                                           lineWidth:self.width];
    }
    return _endline;
}

-(void)selectBtnClick:(TBDetailSKUButton*)sender{
    if (self.addressAddClick) {
        self.addressAddClick();
    }
}

@end
