//
//  ManWuOperationButton.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManWuOperationButton : UIButton<WeAppBasicServiceDelegate>

@property(nonatomic,strong)  KSAdapterService*  service;

@property(nonatomic,strong)  NSString*          messageForFailResponse;

@property(nonatomic,strong)  NSString*          messageForSuccessResponse;

@property(nonatomic,assign)  BOOL               isLoading;

-(void)setupView;

-(BOOL)canResponseRequest;

-(void)setImage:(UIImage *)image;

-(void)buttonClickEvent;

@end
