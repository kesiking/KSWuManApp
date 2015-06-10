//
//  KSLoginView.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "KSLoginViewCtl.h"
#import "KSLoginService.h"

@interface KSLoginView : KSView{
    KSLoginViewCtl    *_loginViewCtl;
    KSLoginService    *_service;
}

// 视觉控件集合
@property (nonatomic, strong,setter=setLoginViewCtl:,getter=getLoginViewCtl) KSLoginViewCtl    *loginViewCtl;

@property (nonatomic, strong,setter=setService:,getter=getService) KSLoginService    *service;

// 回调函数
@property (nonatomic, strong) loginActionBlock  loginActionBlock;

@property (nonatomic, strong) cancelActionBlock cancelActionBlock;

-(void)reloadData;

@end
