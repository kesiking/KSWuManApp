//
//  ManWuCommoditySortViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySortViewCell.h"
#import "ManWuCommoditySortAndFiltModel.h"

@implementation ManWuCommoditySortViewCell

-(void)setupView{
    [super setupView];
    self.backgroundColor = [UIColor whiteColor];
    [self.commoditySortImageView setFrame:CGRectMake(8, (self.height - 20)/2, 20,20)];
    [self.titleLabel setFrame:CGRectMake(self.commoditySortImageView.right + 8, self.commoditySortImageView.top, 200, self.commoditySortImageView.height)];
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.numberOfLines = 1;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UIImageView *)commoditySortImageView{
    if (_commoditySortImageView == nil) {
        _commoditySortImageView = [[UIImageView alloc] init];
        [self addSubview:_commoditySortImageView];
    }
    return _commoditySortImageView;
}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    ManWuCommoditySortAndFiltModel* commodityComponentItem = (ManWuCommoditySortAndFiltModel*)componentItem;
    [self.commoditySortImageView setImage:[UIImage imageNamed:commodityComponentItem.imageUrl]];
    self.titleLabel.text = commodityComponentItem.titleText;
    if (extroParams.cellIndex%2 == 1) {
        self.backgroundColor = RGB(0xe7, 0xe7, 0xe7);
    }
}

@end