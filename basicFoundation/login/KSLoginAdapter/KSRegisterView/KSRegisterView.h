//
//  KSRegisterView.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/9.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "KSRegisterViewCtl.h"
#import "KSLoginService.h"

typedef void (^registerActionBlock)(BOOL registerSuccess);

typedef void (^cancelActionBlock)(void);

@interface KSRegisterView : KSView{
    KSRegisterViewCtl    *_registerViewCtl;
    KSLoginService       *_registerService;
    KSLoginService       *_validateCodeService;
}


// 视觉控件集合
@property (nonatomic, strong,setter=setRegisterViewCtl:,getter=getRegisterViewCtl) KSRegisterViewCtl     *registerViewCtl;

@property (nonatomic, strong,setter=setRegisterService:,getter=getRegisterService) KSLoginService        *registerService;

@property (nonatomic, strong,setter=setValidateCodeService:,getter=getValidateCodeService) KSLoginService        *validateCodeService;

// 回调函数
@property (nonatomic, strong) registerActionBlock   registerActionBlock;

@property (nonatomic, strong) cancelActionBlock     cancelActionBlock;

-(void)reloadData;

@end
