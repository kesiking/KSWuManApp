//
//  ManWuCommodityFiltTagCellView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-14.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityFiltTagCellView.h"

@interface ManWuCommodityFiltTagCellView()

@property (nonatomic,strong) UIButton*          tagCellButton;

@end

@implementation ManWuCommodityFiltTagCellView

-(void)setupView{
    [super setupView];
    [self addSubview:self.tagCellButton];
}

-(UIButton *)tagCellButton{
    if (_tagCellButton == nil) {
        _tagCellButton = [[UIButton alloc] initWithFrame:self.bounds];
        [_tagCellButton setTitle:@"测试" forState:UIControlStateNormal];
        [_tagCellButton setTintColor:[UIColor redColor]];
        [_tagCellButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    }
    return _tagCellButton;
}

-(void)setTitle:(NSString*)title{
    [self.tagCellButton setTitle:title forState:UIControlStateNormal];
    [self.tagCellButton sizeToFit];
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
