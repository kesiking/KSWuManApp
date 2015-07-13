//
//  ManWuDetailSKUHeaderView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDetailSKUHeaderView.h"

@interface ManWuDetailSKUHeaderView()

@property (nonatomic, strong) UILabel               *priceDescription;

@property (nonatomic, strong) UILabel               *priceNum;

@end

@implementation ManWuDetailSKUHeaderView

-(void)setupView{
    [super setupView];
    [self addSubview:self.priceDescription];
    [self addSubview:self.priceNum];
    /*顶部分割线*/
    [self addSubview:[TBDetailUITools drawDivisionLine:0 yPos:self.height - 0.5 lineWidth:self.width]];
}

- (UILabel *)priceDescription {
    if (!_priceDescription) {
        _priceDescription=[[UILabel alloc] initWithFrame:CGRectMake(0, (self.height - 36)/2, 35, 36)];
        _priceDescription.backgroundColor=[UIColor clearColor];
        _priceDescription.text = @"价格:";
        _priceDescription.font = [UIFont boldSystemFontOfSize:15.0];
        [_priceDescription setTextColor:RGB(0x99, 0x99, 0x99)];
    }
    return _priceDescription;
}

-(UILabel *)priceNum{
    if (!_priceNum) {
        _priceNum=[[UILabel alloc] initWithFrame:CGRectMake(self.priceDescription.right + 10, self.priceDescription.top, 100, self.priceDescription.height)];
        _priceNum.backgroundColor=[UIColor clearColor];
        _priceNum.text = @"0元";
        _priceNum.font = [UIFont boldSystemFontOfSize:15.0];
        [_priceNum setTextColor:RGB(0xFF, 0x50, 0x00)];
    }
    return _priceNum;
}

-(void)setPriceNumText:(NSString*)num{
    [self.priceNum setText:[NSString stringWithFormat:@"%@元",num]];
}

@end
