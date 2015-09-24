//
//  ManWuHotShowItemVIew.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/9/24.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHotShowItemVIew.h"

@interface ManWuHotShowItemVIew()

@property (nonatomic, strong) UIButton              *btn;
@property (nonatomic, strong) UIImageView           *babyImageView;

@end

@implementation ManWuHotShowItemVIew

-(void)setupView{
    [super setupView];
    [self initBabyButton];
}

-(void)initBabyButton{
    _btn = [[UIButton alloc] initWithFrame:self.bounds];
    [_btn addTarget:self action:@selector(babyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
    
    _babyImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_babyImageView];
    
}

-(void)setAdvertisementModel:(ManWuHomeAdvertisementModel *)advertisementModel{
    _advertisementModel = advertisementModel;
    [self reloadData];
}

-(void)reloadData{
    [self.babyImageView sd_setImageWithURL:[NSURL URLWithString:self.advertisementModel.picUrl] placeholderImage:[UIImage imageNamed:@"gz_image_loading"]];
}

-(void)babyButtonClicked:(id)sender{
    if (self.buttonClicedBlock) {
        self.buttonClicedBlock(self);
    }
}

@end
