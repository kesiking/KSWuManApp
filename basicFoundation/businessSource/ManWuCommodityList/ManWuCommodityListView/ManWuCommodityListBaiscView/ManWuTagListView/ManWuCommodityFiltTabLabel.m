//
//  ManWuCommodityFiltTabLabel.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-14.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityFiltTabLabel.h"

@interface ManWuCommodityFiltTabLabel()

@property (nonatomic,strong) UILabel*          tagCellLabel;

@end

@implementation ManWuCommodityFiltTabLabel

-(void)setupView{
    [super setupView];
    [self addSubview:self.tagCellLabel];
}

-(UILabel *)tagCellLabel{
    if (_tagCellLabel == nil) {
        _tagCellLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_tagCellLabel setTextColor:[UIColor blackColor]];
    }
    return _tagCellLabel;
}

-(void)setTitle:(NSString*)title{
    [self.tagCellLabel setText:title];
    [self.tagCellLabel sizeToFit];
    [self.tagCellLabel setHeight:self.height];
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
