//
//  ManWuViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-25.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuViewCell.h"
#import "KSCollectionViewController.h"

#define commodityImage_border        (8.0)
#define commodityImage_width_height  (self.width - 0)
#define commodityImage_bottom_border (5.0)
#define favorateLabel_width          (25)
#define favorateLabel_height         (15)
#define favorateImage_right_border   (4)
#define favorateImage_width_height   (20)
#define favorateImage_left_border    (2)
#define titleLabel_bottom_border     (2.0)
#define selectButton_width_height    (30.0)

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
    [self.favorateImageView setFrame:CGRectMake(self.favorateLabel.left - favorateImage_right_border - favorateImage_width_height, self.commodityImageView.bottom + commodityImage_bottom_border - 1, favorateImage_width_height, favorateImage_width_height)];
    [self.titleLabel setFrame:CGRectMake(self.commodityImageView.left, self.commodityImageView.bottom + commodityImage_bottom_border, self.favorateImageView.left - self.commodityImageView.left - favorateImage_left_border, self.favorateLabel.height)];
    [self.priceLabel setFrame:CGRectMake(self.titleLabel.left , self.titleLabel.bottom + titleLabel_bottom_border, self.titleLabel.width, self.titleLabel.height)];
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.numberOfLines = 1;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:13];
        _priceLabel.numberOfLines = 1;
        [self addSubview:_priceLabel];
    }
    return _priceLabel;
}

-(UILabel *)favorateLabel{
    if (_favorateLabel == nil) {
        _favorateLabel = [[UILabel alloc] init];
        _favorateLabel.font = [UIFont systemFontOfSize:12];
        _favorateLabel.numberOfLines = 1;
        [self addSubview:_favorateLabel];
    }
    return _favorateLabel;
}

-(UIImageView *)commodityImageView{
    if (_commodityImageView == nil) {
        _commodityImageView = [[UIImageView alloc] init];
        [self addSubview:_commodityImageView];
    }
    return _commodityImageView;
}

-(UIImageView *)enjoyImageView{
    if (_enjoyImageView == nil) {
        _enjoyImageView = [[UIImageView alloc] init];
        [self addSubview:_enjoyImageView];
    }
    return _enjoyImageView;
}

-(UIImageView *)favorateImageView{
    if (_favorateImageView == nil) {
        _favorateImageView = [[UIImageView alloc] init];
        [_favorateImageView setImage:[UIImage imageNamed:@"gz_image_loading"]];
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

- (void)reloadDataWithComponent:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    if (extroParams.imageHasLoaded) {
        [self.commodityImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"gz_image_loading"]];
    }else{
        self.commodityImageView.image = [UIImage imageNamed:@"gz_image_loading"];
    }
    self.titleLabel.text = @"测试风刀霜剑烦死了都快捷方式来得及菲利克斯";
    self.priceLabel.text = @"￥1000";
    NSString* favorateLabelText = [WeAppUtils longNumberAbbreviation:100 number:2];
    self.favorateLabel.text = favorateLabelText;
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
    [self.commodityImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"gz_image_loading"]];
}

- (void)didSelectCellWithCellView:(id<KSViewCellProtocol>)cell componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:@"commodityId",@"commodityId", nil];
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
