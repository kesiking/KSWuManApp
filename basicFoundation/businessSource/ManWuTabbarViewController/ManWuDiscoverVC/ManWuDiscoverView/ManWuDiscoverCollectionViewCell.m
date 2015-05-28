//
//  ManWuDiscoverCollectionViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiscoverCollectionViewCell.h"
#import "ManWuDiscoverModel.h"

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
    [super configCellWithCellView:cell Frame:rect componentItem:componentItem extroParams:extroParams];
    
    ManWuDiscoverModel* discoverModel = (ManWuDiscoverModel*)componentItem;

    [self.commodityImageView sd_setImageWithURL:[NSURL URLWithString:discoverModel.img] placeholderImage:[UIImage imageNamed:@"gz_image_loading"]];
}

- (void)refreshCellImagesWithComponentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    
}

- (void)didSelectCellWithCellView:(id<KSViewCellProtocol>)cell componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    NSLog(@"did select cell in collection");
    ManWuDiscoverModel* discoverModel = (ManWuDiscoverModel*)componentItem;

    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:discoverModel.cid?:defaultCidKey,@"cid", nil];
    TBOpenURLFromTargetWithNativeParams(internalURL(kManWuCommodityList), self,nil,params);
}

@end
