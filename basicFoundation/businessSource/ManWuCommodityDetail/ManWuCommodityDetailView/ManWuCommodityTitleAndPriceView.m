//
//  ManWuCommodityTitleAndPriceView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityTitleAndPriceView.h"
#import "ManWuPraiseButton.h"
#import "ManWuFavButton.h"
#import "ManWuCommodityDetailModel.h"

@interface ManWuCommodityTitleAndPriceView()

@property (nonatomic,strong) IBOutlet UILabel     *      commodityTitleLabel;
@property (nonatomic,strong) IBOutlet UILabel     *      commodityPriceLabel;

@property (nonatomic,strong) IBOutlet UILabel     *      commodityPraiseLabel;
@property (nonatomic,strong) IBOutlet ManWuPraiseButton *      commodityPraiseButton;
@property (nonatomic,strong) IBOutlet ManWuFavButton    *      commodityFavorateButton;

@property (nonatomic,strong) UIView               *      commoditySeparateLine;

@end

@implementation ManWuCommodityTitleAndPriceView

+(id)createView{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    if ([nibContents count] > 0) {
        id object = [nibContents objectAtIndex:0];
        if (object && [object isKindOfClass:[self class]])
        {
            ManWuCommodityTitleAndPriceView *obj = (ManWuCommodityTitleAndPriceView *)object;
            return  obj;
        }
    }
    return nil;
}

-(void)awakeFromNib{
    [self setupView];
}

-(void)setupView{
    [super setupView];
    [self addSubview:self.commoditySeparateLine];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.commoditySeparateLine setFrame:CGRectMake(8, self.height - 0.5, self.width - 8 * 2, self.commoditySeparateLine.height)];
}

-(void)setDescriptionModel:(WeAppComponentBaseItem *)descriptionModel{
    /*
     for (NSUInteger index = 0; index < 5 ; index++) {
     NSString* string = [NSString stringWithFormat:@"测试发大水发的撒:%lu",(unsigned long)index];
     [self.descriptionArray addObject:string];
     }
     */
    if ([descriptionModel isKindOfClass:[ManWuCommodityDetailModel class]]) {
        ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)descriptionModel;
        self.commodityTitleLabel.text = detailModel.title;
        self.commodityPriceLabel.text = [NSString stringWithFormat:@"￥ %@",detailModel.sale];
        self.commodityPraiseLabel.text = [NSString stringWithFormat:@"%@",detailModel.love];
        [self.commodityPraiseButton updatePraiseBtnStatus:[detailModel.like boolValue]];
        [self.commodityFavorateButton updateFavBtnStatus:[detailModel.like boolValue]];
        [self.commodityPraiseButton setItemId:detailModel.itemId];
        [self.commodityFavorateButton setItemId:detailModel.itemId];
    }
    [self reloadData];
}

-(void)reloadData{
    CGSize labelSize = [self.commodityPraiseLabel.text sizeWithFont:self.commodityPraiseLabel.font constrainedToSize:CGSizeMake(100, self.commodityPraiseLabel.height) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect labelRect = self.commodityPraiseLabel.frame;
    labelRect.origin.x = self.commodityFavorateButton.origin.x - labelSize.width;
    labelRect.size.width = labelSize.width;
    [self.commodityPraiseLabel setFrame:labelRect];
    CGRect rect = self.commodityPraiseButton.frame;
    rect.origin.x = self.commodityPraiseLabel.origin.x - self.commodityPraiseButton.width;
    [self.commodityPraiseButton setFrame:rect];
}

-(UIView *)commoditySeparateLine{
    if (_commoditySeparateLine == nil) {
        _commoditySeparateLine = [TBDetailUITools drawDivisionLine:8
                                                yPos:self.height - 0.5
                                           lineWidth:self.width - 8 * 2];
        [_commoditySeparateLine setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Price2]];
    }
    return _commoditySeparateLine;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Override

- (CGSize)sizeThatFits:(CGSize)size {
    CGRect rect = self.bounds;
    
    rect.size.height = 70 * SCREEN_SCALE;
    
    return CGSizeMake(rect.size.width, rect.size.height);
}

@end
