//
//  TBBuyItemInfoCell.m
//  TBBuy
//
//  Created by christ.yuj on 14-1-6.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "ManWuBuyItemInfoView.h"

#define HORIZONTAL_MARGIN        15
#define VERTICAL_MARGIN          15
#define ITEM_ICON_SIDE_LENGTH    56
#define ACTIVITY_ICON_TOP_MARGIN  2
#define ACTIVITY_ICON_HEIGHT     15
#define TITLE_LEFT_MARGIN         8
#define TITLE_LABEL_HEIGHT       16
#define SUBTITLE_TOP_MARGIN       2
#define GIFT_ICON_WIDTH          42
#define GIFT_ICON_HEIGHT         12
#define GIFT_ICON_TOP_MARGIN      8
#define PRICE_LABEL_WIDTH        70
#define PRICE_LABEL_HEIGHT       16

@interface ManWuBuyItemInfoView ()

@property (nonatomic, strong) UIImageView           *itemImageView;
@property (nonatomic, strong) UILabel               *titleLabel;
@property (nonatomic, strong) UILabel               *subtitleLabel;
@property (nonatomic, strong) UILabel               *priceLabel;
@property (nonatomic, strong) UILabel               *quantityLabel;
@property (nonatomic, strong) UILabel               *weightLabel;
@property (nonatomic, strong) UIImageView           *activityIcon;
@property (nonatomic, strong) UIImageView           *giftIcon;

@end

@implementation ManWuBuyItemInfoView

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Initialize

-(void)setupView{
    [super setupView];
    [self addSubview:self.itemImageView];
    [self addSubview:self.activityIcon];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.priceLabel];
//    [self addSubview:self.quantityLabel];
//    [self addSubview:self.weightLabel];
}

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Private Accessor

- (UIImageView *)itemImageView {
    if (!_itemImageView) {
        CGFloat x = HORIZONTAL_MARGIN;
        CGFloat y = VERTICAL_MARGIN;
        CGFloat w = ITEM_ICON_SIDE_LENGTH;
        CGFloat h = ITEM_ICON_SIDE_LENGTH;
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _itemImageView.image = [UIImage imageNamed:@"gz_image_loading"];
        _itemImageView.layer.borderColor = TBBUY_COLOR_d_bg.CGColor;
        _itemImageView.layer.borderWidth = 0.5;
        _itemImageView.layer.cornerRadius = 3;
        _itemImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _itemImageView;
}

- (UIImageView *)activityIcon {
    if (!_activityIcon) {
        CGFloat x = self.itemImageView.left;
        CGFloat y = self.itemImageView.bottom + ACTIVITY_ICON_TOP_MARGIN;
        CGFloat w = self.itemImageView.width;
        CGFloat h = ACTIVITY_ICON_HEIGHT;
        _activityIcon= [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _activityIcon.backgroundColor = [UIColor clearColor];
        _activityIcon.contentMode = UIViewContentModeScaleAspectFit;
        _activityIcon.hidden = YES;
    }
    return _activityIcon;
}

- (UIImageView *)giftIcon {
    if (!_giftIcon) {
        _giftIcon = [[UIImageView alloc] init];
        _giftIcon.image = [UIImage imageNamed:@"gz_image_loading"];
        _giftIcon.contentMode = UIViewContentModeScaleAspectFit;
        _giftIcon.hidden = YES;
        [self addSubview:_giftIcon];
    }
    return _giftIcon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGFloat s = TBBUY_FONT_6;
        CGFloat x = self.itemImageView.right + TITLE_LEFT_MARGIN;
        CGFloat y = self.itemImageView.top - 2;
        CGFloat w = self.width - x - PRICE_LABEL_WIDTH - HORIZONTAL_MARGIN;
        CGFloat h = TITLE_LABEL_HEIGHT;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _titleLabel.numberOfLines = 1;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:s];
        _titleLabel.textColor = TBBUY_COLOR_L;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        CGFloat s = TBBUY_FONT_5;
        CGFloat x = self.titleLabel.left;
        CGFloat y = self.titleLabel.bottom;
        CGFloat w = self.titleLabel.width;
        CGFloat h = self.titleLabel.height;
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _subtitleLabel.backgroundColor = [UIColor clearColor];
        _subtitleLabel.font = [UIFont systemFontOfSize:s];
        _subtitleLabel.textColor = TBBUY_COLOR_C;
        _subtitleLabel.numberOfLines = 0;
    }
    return _subtitleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        CGFloat x = self.width- HORIZONTAL_MARGIN - PRICE_LABEL_WIDTH;
        CGFloat y = VERTICAL_MARGIN;
        CGFloat w = PRICE_LABEL_WIDTH;
        CGFloat h = PRICE_LABEL_HEIGHT;
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = TBBUY_COLOR_L;
    }
    return _priceLabel;
}

- (UILabel *)quantityLabel {
    if (!_quantityLabel) {
        CGFloat x = self.priceLabel.left;
        CGFloat y = self.priceLabel.bottom;
        CGFloat w = PRICE_LABEL_WIDTH;
        CGFloat h = PRICE_LABEL_HEIGHT;
        _quantityLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _quantityLabel.backgroundColor = [UIColor clearColor];
        _quantityLabel.textAlignment = NSTextAlignmentRight;
        _quantityLabel.font = [UIFont boldSystemFontOfSize:11];
        _quantityLabel.textColor = TBBUY_COLOR_C;   
    }
    return _quantityLabel;
}

- (UILabel *)weightLabel {
    if (!_weightLabel) {
        CGFloat x = self.quantityLabel.left;
        CGFloat y = self.quantityLabel.bottom;
        CGFloat w = PRICE_LABEL_WIDTH;
        CGFloat h = PRICE_LABEL_HEIGHT;
        _weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _weightLabel.backgroundColor = [UIColor clearColor];
        _weightLabel.textAlignment = NSTextAlignmentRight;
        _weightLabel.font = [UIFont boldSystemFontOfSize:11];
        _weightLabel.textColor = TBBUY_COLOR_L;
        _weightLabel.hidden = YES;   
    }
    return _weightLabel;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.subtitleLabel.text) {
        self.subtitleLabel.height = ceil(self.height - self.subtitleLabel.top - VERTICAL_MARGIN);
    }
    
//    CGFloat x = self.titleLabel.left;
//    CGFloat y = self.titleLabel.bottom + GIFT_ICON_TOP_MARGIN;
//    CGFloat w = GIFT_ICON_WIDTH;
//    CGFloat h = GIFT_ICON_HEIGHT;
//    
//    if (self.subtitleLabel.text.length) {
//        y = self.subtitleLabel.bottom + GIFT_ICON_TOP_MARGIN / 2;
//    }
//    self.giftIcon.frame = CGRectMake(x, y, w, h);
}

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Public

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Private

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - TBTradeCellDelegate

//+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
//    CGFloat defaultHeight = VERTICAL_MARGIN * 2 + ITEM_ICON_SIDE_LENGTH;
//    
//    if (!object) {
//        return defaultHeight;
//    }
//    
//    TBTradeItemInfoCellModel *model = (TBTradeItemInfoCellModel *)object;
//    
//    CGFloat x = TBBUY_SCREEN_WIDTH - HORIZONTAL_MARGIN - ITEM_ICON_SIDE_LENGTH
//            - TITLE_LEFT_MARGIN - PRICE_LABEL_WIDTH - HORIZONTAL_MARGIN;
//    CGSize size = CGSizeMake(x, 240);
//    UIFont *font = [UIFont boldSystemFontOfSize:TBBUY_FONT_5];
//    
//    CGSize subtitleSize;
//    if (model.itemModel.valid) {
//        subtitleSize = [model.itemInfoModel.skuInfo sizeWithFont:font constrainedToSize:size
//                                                   lineBreakMode:NSLineBreakByWordWrapping];
//    } else {
//        subtitleSize = [model.itemModel.reason sizeWithFont:font constrainedToSize:size
//                                              lineBreakMode:NSLineBreakByWordWrapping];
//    }
//    
//    if (model.itemInfoModel.activityIcon.length && model.itemModel.valid) {
//        defaultHeight += ACTIVITY_ICON_HEIGHT + ACTIVITY_ICON_TOP_MARGIN;
//    }
//    
//    CGFloat totalHeight = VERTICAL_MARGIN + TITLE_LABEL_HEIGHT + SUBTITLE_TOP_MARGIN
//            + subtitleSize.height + VERTICAL_MARGIN;
//    
//    if (subtitleSize.height > 0 && model.itemInfoModel.isGift) {
//        totalHeight += 12 + 4;
//    }
//    
//    return totalHeight < defaultHeight ? defaultHeight : totalHeight;
//}

- (void)setObject:(id)object {
    self.titleLabel.text = @"fdsjfsdljfsdfdsjfjdslkfjdslkjfdskljfkldsjfkldsjfkldsjflkakl";
    self.subtitleLabel.text = @"dfdsffjdslkjfdlksjfkdlsjfldskajflksdajfkldsdsfds";
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",@"198"];

//    self.model = (TBTradeItemInfoCellModel *)object;
//    TBTradeItemInfoCellModel *model = (TBTradeItemInfoCellModel *)self.model;
//    
//    TBTradeItemModel     *itemModel     = model.itemModel;
//    TBTradeItemInfoModel *itemInfoModel = model.itemInfoModel;
//    TBTradeItemPayModel  *itemPayModel  = model.itemPayModel;
//    
//    [self.imageLoader imageFromUrl:itemInfoModel.pic imageView:self.itemImageView];
//    
//    if (itemInfoModel.activityIcon.length && itemModel.valid) {
//        [self.imageLoader imageFromUrl:itemInfoModel.activityIcon
//                             imageView:self.activityIcon];
//        self.activityIcon.hidden = NO;
//    } else {
//        self.activityIcon.hidden = YES;
//    }
//    
//    self.titleLabel.text = itemInfoModel.title;
//
//    if (model.itemModel.valid) {
//        self.subtitleLabel.text = itemInfoModel.skuInfo;
//    } else {
//        self.subtitleLabel.text = itemModel.reason;
//    }
//    
//    NSString *price = itemPayModel.afterPromotionPrice;
//    if (price) {
//        price = [NSString stringWithFormat:@"%@ %@", COMMON_RMB_SYMBOL, price];
//    }
//    self.priceLabel.text = price ?: @"";
//
//    NSString *quantity = itemPayModel.quantity;
//    if (quantity) {
//        quantity = [NSString stringWithFormat:@"x%@", quantity];
//    }
//    self.quantityLabel.text = quantity ?: @"x1";
//    
//    NSString *weight = itemPayModel.weight;
//    if (weight) {
//        self.weightLabel.text = [NSString stringWithFormat:@"%@ kg", weight];
//        self.weightLabel.hidden = NO;
//    } else {
//        self.weightLabel.hidden = YES;
//    }
//    
//    if (itemInfoModel.isGift) {
//        [self.imageLoader imageFromUrl:itemInfoModel.giftIcon
//                             imageView:self.giftIcon];
//        self.giftIcon.hidden = NO;
//    } else {
//        self.giftIcon.hidden = YES;
//    }
}

@end
