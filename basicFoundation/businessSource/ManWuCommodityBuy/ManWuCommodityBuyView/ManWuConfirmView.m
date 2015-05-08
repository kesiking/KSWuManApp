//
//  ManWuConfirmView.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuConfirmView.h"
#import "TBDetailSKUButton.h"
#import "KSSafePayUtility.h"

@interface ManWuConfirmView()

@property (nonatomic, strong) TBDetailSKUButton          *selectBtn;

@end

@implementation ManWuConfirmView

-(void)setupView{
    [super setupView];
    [self addSubview:self.selectBtn];
    self.backgroundColor = TBBUY_COLOR_N_C;
    self.endline.hidden = YES;
}

- (TBDetailSKUButton *)selectBtn {
    if (!_selectBtn) {
        CGRect frame = CGRectMake((self.width - 290)/2, (self.height - 30)/2, 290, 34);
        _selectBtn = [[TBDetailSKUButton alloc] initWithFrame:frame];
        _selectBtn.layer.cornerRadius = 3.0;
        [_selectBtn setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Tag alpha:1]
                         forState:UIControlStateNormal];
        [_selectBtn setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Tag alpha:0.2]
                         forState:UIControlStateDisabled];
        [_selectBtn setTitleColor:[UIColor colorWithRed:225.0/255
                                                  green:225.0/255
                                                   blue:225.0/255 alpha:0.7f]
                         forState:UIControlStateSelected];
        
        [_selectBtn setTitle:@"确认并付款" forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [TBDetailUIStyle fontWithStyle:TBDetailFontStyle_ChineseBold
                                                               size:TBDetailFontSize_Title0];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(void)selectBtnClick:(TBDetailSKUButton*)sender{
    [KSSafePayUtility aliPayForParams:nil callbackBlock:^(NSDictionary *resultDic) {
        ;
    }];
}
@end
