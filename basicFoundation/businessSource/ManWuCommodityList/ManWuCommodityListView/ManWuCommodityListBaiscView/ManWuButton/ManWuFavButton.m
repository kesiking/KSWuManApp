//
//  ManWuFavButton.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuFavButton.h"
#import "ManWuFavService.h"

@interface ManWuFavButton()

@property(nonatomic,assign)  BOOL               isFavorate;

@property(nonatomic,strong)  UIImage*           favorateImage;

@property(nonatomic,strong)  UIImage*           unfavorateImage;

@end

@implementation ManWuFavButton

-(void)setupView{
    [super setupView];
    ManWuFavService* service = [[ManWuFavService alloc] init];
    [self setService:service];
    self.messageForFailResponse = @"收藏失败";
    self.messageForSuccessResponse = @"收藏成功";
    self.favorateImage = [UIImage imageNamed:@"favorate_button_image"];
    self.unfavorateImage = [UIImage imageNamed:@"unFavorate_button_image"];
    [self updateFavBtnStatus:NO];
}

-(void)buttonClickEvent{
    if ([self canResponseRequest]) {
        // todo service request
        if (!self.isFavorate) {
            [((ManWuFavService*)self.service) addFavorateWithItemId:self.itemId];
        }else{
            [((ManWuFavService*)self.service) unAddFavorateWithItemId:self.itemId];
        }
    }
}

-(void)updateFavBtnStatus:(BOOL)isFavorate{
    self.isFavorate = isFavorate;
    if (isFavorate) {
        [self setImage:self.favorateImage forState:UIControlStateNormal];
    }else{
        [self setImage:self.unfavorateImage forState:UIControlStateNormal];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark WeAppBasicServiceDelegate method

- (void)serviceDidFinishLoad:(WeAppBasicService *)service{
    [super serviceDidFinishLoad:service];
    [self updateFavBtnStatus:!self.isFavorate];
}

@end
