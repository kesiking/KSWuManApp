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
#import "ManWuCommodityPriceCaculate.h"
#import "UIImage+Resize.h"
#import "UIImageView+KSWebCache.h"
#import "KSImageListCache.h"

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
#define selectButton_width_height    (20.0)

@interface ManWuViewCell()

@property (nonatomic,strong) NSString*         commodityImageUrl;

@property (nonatomic,strong) ManWuCommodityPriceCaculate * commodityPriceCaculate;

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
    _commodityPriceCaculate = [ManWuCommodityPriceCaculate new];
    [self.commodityImageView setFrame:CGRectMake(0, commodityImage_border, commodityImage_width_height, commodityImage_width_height)];
    [self.favorateLabel setFrame:CGRectMake(self.commodityImageView.right - favorateLabel_width, self.commodityImageView.bottom + commodityImage_bottom_border, favorateLabel_width, favorateLabel_height)];
    [self.favorateImageView setFrame:CGRectMake(self.favorateLabel.left - favorateImage_right_border - favorateImage_width_height, self.commodityImageView.bottom + commodityImage_bottom_border - 2.0, favorateImage_width_height, favorateImage_width_height)];
    [self.titleLabel setFrame:CGRectMake(self.commodityImageView.left, self.commodityImageView.bottom + commodityImage_bottom_border, self.favorateImageView.left - self.commodityImageView.left - favorateImage_left_border, self.favorateLabel.height)];
    [self.priceLabel setFrame:CGRectMake(self.titleLabel.left , self.titleLabel.bottom + titleLabel_bottom_border, self.titleLabel.width, self.titleLabel.height)];
    [self.salePriceLabel setFrame:CGRectMake(self.titleLabel.left , self.titleLabel.bottom + titleLabel_bottom_border, self.titleLabel.width, self.titleLabel.height)];
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = RGB(0x66, 0x66, 0x66);
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.opaque = YES;
        _titleLabel.numberOfLines = 1;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UICustomLineLabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UICustomLineLabel alloc] init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:10];
        _priceLabel.textColor = RGB(0xf3, 0xf0, 0x9b);//RGB(0x2d, 0x2d, 0x2d);
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.opaque = YES;
        _priceLabel.numberOfLines = 1;
        _priceLabel.lineType = LineTypeNone;
        _priceLabel.lineColor = _salePriceLabel.textColor;
        [self addSubview:_priceLabel];
    }
    return _priceLabel;
}

-(UICustomLineLabel *)salePriceLabel{
    if (_salePriceLabel == nil) {
        _salePriceLabel = [[UICustomLineLabel alloc] init];
        _salePriceLabel.font = [UIFont boldSystemFontOfSize:12];
        _salePriceLabel.textColor = [UIColor whiteColor];//RGB(0x2d, 0x2d, 0x2d);
        _salePriceLabel.backgroundColor = [UIColor clearColor];
        _salePriceLabel.opaque = YES;
        _salePriceLabel.numberOfLines = 1;
        _salePriceLabel.lineType = LineTypeNone;
        _salePriceLabel.lineColor = _salePriceLabel.textColor;
        [self addSubview:_salePriceLabel];
    }
    return _salePriceLabel;
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
        _commodityImageView.layer.borderColor = RGB_A(0xa0, 0xa0, 0xa0,0.5).CGColor;
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
        WEAKSELF
        _favorateImageView.operationStatusChanged = ^(ManWuOperationButton* operationButton){
            STRONGSELF
            ManWuPraiseButton* favBtn = (ManWuPraiseButton*)operationButton;
            ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)[strongSelf getComponentItem];
            if (detailModel == nil) {
                return;
            }
            if (favBtn.isPraise) {
                // to do add count
                NSInteger count = [detailModel.love integerValue];
                count += 1;
                detailModel.love = [NSNumber numberWithInteger:count];
            }else{
                // to do sub count
                NSInteger count = [detailModel.love integerValue];
                count -= 1;
                if (count <= 0) {
                    count = 0;
                }
                detailModel.love = [NSNumber numberWithInteger:count];
            }
            NSString* favorateLabelText = [WeAppUtils longNumberAbbreviation:[detailModel.love longLongValue] number:3];
            strongSelf.favorateLabel.text = favorateLabelText;
        };
        [self addSubview:_favorateImageView];
    }
    return _favorateImageView;
}

-(UIButton *)selectButton{
    if (_selectButton == nil) {
        _selectButton = [[UIButton alloc] initWithFrame:CGRectMake(self.commodityImageView.right - selectButton_width_height, self.commodityImageView.top, selectButton_width_height, selectButton_width_height)];
        _selectButton.userInteractionEnabled = NO;
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
    [self.commodityPriceCaculate setObject:detailModel dict:nil];
    if (extroParams.imageHasLoaded) {
        WEAKSELF
        UIImage* image = [[KSImageListCache sharedImageCache] imageFromMemoryCacheForKey:detailModel.img];
        if (image == nil) {
            [self.commodityImageView ks_setImageWithURL:[NSURL URLWithString:detailModel.img] placeholderImage:[UIImage imageNamed:@"gz_image_loading"] didDownLoadBlock:^UIImage *(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                STRONGSELF
                if (image && error == nil) {
                    return [image resizedImage:strongSelf.commodityImageView.size interpolationQuality:kCGInterpolationHigh];
                }
                return image;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image && imageURL) {
                    [[KSImageListCache sharedImageCache] storeImage:image forKey:imageURL.absoluteString];
                }
            }];
        }else{
            [self.commodityImageView setImage:image];
        }
        self.commodityImageUrl = detailModel.img;
    }else{
        self.commodityImageView.image = [UIImage imageNamed:@"gz_image_loading"];
        self.commodityImageUrl = nil;
    }
    self.favorateImageView.itemId = detailModel.itemId;
    [self.favorateImageView updatePraiseBtnStatus:[detailModel.loved boolValue]];
    self.titleLabel.text = detailModel.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%0.1f",[detailModel.price floatValue]];
    NSNumber* salePrice = [self.commodityPriceCaculate getCommodityPrice];
    if (salePrice != detailModel.price) {
        self.salePriceLabel.text = [NSString stringWithFormat:@"￥%0.1f",[salePrice floatValue]];
        self.salePriceLabel.hidden = NO;
        self.priceLabel.lineType = LineTypeMiddle;
    }else{
        self.priceLabel.lineType = LineTypeNone;
        self.salePriceLabel.hidden = YES;
    }
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
        [self.selectButton setImage:[UIImage imageNamed:@"deleteFavrate"] forState:UIControlStateNormal];
    }else{
        [self.selectButton setImage:[UIImage imageNamed:@"unDeleteFavrate"] forState:UIControlStateNormal];
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
        WEAKSELF
        UIImage* image = [[KSImageListCache sharedImageCache] imageFromMemoryCacheForKey:detailModel.img];
        if (image == nil) {
            [self.commodityImageView ks_setImageWithURL:[NSURL URLWithString:detailModel.img] placeholderImage:[UIImage imageNamed:@"gz_image_loading"] didDownLoadBlock:^UIImage *(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                STRONGSELF
                if (image && error == nil) {
                    return [image resizedImage:strongSelf.commodityImageView.size interpolationQuality:kCGInterpolationHigh];
                }
                return image;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image && imageURL) {
                    [[KSImageListCache sharedImageCache] storeImage:image forKey:imageURL.absoluteString];
                }
            }];
        }else{
            [self.commodityImageView setImage:image];
        }
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
        [self setupSelectViewStatus:YES];
    }else{
        [self setupSelectViewStatus:NO];
        [collectionDeleteItems removeObject:indexPath];
    }
}

@end
