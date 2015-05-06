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
        _leftBtn = [[TBDetailSKUButton alloc] initWithFrame:rect];
        
        _leftBtn.reversesTitleShadowWhenHighlighted = NO;
        _leftBtn.adjustsImageWhenHighlighted = NO;
        
        _leftBtn.layer.borderWidth  = 1.0;
        _leftBtn.layer.cornerRadius = 3.0;
        
        [_leftBtn addTarget:self
                   action:@selector(leftButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [_leftBtn setTitle:@"筛选" forState:UIControlStateNormal];
        
        [self resizeButton:_leftBtn];
        
        /*设置不同状态下的字体颜色*/
        [self setButtonStyle:_leftBtn withStatus:UIControlStateNormal];
    }
    return _leftBtn;
}

-(TBDetailSKUButton *)rightBtn{
    if (_rightBtn == nil) {
        CGRect rect = self.leftBtn.frame;
        rect.origin.x = self.leftBtn.right;
        _rightBtn = [[TBDetailSKUButton alloc] initWithFrame:rect];
        
        _rightBtn.reversesTitleShadowWhenHighlighted = NO;
        _rightBtn.adjustsImageWhenHighlighted = NO;
        
        _rightBtn.layer.borderWidth  = 1.0;
        _rightBtn.layer.cornerRadius = 3.0;
        
        [_rightBtn addTarget:self
                     action:@selector(rightButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_rightBtn setTitle:@"排序" forState:UIControlStateNormal];
        
        [self resizeButton:_rightBtn];
        
        /*设置不同状态下的字体颜色*/
        [self setButtonStyle:_rightBtn withStatus:UIControlStateNormal];
    }
    return _rightBtn;
}

-(void)resizeButton:(TBDetailSKUButton*)button{
    button.clipsToBounds            = YES;
    button.titleLabel.numberOfLines = 2;
    button.titleLabel.font          = [TBDetailUIStyle fontWithStyle:TBDetailFontStyle_Chinese
                                                                size:TBDetailFontSize_Title2];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)setButtonStyle:(TBDetailSKUButton *)button withStatus:(UIControlState)state
{
    switch (state) {
        case UIControlStateSelected:{
            /*select状态*/
            button.buttonDidSeleced = YES;
            [button setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Title2]
                         forState:UIControlStateNormal];
            [button setBorderColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg2]
                          forState:UIControlStateNormal];
            [button setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Gray]
                              forState:UIControlStateNormal];
        }
            break;
        case UIControlStateNormal:
        default:{
            /*normal状态*/
            button.buttonDidSeleced = NO;
            [button setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Title2]
                         forState:UIControlStateNormal];
            [button setBorderColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_LineColor1]
                          forState:UIControlStateNormal];
            [button setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_White]
                              forState:UIControlStateNormal];
        }
            break;
    }
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
