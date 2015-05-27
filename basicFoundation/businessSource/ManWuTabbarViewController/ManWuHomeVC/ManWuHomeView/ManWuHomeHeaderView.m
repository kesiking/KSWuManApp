//
//  ManWuHomeHeaderView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHomeHeaderView.h"
#import "WeAppBasicBannerView.h"
#import "ManWuDiiscountInfoDescriptionView.h"
#import "ManWuSpecialForTodayView.h"
#import "ManWuRecommendForListHeaderView.h"
#import "KSManWuHomeService.h"

#define banner_height               (60.0 * SCREEN_SCALE)
#define discountInfo_height         (108.0 * SCREEN_SCALE)
#define specialView_height          (100.0 * SCREEN_SCALE)
#define recommendView_height        (25.0 * SCREEN_SCALE)

@interface ManWuHomeHeaderView()

@property (nonatomic, strong) CSLinearLayoutView                    *container;

@property (nonatomic, strong) WeAppBasicBannerView                  *bannerView;

@property (nonatomic, strong) ManWuDiiscountInfoDescriptionView     *discountInfo;

@property (nonatomic, strong) ManWuSpecialForTodayView              *specialView;

@property (nonatomic, strong) ManWuRecommendForListHeaderView       *recommendView;

@property (nonatomic, strong) KSManWuHomeService           *homeActivityService;

@end

@implementation ManWuHomeHeaderView

-(void)setupView{
    [super setupView];
    [self addSubview:self.container];
    [self.homeActivityService loadHomeActivityData];
}

-(void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel{
    [self reloadData];
}

-(void)refresh{
    [self.homeActivityService loadHomeActivityData];
    [self reloadData];
}

-(void)dealloc{
    _bannerView.delegate = nil;
    _bannerView = nil;
    [_container removeAllItems];
    _container = nil;
}

-(void)reloadData{
    
    [self.container removeAllItems];
    
    CSLinearLayoutItemPadding padding = CSLinearLayoutMakePadding(0, 0, 1.0, 0.0);
    
    CSLinearLayoutItem *discountInfoLayoutItem = [[CSLinearLayoutItem alloc]
                                                       initWithView:self.discountInfo];
    discountInfoLayoutItem.padding             = padding;
    [self.container addItem:discountInfoLayoutItem];
    
    CSLinearLayoutItem *specialViewLayoutItem = [[CSLinearLayoutItem alloc]
                                                 initWithView:self.specialView];
    specialViewLayoutItem.padding             = padding;
    [self.container addItem:specialViewLayoutItem];
    
    CSLinearLayoutItem *bannerViewLayoutItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.bannerView];
    bannerViewLayoutItem.padding             = padding;
    [self.container addItem:bannerViewLayoutItem];
    
    CSLinearLayoutItem *recommendViewLayoutItem = [[CSLinearLayoutItem alloc]
                                               initWithView:self.recommendView];
    recommendViewLayoutItem.padding             = padding;
    [self.container addItem:recommendViewLayoutItem];
}

#pragma mark - container

- (CSLinearLayoutView *)container {
    if (!_container) {
        float containerHeight = self.height;
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, containerHeight);
        _container = [[CSLinearLayoutView alloc] initWithFrame:frame];
        _container.autoAdjustFrameSize = YES;
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
        _bannerView.bannerBackgroundImage.image = [UIImage imageNamed:@"home_placehold_banner"];
        _bannerView.delegate = (id)self;
        _bannerView.isRounded = NO;
    }
    return _bannerView;
}

#pragma mark - bannerView Delegate

- (void)BannerView:(UIView*)aBannerView didSelectPageWithURL:(NSURL*) url{
    if (aBannerView == _bannerView) {
        NSDictionary* params = @{@"commodityId":@"commodityId"};
        TBOpenURLFromTargetWithNativeParams(internalURL(KManWuCommodityListForDiscount), self,nil,params);
    }
}

#pragma mark - discountInfo

-(ManWuDiiscountInfoDescriptionView *)discountInfo{
    if (_discountInfo == nil) {
        _discountInfo = [[ManWuDiiscountInfoDescriptionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, discountInfo_height)];
        _discountInfo.backgroundColor = [UIColor whiteColor];
    }
    return _discountInfo;
}

#pragma mark - discountInfo

-(ManWuSpecialForTodayView *)specialView{
    if (_specialView == nil) {
        _specialView = [[ManWuSpecialForTodayView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, specialView_height)];
        _specialView.backgroundColor = [UIColor whiteColor];
    }
    return _specialView;
}

#pragma mark - discountInfo

-(ManWuRecommendForListHeaderView *)recommendView{
    if (_recommendView == nil) {
        _recommendView = [[ManWuRecommendForListHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, recommendView_height)];
        _recommendView.backgroundColor = [UIColor whiteColor];
    }
    return _recommendView;
}

-(KSManWuHomeService *)homeActivityService{
    if (_homeActivityService == nil) {
        _homeActivityService = [[KSManWuHomeService alloc] init];
        WEAKSELF
        _homeActivityService.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            if (service && service.dataList) {
                [strongSelf setupHomeActivityViewWithDataList:service.dataList];
            }
        };
    }
    return _homeActivityService;
}

-(void)setupHomeActivityViewWithDataList:(NSArray *)array{
    NSUInteger count = [array count];
    if (count > 0) {
        [self.discountInfo setDescriptionModel:[array objectAtIndex:0]];
        [self.specialView setDescriptionModel:[array objectAtIndex:0]];
    }
    if (count > 2) {
        [self.specialView setLeftDescriptionModel:[array objectAtIndex:1] rightDescriptionModel:[array objectAtIndex:2]];
    }else if (count > 1){
        [self.specialView setLeftDescriptionModel:[array objectAtIndex:1] rightDescriptionModel:nil];
    }
    
    [self reloadData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Override

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = size;
    
    CGRect rect = self.bounds;
    
    rect.size.height = self.container.height;
    
    /*Bug,会以中点，上下缩的，不能直接设置Bound*/
    newSize = CGSizeMake(newSize.width, rect.size.height);
    
    return newSize;
}


@end
