//
//  ManWuCommoditySortViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySortViewCell.h"
#import "ManWuCommoditySortAndFiltModel.h"

#define sortImageViewWidthAndHeight (20)

@implementation ManWuCommoditySortViewCell

-(void)setupView{
    [super setupView];
    self.backgroundColor = [UIColor whiteColor];
    [self.commoditySortImageView setFrame:CGRectMake(10, ceil((self.height - caculateNumber(sortImageViewWidthAndHeight))/2), caculateNumber(sortImageViewWidthAndHeight),caculateNumber(sortImageViewWidthAndHeight))];
    [self.titleLabel setFrame:CGRectMake(self.commoditySortImageView.right + caculateNumber(10), self.commoditySortImageView.top, caculateNumber(200), self.commoditySortImageView.height)];
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.numberOfLines = 1;
        _titleLabel.backgroundColor = [UIColor clearColor];
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

-(void)refreshCellImagesWithComponentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem *)extroParams{
    
}

@end
