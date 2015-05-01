//
//  ManWuDetailBottomBarView.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDetailBottomBarView.h"

@implementation ManWuDetailBottomBarView

-(void)setupView{
    [super setupView];
    self.backgroundColor = [UIColor whiteColor];
    CGFloat buttonWidth = self.frame.size.width / 2;
    self.buyButton.frame  = CGRectMake((self.frame.size.width - buttonWidth)/2, 0, buttonWidth, self.frame.size.height);
    [self addSubview:self.buyButton];
    
    /*顶部分割线*/
    [self addSubview:[TBDetailUITools drawFullDivisionLine:0]];
}

- (TBDetailSKUButton *)buyButton {
    if (!_buyButton) {
        CGRect frame = CGRectMake(0, 0, 100, 50);
        _buyButton = [[TBDetailSKUButton alloc] initWithFrame:frame];
        [_buyButton setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Tag alpha:1]
                       forState:UIControlStateNormal];
        [_buyButton setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Tag alpha:0.2]
                       forState:UIControlStateDisabled];
        [_buyButton setTitleColor:[UIColor colorWithRed:225.0/255
                                                green:225.0/255
                                                 blue:225.0/255 alpha:0.7f]
                       forState:UIControlStateSelected];
        
        [_buyButton setTitle:@"购买" forState:UIControlStateNormal];
        [_buyButton setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
        _buyButton.titleLabel.font = [TBDetailUIStyle fontWithStyle:TBDetailFontStyle_ChineseBold
                                                             size:TBDetailFontSize_Title0];
    }
    return _buyButton;
}

@end
