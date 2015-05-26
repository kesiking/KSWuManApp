//
//  ManWuCommodityFiltTagCellView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-14.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityFiltTagCellView.h"

@interface ManWuCommodityFiltTagCellView()

@end

@implementation ManWuCommodityFiltTagCellView

-(void)setupView{
    [super setupView];
    [self addSubview:self.tagCellButton];
}

-(UIButton *)tagCellButton{
    if (_tagCellButton == nil) {
        _tagCellButton = [[UIButton alloc] initWithFrame:self.bounds];
        _tagCellButton.layer.cornerRadius = 3;
        _tagCellButton.layer.masksToBounds = YES;
        [_tagCellButton setBackgroundColor:RGB(0xf0, 0xf0, 0xf0)];
        _tagCellButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_tagCellButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _tagCellButton;
}

-(void)setTitle:(NSString*)title{
    [self.tagCellButton setTitle:title forState:UIControlStateNormal];
    [self.tagCellButton sizeToFit];
    CGRect rect = self.tagCellButton.frame;
    rect.size.width += 20;
    [self.tagCellButton setFrame:rect];
    [self sizeToFit];
}

-(void)setSelected:(BOOL)selected{
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = size;
    newSize.width = self.tagCellButton.width;
    return newSize;
}

@end
