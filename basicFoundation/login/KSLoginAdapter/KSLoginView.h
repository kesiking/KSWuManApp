//
//  KSLoginView.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "KSLoginViewCtl.h"

@interface KSLoginView : KSView

// login请求所需的内容
@property (nonatomic, strong) NSString          *loginApiName;

@property (nonatomic, strong) NSString          *loginUserIdKey;

@property (nonatomic, strong) NSString          *loginSecurityKey;

// 视觉控件集合
@property (nonatomic, strong) KSLoginViewCtl    *loginViewCtl;

// 回调函数
@property (nonatomic,strong ) loginActionBlock  loginActionBlock;

@property (nonatomic,strong ) cancelActionBlock cancelActionBlock;

@end
