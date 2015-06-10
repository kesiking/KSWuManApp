//
//  KSResetView.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/10.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "KSResetViewCtl.h"
#import "KSLoginService.h"

@interface KSResetView : KSView{
    KSResetViewCtl    *_resetViewCtl;
    KSLoginService    *_validateCodeService;
}

// 视觉控件集合
@property (nonatomic, strong,setter=setResetViewCtl:,getter=getResetViewCtl) KSResetViewCtl    *resetViewCtl;

@property (nonatomic, strong,setter=setValidateCodeService:,getter=getValidateCodeService) KSLoginService        *validateCodeService;

@end
