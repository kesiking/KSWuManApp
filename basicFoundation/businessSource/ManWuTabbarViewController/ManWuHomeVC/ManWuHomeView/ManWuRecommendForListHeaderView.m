//
//  ManWuRecommendForListHeaderView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuRecommendForListHeaderView.h"

@interface ManWuRecommendForListHeaderView()

@property (nonatomic, strong) UIImageView                 *imageView;

@property (nonatomic, strong) UILabel                     *label;

@end

@implementation ManWuRecommendForListHeaderView

-(void)setupView{
    [super setupView];
    [self addSubview:self.imageView];
    [self addSubview:self.label];
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}

-(UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setText:@"新品推荐"];
    }
    return _label;
}

-(void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel{
    [self reloadData];
}

-(void)reloadData{
    [self.imageView sd_setImageWithURL:nil placeholderImage:nil];
}

-(void)refresh{
    
}

@end
