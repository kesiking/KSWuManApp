//
//  ManWuSpecialForTodayView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuSpecialForTodayView.h"

@interface ManWuSpecialForTodayView()

@property (nonatomic, strong) UIImageView                 *leftImageView;

@property (nonatomic, strong) UIImageView                 *rightImageView;

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
        rect.size.width = rect.size.width / 2 - 1;
        _leftImageView = [[UIImageView alloc] initWithFrame:rect];
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
        rect.origin.x = self.leftImageView.right + 1;
        _rightImageView = [[UIImageView alloc] initWithFrame:rect];
        [_rightImageView setImage:[UIImage imageNamed:@"home_specialForToday_second_placehold_banner"]];
        _rightImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer* getstureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageViewClickEvent:)];
        [_rightImageView addGestureRecognizer:getstureRecognize];
    }
    return _rightImageView;
}

-(void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel{
    [self reloadData];
}

-(void)reloadData{
    [self.leftImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"home_specialForToday_first_placehold_banner"]];
    [self.rightImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"home_specialForToday_second_placehold_banner"]];
}

-(void)refresh{
    
}

-(void)handleImageViewClickEvent:(UITapGestureRecognizer *)getstureRecognize
{
    UIView* sender = getstureRecognize.view;
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    if (sender == self.leftImageView) {
        [params setObject:@"commodityId" forKey:@"commodityId"];
        [params setObject:@"2" forKey:@"actId"];
    }else if (sender == self.rightImageView){
        [params setObject:@"commodityId" forKey:@"commodityId"];
        [params setObject:@"3" forKey:@"actId"];
    }
    
    TBOpenURLFromTargetWithNativeParams(internalURL(KManWuCommodityListForDiscount), self,nil,params);
}

@end
