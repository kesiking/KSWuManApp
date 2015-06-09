//
//  KSRegisterView.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/9.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "KSRegisterViewCtl.h"

typedef void (^registerActionBlock)(BOOL registerSuccess);

typedef void (^cancelActionBlock)(void);

@interface KSRegisterView : KSView

// 视觉控件集合
@property (nonatomic, strong) KSRegisterViewCtl    *registerViewCtl;

// 回调函数
@property (nonatomic, strong) registerActionBlock   registerActionBlock;

@property (nonatomic, strong) cancelActionBlock     cancelActionBlock;

-(void)reloadData;

@end
