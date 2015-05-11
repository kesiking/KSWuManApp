//
//  ManWuPraiseButton.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuPraiseButton.h"
#import "ManWuPraiseService.h"

@interface ManWuPraiseButton()

@property(nonatomic,assign)  BOOL               isPraise;

@property(nonatomic,strong)  UIImage*           praiseImage;

@property(nonatomic,strong)  UIImage*           unpraiseImage;

@end

@implementation ManWuPraiseButton

-(void)setupView{
    [super setupView];
    ManWuPraiseService* service = [[ManWuPraiseService alloc] init];
    [self setService:service];
    self.praiseImage = [UIImage imageNamed:@"praise_button_image"];
    self.unpraiseImage = [UIImage imageNamed:@"unPraise_button_image"];
    [self updatePraiseBtnStatus:NO];
}

-(void)buttonClickEvent{
    if ([self canResponseRequest]) {
        // todo service request
//        [self updatePraiseBtnStatus:!self.isPraise];
        [((ManWuPraiseService*)self.service) addPraise];
    }
}

-(void)updatePraiseBtnStatus:(BOOL)isPraise{
    self.isPraise = isPraise;
    if (isPraise) {
        [self setImage:self.praiseImage forState:UIControlStateNormal];
    }else{
        [self setImage:self.unpraiseImage forState:UIControlStateNormal];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark WeAppBasicServiceDelegate method

- (void)serviceDidFinishLoad:(WeAppBasicService *)service{
    [super serviceDidFinishLoad:service];
    [self updatePraiseBtnStatus:!self.isPraise];
}

@end
