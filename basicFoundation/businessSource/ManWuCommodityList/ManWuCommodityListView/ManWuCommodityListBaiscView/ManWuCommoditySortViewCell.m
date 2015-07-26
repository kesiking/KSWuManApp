//
//  ManWuCommoditySortViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySortViewCell.h"
#import "ManWuCommoditySortAndFiltModel.h"
#import "KSCollectionViewController.h"

#define sortImageViewWidth  (24)
#define sortImageViewHeight (25)


@implementation ManWuCommoditySortViewCell

-(void)setupView{
    [super setupView];
    self.backgroundColor = [UIColor whiteColor];
    [self.commoditySortImageView setFrame:CGRectMake(20, ceil((self.height - (sortImageViewHeight))/2), (sortImageViewWidth),(sortImageViewHeight))];
    [self.titleLabel setFrame:CGRectMake(self.commoditySortImageView.right + (12), self.commoditySortImageView.top, (200), self.commoditySortImageView.height)];
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [_titleLabel setTextColor:RGB(0x88, 0x88, 0x88)];
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
    KSCollectionViewController* collectionViewCtl = ((KSCollectionViewController*)self.scrollViewCtl);
    [self.commoditySortImageView setImage:[UIImage imageNamed:commodityComponentItem.imageUrl]];
    [self.titleLabel setTextColor:RGB(0x88, 0x88, 0x88)];
    self.backgroundColor = RGB(0xf5, 0xf5, 0xf5);
    if ([collectionViewCtl isKindOfClass:[KSCollectionViewController class]]) {
        if ([collectionViewCtl.selectIndexPath row] == extroParams.cellIndex) {
            [self.commoditySortImageView setImage:[UIImage imageNamed:commodityComponentItem.selectImageUrl]];
            [self.titleLabel setTextColor:RGB(0xf0, 0x7b, 0x7b)];
            self.backgroundColor = [UIColor whiteColor];
        }
    }
    self.titleLabel.text = commodityComponentItem.titleText;
    
}

-(void)refreshCellImagesWithComponentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem *)extroParams{
    
}

@end
