//
//  ManWuOperationButton.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuOperationButton.h"
#import "WeAppLoadingView.h"

#define WeAppLoadingView_width_height (28.0)

@interface ManWuOperationButton()

@property(nonatomic,strong)  WeAppLoadingView*       loadingView;

@end

@implementation ManWuOperationButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)awakeFromNib{
    [self setupView];
}

-(void)setupView{
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)dealloc{
    _service.delegate = nil;
    _service = nil;
}

-(void)setService:(KSAdapterService *)service{
    if (service != _service) {
        _service.delegate = nil;
        _service = nil;
        _service = service;
        _service.delegate = self;
    }
}

// 如果正在加载则不允许响应请求事件
-(BOOL)canResponseRequest{
    return !self.isLoading && !self.service.requestModel.isLoading;
}

-(void)setImage:(UIImage *)image{
    [self setImage:image forState:UIControlStateNormal];
}

-(void)buttonClickEvent{
    
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark button click action

-(void)buttonClick:(ManWuOperationButton*)button{
    [self buttonClickEvent];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark loadingView method

-(WeAppLoadingView *)loadingView {
    if (_loadingView == nil) {
        _loadingView = [[WeAppLoadingView alloc]initWithFrame:CGRectMake(([self width] - WeAppLoadingView_width_height)/2, ([self height] - WeAppLoadingView_width_height)/2, WeAppLoadingView_width_height, WeAppLoadingView_width_height)];
        [self addSubview:_loadingView];
    }
    return _loadingView;
}

-(void)showLodingView{
    if (!self.isLoading || self.loadingView.hidden) {
        self.isLoading = YES;
        self.loadingView.hidden = NO;
        [self.loadingView startAnimating];
    }
}

-(void)hideLodingView {
    self.isLoading = NO;
    self.loadingView.hidden = YES;
    [self.loadingView stopAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark WeAppBasicServiceDelegate method

- (void)serviceDidStartLoad:(WeAppBasicService *)service{
    [self showLodingView];
}

- (void)serviceDidFinishLoad:(WeAppBasicService *)service{
    if (self.messageForSuccessResponse) {
        [WeAppToast toast:self.messageForSuccessResponse];
    }
    [self hideLodingView];
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    if (self.messageForFailResponse) {
        [WeAppToast toast:self.messageForFailResponse];
    }
    [self hideLodingView];
}

@end
