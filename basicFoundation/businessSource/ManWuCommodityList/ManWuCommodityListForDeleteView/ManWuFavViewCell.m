//
//  ManWuFavViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuFavViewCell.h"
#import "ManWuCommodityDetailModel.h"

@interface ManWuFavViewCell()

@end

@implementation ManWuFavViewCell

-(void)setupView{
    [super setupView];
    [self.commodityPriceImageView setFrame:CGRectMake(self.commodityImageView.right - 50 - 0.5 , self.commodityImageView.bottom - 20 - 0.5, 50, 20)];
    [self.priceLabel setFrame:CGRectMake(self.commodityPriceImageView.left , self.commodityPriceImageView.top, self.commodityPriceImageView.width, self.commodityPriceImageView.height)];
    [self bringSubviewToFront:self.priceLabel];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)updateFrame{
    [super updateFrame];
    if (self.salePriceLabel.hidden) {
        [self.priceLabel sizeToFit];
        CGFloat commodityPriceImageViewWidth = MAX(self.priceLabel.width + 10, 50);

        [self.commodityPriceImageView setFrame:CGRectMake(self.commodityImageView.right - commodityPriceImageViewWidth - 0.5 , self.commodityImageView.bottom - 20 - 0.5, commodityPriceImageViewWidth, 20)];
        [self.priceLabel setFrame:CGRectMake(self.commodityPriceImageView.left , self.commodityPriceImageView.top, self.commodityPriceImageView.width, self.commodityPriceImageView.height)];
        [self bringSubviewToFront:self.priceLabel];
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        [self.priceLabel sizeToFit];
        [self.salePriceLabel sizeToFit];
        CGFloat commodityPriceImageViewWidth = MAX(self.priceLabel.width + self.salePriceLabel.width + 5, 90);
        [self.commodityPriceImageView setFrame:CGRectMake(self.commodityImageView.right - commodityPriceImageViewWidth - 0.5 , self.commodityImageView.bottom - 20 - 0.5, commodityPriceImageViewWidth, 20)];
        
        [self.salePriceLabel setFrame:CGRectMake(self.commodityPriceImageView.left , self.commodityPriceImageView.top, self.salePriceLabel.width, self.commodityPriceImageView.height)];
        [self bringSubviewToFront:self.salePriceLabel];
        self.salePriceLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.priceLabel setFrame:CGRectMake(self.salePriceLabel.right + 5 , self.commodityPriceImageView.top + 0.5, self.priceLabel.width, self.commodityPriceImageView.height)];
        [self bringSubviewToFront:self.priceLabel];
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
    }
}

-(UIImageView *)commodityPriceImageView{
    if (_commodityPriceImageView == nil) {
        _commodityPriceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        _commodityPriceImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        [self addSubview:_commodityPriceImageView];
    }
    return _commodityPriceImageView;
}

-(UIImageView *)commodityDisabelImageView{
    if (_commodityDisabelImageView == nil) {
        _commodityDisabelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.commodityImageView.left, self.commodityImageView.bottom - 25, self.commodityImageView.width, 25)];
        _commodityDisabelImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        _commodityDisabelImageView.hidden = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:_commodityDisabelImageView.bounds];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"宝贝失效了"];
        [label setFont:[UIFont systemFontOfSize:13]];
        [_commodityDisabelImageView addSubview:label];
        [self addSubview:_commodityDisabelImageView];
    }
    return _commodityDisabelImageView;
}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    [super configCellWithCellView:cell Frame:rect componentItem:componentItem extroParams:extroParams];
    
    if (![componentItem isKindOfClass:[ManWuCommodityDetailModel class]]) {
        return;
    }
    ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)componentItem;
    
    if ([detailModel.status integerValue] != 0) {
        self.commodityDisabelImageView.hidden = NO;
        self.commodityPriceImageView.hidden = YES;
        self.priceLabel.hidden = YES;
        self.salePriceLabel.hidden = YES;
    }else{
        _commodityDisabelImageView.hidden = YES;
        self.commodityPriceImageView.hidden = NO;
        self.priceLabel.hidden = NO;
        if (detailModel.sale) {
            self.salePriceLabel.hidden = NO;
        }
    }
}

@end
