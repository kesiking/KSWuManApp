//
//  ManWuCommoditySortAndFiltView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySortAndFiltView.h"
#import "TBDetailSKUButton.h"

@interface ManWuCommoditySortAndFiltView()

@property (nonatomic,strong) TBDetailSKUButton              *leftBtn;
@property (nonatomic,strong) TBDetailSKUButton              *rightBtn;

@end

@implementation ManWuCommoditySortAndFiltView

-(void)setupView{
    [super setupView];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
}

-(TBDetailSKUButton *)leftBtn{
    if (_leftBtn == nil) {
        CGRect rect = self.bounds;
        rect.size.width /= 2;
        rect.size.width -= 0.5;
        _leftBtn = [[TBDetailSKUButton alloc] initWithFrame:rect];
        
        _leftBtn.reversesTitleShadowWhenHighlighted = NO;
        _leftBtn.adjustsImageWhenHighlighted = NO;
        
        _leftBtn.layer.borderWidth  = 1.0;
//        _leftBtn.layer.cornerRadius = 3.0;
        
        [_leftBtn addTarget:self
                   action:@selector(leftButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [_leftBtn setTitle:@"筛选" forState:UIControlStateNormal];
        
        [_leftBtn setImage:[UIImage imageNamed:@"manwu_sort_down"] forState:UIControlStateNormal];
        
        [_leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 100)];
        [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake((_leftBtn.height - 5)/2, _leftBtn.width - 25.5, (_leftBtn.height - 5)/2, 15)];

        [self resizeButton:_leftBtn];
        
        /*设置不同状态下的字体颜色*/
        [self setButtonStyle:_leftBtn withStatus:UIControlStateNormal];
    }
    return _leftBtn;
}

-(TBDetailSKUButton *)rightBtn{
    if (_rightBtn == nil) {
        CGRect rect = self.leftBtn.frame;
        rect.origin.x = self.leftBtn.right + 1;
        _rightBtn = [[TBDetailSKUButton alloc] initWithFrame:rect];
        
        _rightBtn.reversesTitleShadowWhenHighlighted = NO;
        _rightBtn.adjustsImageWhenHighlighted = NO;
        
        _rightBtn.layer.borderWidth  = 1.0;
//        _rightBtn.layer.cornerRadius = 3.0;
        
        [_rightBtn addTarget:self
                     action:@selector(rightButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_rightBtn setTitle:@"排序" forState:UIControlStateNormal];
        
        [_rightBtn setImage:[UIImage imageNamed:@"manwu_sort_down"] forState:UIControlStateNormal];
        
        [_rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 90)];
        [_rightBtn setImageEdgeInsets:UIEdgeInsetsMake((_rightBtn.height - 5)/2, _rightBtn.width - 25.5, (_rightBtn.height - 5)/2, 15)];
        
        [self resizeButton:_rightBtn];
        
        /*设置不同状态下的字体颜色*/
        [self setButtonStyle:_rightBtn withStatus:UIControlStateNormal];
    }
    return _rightBtn;
}

-(void)resizeButton:(TBDetailSKUButton*)button{
    button.clipsToBounds            = YES;
    button.titleLabel.numberOfLines = 2;
    button.titleLabel.font          = [UIFont systemFontOfSize:17];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)setButtonStyle:(TBDetailSKUButton *)button withStatus:(UIControlState)state
{
    switch (state) {
        case UIControlStateSelected:{
            /*select状态*/
            button.buttonDidSeleced = YES;
            [button setTitleColor:RGB(0x66, 0x66, 0x66)
                         forState:UIControlStateNormal];
            [button setBorderColor:RGB(0xda, 0xda, 0xda)
                          forState:UIControlStateNormal];
            [button setBackgroundColor:RGB(0xf8, 0xf8, 0xf8)
                              forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"manwu_sort_up"] forState:UIControlStateNormal];

        }
            break;
        case UIControlStateNormal:
        default:{
            /*normal状态*/
            button.buttonDidSeleced = NO;
            [button setTitleColor:RGB(0x66, 0x66, 0x66)
                         forState:UIControlStateNormal];
            [button setBorderColor:RGB(0xda, 0xda, 0xda)
                          forState:UIControlStateNormal];
            [button setBackgroundColor:RGB(0xf8, 0xf8, 0xf8)
                              forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"manwu_sort_down"] forState:UIControlStateNormal];
        }
            break;
    }
}

-(void)setLeftBtnTitle:(NSString*)title{
    if (title == nil || [title isEqualToString:@"全部"] || [title isEqualToString:@"默认"]) {
        [self.leftBtn setTitle:@"筛选" forState:UIControlStateNormal];
        return;
    }
    [self.leftBtn setTitle:title forState:UIControlStateNormal];
}

-(void)setRightBtnTitle:(NSString*)title{
    if (title == nil || [title isEqualToString:@"全部"] || [title isEqualToString:@"默认排序"]) {
        [self.rightBtn setTitle:@"排序" forState:UIControlStateNormal];
        return;
    }
    [self.rightBtn setTitle:title forState:UIControlStateNormal];
}

-(void)setButtonSelected:(TBDetailSKUButton *)button
{
    if (button == self.leftBtn) {
        [self setButtonStyle:self.rightBtn withStatus:UIControlStateNormal];
    }else{
        [self setButtonStyle:self.leftBtn withStatus:UIControlStateNormal];
    }
    if (!button.buttonDidSeleced) {
        [self setButtonStyle:button withStatus:UIControlStateSelected];
    }else{
        [self setButtonStyle:button withStatus:UIControlStateNormal];
    }
}

-(void)clearButtonStatus{
    [self setButtonStyle:self.rightBtn withStatus:UIControlStateNormal];
    [self setButtonStyle:self.leftBtn withStatus:UIControlStateNormal];
}

-(void)leftButtonClicked:(id)sender{
    [self setButtonSelected:sender];
    if (self.leftButtonSelectedBlock) {
        self.leftButtonSelectedBlock(self.leftBtn);
    }
}

-(void)rightButtonClicked:(id)sender{
    [self setButtonSelected:sender];
    if (self.rightButtonSelectedBlock) {
        self.rightButtonSelectedBlock(self.rightBtn);
    }
}

@end
