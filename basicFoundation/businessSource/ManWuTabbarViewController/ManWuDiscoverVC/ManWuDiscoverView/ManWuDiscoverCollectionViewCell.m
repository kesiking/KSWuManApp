//
//  ManWuDiscoverCollectionViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiscoverCollectionViewCell.h"

@implementation ManWuDiscoverCollectionViewCell

-(void)setupView{
    [self.commodityImageView setFrame:self.bounds];
}

-(UIImageView *)commodityImageView{
    if (_commodityImageView == nil) {
        _commodityImageView = [[UIImageView alloc] init];
        [self addSubview:_commodityImageView];
    }
    return _commodityImageView;
}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
   [self.commodityImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"gz_image_loading"]];
}

- (void)refreshCellImagesWithComponentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    
}

- (void)didSelectCellWithCellView:(id<KSViewCellProtocol>)cell componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    
}

@end
