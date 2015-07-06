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

@property (nonatomic,strong) UIView               *      commoditySeparateTopLine;
@property (nonatomic,strong) UIView               *      commoditySeparateLine;

@property (nonatomic,strong) ManWuCommodityDetailModel * detailModel;

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
    [self addSubview:self.commoditySeparateTopLine];
    [self addSubview:self.commoditySeparateLine];
    WEAKSELF
    self.commodityPraiseButton.operationStatusChanged = ^(ManWuOperationButton* operationButton){
        ManWuPraiseButton* favBtn = (ManWuPraiseButton*)operationButton;
        STRONGSELF
        if (favBtn.isPraise) {
            // to do add count
            NSInteger count = [strongSelf.detailModel.love integerValue];
            count += 1;
            strongSelf.detailModel.love = [NSNumber numberWithInteger:count];
        }else{
            // to do sub count
            NSInteger count = [strongSelf.detailModel.love integerValue];
            count -= 1;
            if (count <= 0) {
                count = 0;
            }
            strongSelf.detailModel.love = [NSNumber numberWithInteger:count];
        }
        strongSelf.commodityPraiseLabel.text = [NSString stringWithFormat:@"%@",strongSelf.detailModel.love];
    };
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.commoditySeparateTopLine setFrame:CGRectMake(0, 0, self.width, self.commoditySeparateTopLine.height)];
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
        self.detailModel = (ManWuCommodityDetailModel*)descriptionModel;
        self.commodityTitleLabel.text = self.detailModel.title;
        self.commodityPriceLabel.text = [NSString stringWithFormat:@"￥ %@",self.detailModel.sale];
        self.commodityPraiseLabel.text = [NSString stringWithFormat:@"%@",self.detailModel.love?:@"0"];
        [self.commodityPraiseButton updatePraiseBtnStatus:[self.detailModel.loved boolValue]];
        [self.commodityFavorateButton updateFavBtnStatus:[self.detailModel.like boolValue]];
        [self.commodityPraiseButton setItemId:self.detailModel.itemId];
        [self.commodityFavorateButton setItemId:self.detailModel.itemId];
    }
    [self reloadData];
}

-(void)reloadData{
    CGSize titleLabelSize = [self.commodityTitleLabel.text sizeWithFont:self.commodityTitleLabel.font constrainedToSize:CGSizeMake(self.commodityTitleLabel.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect titleLabeRect = self.commodityTitleLabel.frame;
    titleLabeRect.size.height = titleLabelSize.height;
    [self.commodityTitleLabel setFrame:titleLabeRect];
    
    [self.commodityPriceLabel setOrigin:CGPointMake(self.commodityPriceLabel.origin.x, self.commodityTitleLabel.bottom + 5)];
    
    [self.commodityFavorateButton setOrigin:CGPointMake(self.commodityFavorateButton.origin.x, self.commodityTitleLabel.bottom)];
    
    CGSize labelSize = [self.commodityPraiseLabel.text sizeWithFont:self.commodityPraiseLabel.font constrainedToSize:CGSizeMake(100, self.commodityPraiseLabel.height) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect labelRect = self.commodityPraiseLabel.frame;
    labelRect.origin.x = self.commodityFavorateButton.origin.x - labelSize.width;
    labelRect.origin.y = self.commodityFavorateButton.origin.y + 6;
    labelRect.size.width = labelSize.width;
    [self.commodityPraiseLabel setFrame:labelRect];
    
    CGRect rect = self.commodityPraiseButton.frame;
    rect.origin.x = self.commodityPraiseLabel.origin.x - self.commodityPraiseButton.width;
    rect.origin.y = self.commodityFavorateButton.origin.y + 2 ;
    [self.commodityPraiseButton setFrame:rect];
}

-(UIView *)commoditySeparateTopLine{
    if (_commoditySeparateTopLine == nil) {
        _commoditySeparateTopLine = [TBDetailUITools drawDivisionLine:0
                                                              yPos:0
                                                         lineWidth:self.width];
        [_commoditySeparateTopLine setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Price2]];
    }
    return _commoditySeparateTopLine;
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
    
    rect.size.height = self.commodityPriceLabel.bottom + 25 /* * SCREEN_SCALE */;
    
    return CGSizeMake(rect.size.width, rect.size.height);
}

@end
