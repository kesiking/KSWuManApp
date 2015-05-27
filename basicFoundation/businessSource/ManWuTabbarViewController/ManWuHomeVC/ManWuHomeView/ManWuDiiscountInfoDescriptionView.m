//
//  ManWuDiiscountInfoDescriptionView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiiscountInfoDescriptionView.h"
#import "ManWuHomeActivityInfoModel.h"

@interface ManWuDiiscountInfoDescriptionView()

@property (nonatomic, strong) UIImageView                 *imageView;

@property (nonatomic, strong) ManWuHomeActivityInfoModel  *activityModel;

@end

@implementation ManWuDiiscountInfoDescriptionView

-(void)setupView{
    [super setupView];
    [self addSubview:self.imageView];
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        CGRect rect = self.bounds;
        rect.origin.y = 8;
        rect.size.height = rect.size.height - 8;
        _imageView = [[UIImageView alloc] initWithFrame:rect];
        [_imageView setImage:[UIImage imageNamed:@"home_discount_placehold_banner"]];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer* getstureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageViewClickEvent:)];
        [_imageView addGestureRecognizer:getstureRecognize];
    }
    return _imageView;
}

-(void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel{
    if (![descriptionModel isKindOfClass:[ManWuHomeActivityInfoModel class]]) {
        return;
    }
    self.activityModel = (ManWuHomeActivityInfoModel*)descriptionModel;
    [self reloadData];
    
}

-(void)reloadData{
    if (self.activityModel.picUrl) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.activityModel.picUrl] placeholderImage:[UIImage imageNamed:@"home_discount_placehold_banner"]];
    }else{
        [self.imageView setImage:[UIImage imageNamed:@"home_discount_placehold_banner"]];
    }
}

-(void)refresh{
    
}

-(void)handleImageViewClickEvent:(UITapGestureRecognizer *)getstureRecognize
{
    NSDictionary* params = @{@"activityModel":self.activityModel?:[WeAppComponentBaseItem new],@"actId":self.activityModel.typeId?:@"1"};
    TBOpenURLFromTargetWithNativeParams(internalURL(KManWuCommodityListForDiscount), self,nil,params);
}

@end
