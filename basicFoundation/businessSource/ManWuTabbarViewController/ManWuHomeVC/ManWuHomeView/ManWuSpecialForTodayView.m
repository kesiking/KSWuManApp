//
//  ManWuSpecialForTodayView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuSpecialForTodayView.h"
#import "ManWuHomeActivityInfoModel.h"

@interface ManWuSpecialForTodayView()

@property (nonatomic, strong) UIImageView                 *leftImageView;

@property (nonatomic, strong) UIImageView                 *rightImageView;

@property (nonatomic, strong) ManWuHomeActivityInfoModel  *leftActivityModel;

@property (nonatomic, strong) ManWuHomeActivityInfoModel  *rightActivityModel;

@property (nonatomic, strong) WeAppComponentBaseItem      *activityModel;
@end

@implementation ManWuSpecialForTodayView

-(void)setupView{
    [super setupView];
    [self addSubview:self.leftImageView];
    [self addSubview:self.rightImageView];

}

-(UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        CGRect rect = self.bounds;
        rect.size.width = rect.size.width / 2 - 2;
        _leftImageView = [[UIImageView alloc] initWithFrame:rect];
        [_leftImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_leftImageView setImage:[UIImage imageNamed:@"home_specialForToday_first_placehold_banner"]];
        _leftImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer* getstureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageViewClickEvent:)];
        [_leftImageView addGestureRecognizer:getstureRecognize];
    }
    return _leftImageView;
}

-(UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        CGRect rect = self.leftImageView.frame;
        rect.origin.x = self.leftImageView.right + 2;
        _rightImageView = [[UIImageView alloc] initWithFrame:rect];
        [_rightImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_rightImageView setImage:[UIImage imageNamed:@"home_specialForToday_second_placehold_banner"]];
        _rightImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer* getstureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageViewClickEvent:)];
        [_rightImageView addGestureRecognizer:getstureRecognize];
    }
    return _rightImageView;
}

-(void)setLeftDescriptionModel:(WeAppComponentBaseItem*)leftDescriptionModel rightDescriptionModel:(WeAppComponentBaseItem*)rightDescriptionModel{
    if ([leftDescriptionModel isKindOfClass:[ManWuHomeActivityInfoModel class]]) {
        self.leftActivityModel = (ManWuHomeActivityInfoModel*)leftDescriptionModel;
    }
    if ([rightDescriptionModel isKindOfClass:[ManWuHomeActivityInfoModel class]]) {
        self.rightActivityModel = (ManWuHomeActivityInfoModel*)rightDescriptionModel;
    }
    [self reloadData];
}

-(void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel{
    self.activityModel = descriptionModel;
}

-(void)reloadData{
    if (self.leftActivityModel.picUrl && self.leftActivityModel.picUrl.length > 0) {
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.leftActivityModel.picUrl] placeholderImage:[UIImage imageNamed:@"home_specialForToday_first_placehold_banner"]];
    }else{
        [self.leftImageView setImage:[UIImage imageNamed:@"home_specialForToday_first_placehold_banner"]];
    }
    
    if (self.rightActivityModel.picUrl && self.rightActivityModel.picUrl.length > 0) {
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.rightActivityModel.picUrl] placeholderImage:[UIImage imageNamed:@"home_specialForToday_second_placehold_banner"]];
    }else{
        [self.rightImageView setImage:[UIImage imageNamed:@"home_specialForToday_second_placehold_banner"]];
    }
    
}

-(void)refresh{
    
}

-(void)handleImageViewClickEvent:(UITapGestureRecognizer *)getstureRecognize
{
    UIView* sender = getstureRecognize.view;
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    if (sender == self.leftImageView) {
        [params setObject:self.leftActivityModel.typeId?:@"2" forKey:@"actId"];
        [params setObject:self.leftActivityModel?:[ManWuHomeActivityInfoModel new] forKey:@"activityModel"];
    }else if (sender == self.rightImageView){
        [params setObject:self.rightActivityModel.typeId?:@"3" forKey:@"actId"];
        [params setObject:self.rightActivityModel?:[ManWuHomeActivityInfoModel new] forKey:@"activityModel"];
    }
    
    TBOpenURLFromTargetWithNativeParams(internalURL(KManWuCommodityListForDiscount), self,nil,params);
    
}

@end
