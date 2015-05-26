//
//  ManWuCommodityFiltTabLabel.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-14.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityFiltTabLabel.h"

@interface ManWuCommodityFiltTabLabel()

@property (nonatomic,strong) UIButton*          tagCellLabel;

@end

@implementation ManWuCommodityFiltTabLabel

-(void)setupView{
    [super setupView];
    [self addSubview:self.tagCellLabel];
}

-(UIButton *)tagCellLabel{
    if (_tagCellLabel == nil) {
        _tagCellLabel = [[UIButton alloc] initWithFrame:self.bounds];
        _tagCellLabel.titleLabel.font = [UIFont systemFontOfSize:13];
        [_tagCellLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _tagCellLabel;
}

-(void)setTitle:(NSString*)title{
    [self.tagCellLabel setTitle:title forState:UIControlStateNormal];
    [self.tagCellLabel sizeToFit];
    CGRect rect = self.tagCellLabel.frame;
    rect.size.width += 20;
    rect.size.height = self.height;
    [self.tagCellLabel setFrame:rect];
    [self sizeToFit];
}

-(void)setSelected:(BOOL)selected{
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = size;
    newSize.width = self.tagCellLabel.width;
    return newSize;
}

@end
