//
//  KSScrollViewServiceController.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSScrollViewController.h"
#import "KSScrollViewConfigObject.h"

@interface KSScrollViewServiceController : KSScrollViewController<WeAppBasicServiceDelegate>

@property (nonatomic, strong) KSScrollViewConfigObject*     configObject;

@property (nonatomic, strong) WeAppBasicService*            service;

@property (nonatomic, strong) NSString*                     errorViewTitle;

@property (nonatomic, strong) UIView*                       nextFootView;

-(instancetype)initWithConfigObject:(KSScrollViewConfigObject*)configObject;

// 配置下拉刷新
-(void)configPullToRefresh:(UIScrollView*)scrollView;

// override subclass 下拉刷新service
-(void)refresh;

// override subclass 翻页service
-(void)nextPage;

// override subclass 是否需要翻页
-(BOOL)needNextPage;

// override subclass 根据service状态判断是否可以翻页
-(BOOL)canNextPage;

// override subclass 设置footView 翻页时提醒
-(void)setFootView:(UIView*)view;

// override subclass 是否需要footView
-(BOOL)needFootView;

// override subclass 数据返回后回调用refreshData，最后会调用reloadData接口
-(void)refreshData;

@end
