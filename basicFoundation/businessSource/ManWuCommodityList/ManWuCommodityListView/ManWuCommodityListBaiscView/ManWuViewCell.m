//
//  ManWuViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-25.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuViewCell.h"
#import "KSCollectionViewController.h"
#import "ManWuCommodityDetailModel.h"

#define commodityImage_border        (8.0)
#define commodityImage_width_height  (self.width - 0)
#define commodityImage_bottom_border (5.0)
#define favorateLabel_width          (30)
#define favorateLabel_height         (15)
#define favorateImage_right_border   (4)
#define favorateImage_width_height   (30)
#define favorateImage_width          (17)
#define favorateImage_height         (15)
#define favorateImage_left_border    (2)
#define titleLabel_bottom_border     (2.0)
#define selectButton_width_height    (30.0)

@interface ManWuViewCell()

@property (nonatomic,strong) NSString*         commodityImageUrl;

@end

@implementation ManWuViewCell

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    [self.commodityImageView setFrame:CGRectMake(0, commodityImage_border, commodityImage_width_height, commodityImage_width_height)];
    [self.favorateLabel setFrame:CGRectMake(self.commodityImageView.right - favorateLabel_width, self.commodityImageView.bottom + commodityImage_bottom_border, favorateLabel_width, favorateLabel_height)];
    [self.favorateImageView setFrame:CGRectMake(self.favorateLabel.left - favorateImage_right_border - favorateImage_width_height, self.commodityImageView.bottom + commodityImage_bottom_border - 2.0, favorateImage_width_height, favorateImage_width_height)];
    [self.titleLabel setFrame:CGRectMake(self.commodityImageView.left, self.commodityImageView.bottom + commodityImage_bottom_border, self.favorateImageView.left - self.commodityImageView.left - favorateImage_left_border, self.favorateLabel.height)];
    [self.priceLabel setFrame:CGRectMake(self.titleLabel.left , self.titleLabel.bottom + titleLabel_bottom_border, self.titleLabel.width, self.titleLabel.height)];
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = RGB(0x66, 0x66, 0x66);
        _titleLabel.backgroundColor = self.backgroundColor;
        _titleLabel.opaque = YES;
        _titleLabel.numberOfLines = 1;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:11];
        _priceLabel.textColor = RGB(0x2d, 0x2d, 0x2d);
        _priceLabel.backgroundColor = self.backgroundColor;
        _priceLabel.opaque = YES;
        _priceLabel.numberOfLines = 1;
        [self addSubview:_priceLabel];
    }
    return _priceLabel;
}

-(UILabel *)favorateLabel{
    if (_favorateLabel == nil) {
        _favorateLabel = [[UILabel alloc] init];
        _favorateLabel.backgroundColor = [UIColor whiteColor];
        _favorateLabel.opaque = YES;
        _favorateLabel.font = [UIFont boldSystemFontOfSize:11];
        _favorateLabel.numberOfLines = 1;
        [self addSubview:_favorateLabel];
    }
    return _favorateLabel;
}

-(UIImageView *)commodityImageView{
    if (_commodityImageView == nil) {
        _commodityImageView = [[UIImageView alloc] init];
        _commodityImageView.layer.borderColor = [UIColor grayColor].CGColor;
        _commodityImageView.layer.borderWidth = 0.5;
        _commodityImageView.layer.shadowOffset = CGSizeMake(0.5,0.5);
        _commodityImageView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_commodityImageView.bounds].CGPath;
        _commodityImageView.backgroundColor = self.backgroundColor;
        _commodityImageView.opaque = YES;
        [self addSubview:_commodityImageView];
    }
    return _commodityImageView;
}

-(ManWuPraiseButton *)favorateImageView{
    if (_favorateImageView == nil) {
        _favorateImageView = [[ManWuPraiseButton alloc] init];
        [_favorateImageView setImageEdgeInsets:UIEdgeInsetsMake(1, (favorateImage_width_height - favorateImage_width), (favorateImage_width_height - favorateImage_height) - 1, 0)];
        [self addSubview:_favorateImageView];
    }
    return _favorateImageView;
}

-(UIButton *)selectButton{
    if (_selectButton == nil) {
        _selectButton = [[UIButton alloc] initWithFrame:CGRectMake(self.commodityImageView.right - selectButton_width_height, self.commodityImageView.top, selectButton_width_height, selectButton_width_height)];
        [self setupSelectViewStatus:NO];
        _selectButton.hidden = YES;
        [self addSubview:_selectButton];
    }
    return _selectButton;
}

- (void)updateFrame{
    [self.favorateLabel sizeToFit];
    [self.favorateLabel setFrame:CGRectMake(self.commodityImageView.right - self.favorateLabel.width, self.favorateLabel.top, self.favorateLabel.width, self.favorateLabel.height)];
    [self.favorateImageView setFrame:CGRectMake(self.favorateLabel.left - favorateImage_right_border - self.favorateImageView.width, self.favorateImageView.top, self.favorateImageView.width, self.favorateImageView.height)];
    [self.titleLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.top , self.favorateImageView.left - self.commodityImageView.left - favorateImage_left_border, self.titleLabel.height)];
}

- (void)reloadDataWithComponent:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    if (![componentItem isKindOfClass:[ManWuCommodityDetailModel class]]) {
        return;
    }
    ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)componentItem;
    if (extroParams.imageHasLoaded) {
        [self.commodityImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.img] placeholderImage:[UIImage imageNamed:@"gz_image_loading"]];
        self.commodityImageUrl = detailModel.img;
    }else{
        self.commodityImageView.image = [UIImage imageNamed:@"gz_image_loading"];
        self.commodityImageUrl = nil;
    }
    self.favorateImageView.itemId = detailModel.itemId;
    [self.favorateImageView updatePraiseBtnStatus:[detailModel.loved boolValue]];
    self.titleLabel.text = detailModel.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",detailModel.sale];
    NSString* favorateLabelText = [WeAppUtils longNumberAbbreviation:[detailModel.love longLongValue] number:3];
    self.favorateLabel.text = favorateLabelText;
    [self updateFrame];
}

- (void)reloadSelectViewWithComponent:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    if (extroParams.configObject && [extroParams.configObject isKindOfClass:[KSCollectionViewConfigObject class]]) {
        KSCollectionViewConfigObject* configObject = extroParams.configObject;
        if (configObject.isEditModel) {
            self.selectButton.hidden = NO;
            KSCollectionViewController* collectionViewCtl = ((KSCollectionViewController*)self.scrollViewCtl);
            NSMutableArray* collectionDeleteItems = collectionViewCtl.collectionDeleteItems;
            BOOL isSelect = extroParams.cellIndexPath && [collectionDeleteItems containsObject:extroParams.cellIndexPath];
            [self setupSelectViewStatus:isSelect];
            return;
        }
    }
    self.selectButton.hidden = YES;
}

-(void)setupSelectViewStatus:(BOOL)isSelect{
    if (isSelect) {
        [self.selectButton setBackgroundColor:[UIColor redColor]];
    }else{
        [self.selectButton setBackgroundColor:[UIColor greenColor]];
    }
}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    [super configCellWithCellView:cell Frame:rect componentItem:componentItem extroParams:extroParams];
    [self reloadSelectViewWithComponent:componentItem extroParams:extroParams];
    [self reloadDataWithComponent:componentItem extroParams:extroParams];
}

- (void)refreshCellImagesWithComponentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    if (![componentItem isKindOfClass:[ManWuCommodityDetailModel class]]) {
        return;
    }
    ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)componentItem;
    if (self.commodityImageUrl != detailModel.img) {
        [self.commodityImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.img] placeholderImage:[UIImage imageNamed:@"gz_image_loading"]];
        self.commodityImageUrl = detailModel.img;
    }else{
        NSLog(@"----> don't need reload image again");
    }
}

- (void)didSelectCellWithCellView:(id<KSViewCellProtocol>)cell componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    if (![componentItem isKindOfClass:[ManWuCommodityDetailModel class]]) {
        return;
    }
    ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)componentItem;
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:detailModel.itemId?:@"",@"itemId", nil];
    TBOpenURLFromTargetWithNativeParams(internalURL(kManWuCommodityDetail), self,nil,params);
}

-(void)configDeleteCellWithCellView:(id<KSViewCellProtocol>)cell atIndexPath:(NSIndexPath *)indexPath componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    
    KSCollectionViewController* collectionViewCtl = ((KSCollectionViewController*)self.scrollViewCtl);
    NSMutableArray* collectionDeleteItems = collectionViewCtl.collectionDeleteItems;
    if (![collectionDeleteItems containsObject:indexPath]) {
        [collectionDeleteItems addObject:indexPath];
        self.selectButton.backgroundColor = [UIColor redColor];
    }else{
        self.selectButton.backgroundColor = [UIColor greenColor];
        [collectionDeleteItems removeObject:indexPath];
    }
}

@end
