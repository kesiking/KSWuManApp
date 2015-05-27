//
//  ManWuBuyOrderPayView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuBuyOrderPayView.h"
#import "ManWuCommodityDetailModel.h"

@interface ManWuBuyOrderPayView ()

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *priceDesLabel;
@property (nonatomic, strong) UIView  *scaleView;

@end

@implementation ManWuBuyOrderPayView

// setup
-(void)setupView{
    [super setupView];
    _scaleView = [[UIView alloc] initWithFrame:CGRectMake(15, 0.0, self.width - 15 * 2, self.height)];
    _scaleView.backgroundColor = [UIColor clearColor];
    _scaleView.autoresizesSubviews = YES;
    [self addSubview:_scaleView];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:24];
    _priceLabel.textColor = TBBUY_COLOR_M;
    [_scaleView addSubview:_priceLabel];
    
    _priceDesLabel = [[UILabel alloc] init]; //原来是20
    _priceDesLabel.backgroundColor = [UIColor clearColor];
    _priceDesLabel.font = [UIFont boldSystemFontOfSize:TBBUY_FONT_3];
    _priceDesLabel.textColor = kTBBuyColorNG;
    _priceDesLabel.text = @"合计:";
    _priceDesLabel.textAlignment = NSTextAlignmentRight;
    [_scaleView addSubview:_priceDesLabel];
}

- (void)setObject:(id)object dict:(NSDictionary *)dict{
    if (![object isKindOfClass:[ManWuCommodityDetailModel class]]) {
        return;
    }
    ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)object;
    _scaleView.transform = CGAffineTransformIdentity;
    _scaleView.frame = CGRectMake(15, 0.0, self.width - 15 * 2, self.height);
    NSUInteger count = [dict objectForKey:@"buyNumber"] ? [[dict objectForKey:@"buyNumber"] unsignedIntegerValue] : 1;
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f", (CGFloat)([detailModel.sale floatValue] * count)];
    
    CGSize priceSize = [_priceLabel.text sizeWithFont:_priceLabel.font];
    _priceLabel.frame = CGRectMake(_scaleView.width - priceSize.width, 0, priceSize.width, self.height);
    
    _priceDesLabel.frame = CGRectMake(_priceLabel.origin.x - 60, 0, 45, self.height);
}

@end
