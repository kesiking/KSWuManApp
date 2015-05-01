//
//  ManWuConfirmView.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuConfirmView.h"
#import "TBDetailSKUButton.h"

@interface ManWuConfirmView()

@property (nonatomic, strong) TBDetailSKUButton          *selectBtn;

@end

@implementation ManWuConfirmView

-(void)setupView{
    [super setupView];
    [self addSubview:self.selectBtn];
}

- (TBDetailSKUButton *)selectBtn {
    if (!_selectBtn) {
        CGRect frame = CGRectMake(0, 0, 100, 50);
        _selectBtn = [[TBDetailSKUButton alloc] initWithFrame:frame];
        [_selectBtn setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Tag alpha:1]
                         forState:UIControlStateNormal];
        [_selectBtn setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Tag alpha:0.2]
                         forState:UIControlStateDisabled];
        [_selectBtn setTitleColor:[UIColor colorWithRed:225.0/255
                                                  green:225.0/255
                                                   blue:225.0/255 alpha:0.7f]
                         forState:UIControlStateSelected];
        
        [_selectBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [TBDetailUIStyle fontWithStyle:TBDetailFontStyle_ChineseBold
                                                               size:TBDetailFontSize_Title0];
    }
    return _selectBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
