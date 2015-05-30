//
//  ManWuCommoditySortForDiscountViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySortForDiscountViewCell.h"
#import "ManWuCommoditySortAndFiltModel.h"
#import "ManWuDiscoverModel.h"

@implementation ManWuCommoditySortForDiscountViewCell

-(void)setupView{
    [super setupView];
    [self.commoditySortImageView setFrame:CGRectMake(caculateNumber(10), (self.height - 20)/2, 30,30)];
    if (self.subTitleLabel.text == nil) {
         [self.titleLabel setFrame:CGRectMake(self.commoditySortImageView.right + caculateNumber(10), self.commoditySortImageView.top + (self.commoditySortImageView.height - 15)/2, 200, 15)];
    }else{
        [self.titleLabel setFrame:CGRectMake(self.commoditySortImageView.right + caculateNumber(10), self.commoditySortImageView.top - 8, 200, 15)];
    }
    [self.subTitleLabel setFrame:CGRectMake(self.commoditySortImageView.right + caculateNumber(10), self.titleLabel.bottom, 200, self.commoditySortImageView.height)];
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
    ManWuDiscoverModel* commodityComponentItem = (ManWuDiscoverModel*)componentItem;
    [self.commoditySortImageView sd_setImageWithURL:[NSURL URLWithString:commodityComponentItem.img] placeholderImage:[UIImage imageNamed:@"gz_image_loading"]];
    self.titleLabel.text = commodityComponentItem.name;
    self.subTitleLabel.text = commodityComponentItem.subTitleText;
}

@end
