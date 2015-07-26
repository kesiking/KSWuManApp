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
#import "KSCollectionViewController.h"

@implementation ManWuCommoditySortForDiscountViewCell

-(void)setupView{
    [super setupView];
    [self.commoditySortImageView setFrame:CGRectMake((20), (self.height - 30)/2, 30,30)];
    [self.titleLabel setFrame:CGRectMake(self.commoditySortImageView.right + (10), self.commoditySortImageView.top, 200, 15)];
    [self.subTitleLabel setFrame:CGRectMake(self.commoditySortImageView.right + (10), self.titleLabel.bottom, 200, self.titleLabel.height)];
    [self.titleLabel setFont:[UIFont systemFontOfSize:9]];
}

-(UILabel *)subTitleLabel{
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.numberOfLines = 1;
        [self addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    if ([componentItem isKindOfClass:[ManWuDiscoverModel class]]) {
        ManWuDiscoverModel* commodityComponentItem = (ManWuDiscoverModel*)componentItem;
        [self.commoditySortImageView sd_setImageWithURL:[NSURL URLWithString:commodityComponentItem.img] placeholderImage:[UIImage imageNamed:@"gz_image_loading"]];
        self.titleLabel.text = commodityComponentItem.name;
        self.subTitleLabel.text = commodityComponentItem.subTitleText;
    }else if ([componentItem isKindOfClass:[ManWuCommoditySortAndFiltModel class]]){
        [super configCellWithCellView:cell Frame:rect componentItem:componentItem extroParams:extroParams];
        ManWuCommoditySortAndFiltModel* commodityComponentItem = (ManWuCommoditySortAndFiltModel*)componentItem;
        self.subTitleLabel.text = commodityComponentItem.subTitleText;
        KSCollectionViewController* collectionViewCtl = ((KSCollectionViewController*)self.scrollViewCtl);
        [self.subTitleLabel setTextColor:RGB(0x88, 0x88, 0x88)];
        if ([collectionViewCtl isKindOfClass:[KSCollectionViewController class]]) {
            if ([collectionViewCtl.selectIndexPath row] == extroParams.cellIndex) {
                [self.subTitleLabel setTextColor:RGB(0xf0, 0x7b, 0x7b)];
            }
        }
    }
}

@end
