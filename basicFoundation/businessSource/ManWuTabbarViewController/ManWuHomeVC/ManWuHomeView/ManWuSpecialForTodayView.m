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
    }
    return _leftImageView;
}

-(UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        CGRect rect = self.leftImageView.frame;
        rect.origin.x = self.leftImageView.right + 1;
        _rightImageView = [[UIImageView alloc] initWithFrame:rect];
        [_rightImageView setImage:[UIImage imageNamed:@"home_specialForToday_second_placehold_banner"]];
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

@end
