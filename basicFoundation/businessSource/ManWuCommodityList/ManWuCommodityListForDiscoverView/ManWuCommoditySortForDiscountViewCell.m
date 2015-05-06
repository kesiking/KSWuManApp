//
//  ManWuCommoditySortForDiscountViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySortForDiscountViewCell.h"
#import "ManWuCommoditySortAndFiltModel.h"

@implementation ManWuCommoditySortForDiscountViewCell

-(void)setupView{
    [super setupView];
    [self.commoditySortImageView setFrame:CGRectMake(8, (self.height - 20)/2, 20,20)];
    [self.titleLabel setFrame:CGRectMake(self.commoditySortImageView.right + 8, self.commoditySortImageView.top - 8, 200, 15)];
    [self.subTitleLabel setFrame:CGRectMake(self.commoditySortImageView.right + 8, self.titleLabel.bottom, 200, self.commoditySortImageView.height)];
}

-(UILabel *)subTitleLabel{
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
        _subTitleLabel.numberOfLines = 1;
        [self addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    ManWuCommoditySortAndFiltModel* commodityComponentItem = (ManWuCommoditySortAndFiltModel*)componentItem;
    [self.commoditySortImageView setImage:[UIImage imageNamed:commodityComponentItem.imageUrl]];
    self.titleLabel.text = commodityComponentItem.titleText;
    self.subTitleLabel.text = commodityComponentItem.subTitleText;
}

@end
