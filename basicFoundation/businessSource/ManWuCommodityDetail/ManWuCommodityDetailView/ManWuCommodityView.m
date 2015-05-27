//
//  ManWuCommodityView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityView.h"
#import "WeAppBasicBannerView.h"
#import "ManWuCommodityTitleAndPriceView.h"
#import "TBDetailBigPhotoBrowerController.h"
#import "ManWuCommodityInfoDescriptionView.h"
#import "ManWuCommodityGuideView.h"

#define banner_height (325.0 * SCREEN_SCALE)

@interface ManWuCommodityView()

@property (nonatomic, strong) CSLinearLayoutView                    *container;

@property (nonatomic, strong) WeAppBasicBannerView                  *bannerView;
@property (nonatomic, strong) TBDetailBigPhotoBrowerController      *simpleBrower;

@property (nonatomic, strong) ManWuCommodityTitleAndPriceView       *titleAndPriceView;

@property (nonatomic, strong) ManWuCommodityInfoDescriptionView     *infoDecView;
@property (nonatomic, strong) ManWuCommodityGuideView               *guideView;

@end

@implementation ManWuCommodityView

-(void)setupView{
    [super setupView];
    [self addSubview:self.container];
}

-(void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel{
    [self.infoDecView setDescriptionModel:descriptionModel];
    [self.titleAndPriceView setDescriptionModel:descriptionModel];
    [self.guideView setDescriptionModel:descriptionModel];
    [self reloadData];
}

-(void)dealloc{
    _bannerView.delegate = nil;
    _bannerView = nil;
    [_simpleBrower removeFromSuperview];
    _simpleBrower = nil;
}

-(void)reloadData{
    
    [self.infoDecView sizeToFit];
    [self.guideView sizeToFit];
    
    [self.container removeAllItems];
    
    CSLinearLayoutItemPadding padding = CSLinearLayoutMakePadding(0, 0, 5.0, 0.0);
    
    CSLinearLayoutItem *bannerViewLayoutItem = [[CSLinearLayoutItem alloc]
                                            initWithView:self.bannerView];
    bannerViewLayoutItem.padding             = padding;
    [self.container addItem:bannerViewLayoutItem];
    
    CSLinearLayoutItem *titleAndPriceViewLayoutItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.titleAndPriceView];
    titleAndPriceViewLayoutItem.padding             = padding;
    [self.container addItem:titleAndPriceViewLayoutItem];
    
    CSLinearLayoutItem *infoDecViewLayoutItem = [[CSLinearLayoutItem alloc]
                                             initWithView:self.infoDecView];
    infoDecViewLayoutItem.padding             = padding;
    [self.container addItem:infoDecViewLayoutItem];
    
    CSLinearLayoutItem *guideViewLayoutItem = [[CSLinearLayoutItem alloc]
                                                 initWithView:self.guideView];
    guideViewLayoutItem.padding             = padding;
    [self.container addItem:guideViewLayoutItem];
}

#pragma mark - container

- (CSLinearLayoutView *)container {
    if (!_container) {
        float containerHeight = self.height;
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, containerHeight);
        _container = [[CSLinearLayoutView alloc] initWithFrame:frame];
        _container.backgroundColor  = [TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg1];
    }
    return _container;
}

#pragma mark - bannerView

-(WeAppBasicBannerView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[WeAppBasicBannerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, banner_height)];
        _bannerView.backgroundColor = [UIColor whiteColor];
        [_bannerView.bannerCloseButton removeFromSuperview];
        _bannerView.clipsToBounds = YES;
        _bannerView.delegate = (id)self;
        _bannerView.isRounded = NO;
    }
    return _bannerView;
}

#pragma mark - bannerView Delegate

- (void)BannerView:(UIView*)aBannerView didSelectPageWithURL:(NSURL*) url{
    if (aBannerView == _bannerView) {
        [self.simpleBrower removeAllSubviews];
        [self.window addSubview:self.simpleBrower];
        
        NSMutableArray<TBDetailBigPhotoModel> *arr = (NSMutableArray<TBDetailBigPhotoModel> *)[NSMutableArray array];
//    for (NSString *picUrl in self.picModel.picsPath) {
//        [arr addObject:[[TBDetailBigPhotoModel alloc] initWidthUrl:picUrl]];
//    }
        
        self.simpleBrower.photoList = arr;
        //    self.simpleBrower.imgs   = imgs;
        /* 保存下图片，以便弱网下大图浏览后能替换能清晰的图片 */
//        [_imgArray removeAllObjects];
//        _imgArray = nil;
//        _imgArray = imgs;
        NSUInteger selectIndex = _bannerView.bannerCycleScrollView.pageControl.currentPage;
        self.simpleBrower.selectedIndex = selectIndex;
        [self.simpleBrower displayPhoto];
        
        self.simpleBrower.maskFrame = [aBannerView convertRect:aBannerView.frame toView:nil];
        [self.simpleBrower setHidden:NO];
        [self.simpleBrower gotoPage:selectIndex animated:NO];
    }
}

#pragma mark - titleAndPriceView

-(ManWuCommodityTitleAndPriceView *)titleAndPriceView{
    if (_titleAndPriceView == nil) {
        _titleAndPriceView = [ManWuCommodityTitleAndPriceView createView];
        [_titleAndPriceView setWidth:self.width];
        [_titleAndPriceView sizeToFit];
    }
    return _titleAndPriceView;
}

#pragma mark - infoDecView

-(ManWuCommodityInfoDescriptionView *)infoDecView{
    if (_infoDecView == nil) {
        _infoDecView = [[ManWuCommodityInfoDescriptionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200 * SCREEN_SCALE)];
    }
    return _infoDecView;
}

#pragma mark - guideView

-(ManWuCommodityGuideView *)guideView{
    if (_guideView == nil) {
        _guideView = [[ManWuCommodityGuideView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200 * SCREEN_SCALE)];
    }
    return _guideView;
}

#pragma mark - simpleBrower

-(TBDetailBigPhotoBrowerController *)simpleBrower{
    if (!_simpleBrower) {
        _simpleBrower = [[TBDetailBigPhotoBrowerController alloc] initWithFrame:self.window.bounds];
    }
    return _simpleBrower;
}

/////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - TBDetailBigPhotoBrowerController config

-(NSInteger)getCurrentChooseIndex
{
    NSInteger index = 0;
    
    for (TBDetailBigPhotoModel *model in self.simpleBrower.photoList) {
//        if ([model.photoUrl isEqualToString:self.detailModel.skuDetailModel.skuService.currentSKUInfo.picUrl]) {
//            index = [self.simpleBrower.photoList indexOfObject:model];
//        }
    }
    
    return index;
}

-(void)configImgList:(NSInteger)index photoCount:(NSInteger)photoCount
{
    NSMutableArray *imgs = [[NSMutableArray alloc] initWithCapacity:photoCount];
    for (int i = 0; i < photoCount; i++) {
        
    }
    self.simpleBrower.imgs = imgs;
}

-(NSInteger)configBigPhotoBrowser
{
    [self.simpleBrower removeAllSubviews];
    
    /*配置photoList*/
    NSMutableArray *photoList = [NSMutableArray array];
    
    self.simpleBrower.photoList = (NSArray<TBDetailBigPhotoModel> *)photoList;
    
    NSInteger index = [self getCurrentChooseIndex];
    
    /*配置imgs*/
    [self configImgList:index photoCount:photoList.count];
    
    /*其他配置*/
    self.simpleBrower.selectedIndex = index;
    
    return index;
}

@end
