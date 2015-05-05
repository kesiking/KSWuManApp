//
//  ManWuDiiscountInfoDescriptionView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiiscountInfoDescriptionView.h"

@interface ManWuDiiscountInfoDescriptionView()

@property (nonatomic, strong) UIImageView                 *imageView;

@end

@implementation ManWuDiiscountInfoDescriptionView

-(void)setupView{
    [super setupView];
    [self addSubview:self.imageView];
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_imageView setImage:[UIImage imageNamed:@"home_discount_placehold_banner"]];
    }
    return _imageView;
}

-(void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel{
    [self reloadData];
}

-(void)reloadData{
    [self.imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"home_discount_placehold_banner"]];
}

@end
