//
//  ManWuCommodityListBasicViewController.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/18.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListBasicViewController.h"

@implementation ManWuCommodityListBasicViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    if ([self needRefreshPraise]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPraiseNotification:) name:kUserAddPraiseSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unAddPraiseNotification:) name:kUserUnAddPraiseSuccessNotification object:nil];
    }
    
    if ([self needRefreshFav]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addFavNotification:) name:kUserAddFavSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unAddFavNotification:) name:kUserUnAddFavSuccessNotification object:nil];
    }
    
}

-(BOOL)needRefreshFav{
    return NO;
}

-(BOOL)needRefreshPraise{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.shouldRefreshView) {
        self.shouldRefreshView = NO;
        [self refreshDataRequest];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)addPraiseNotification:(NSNotification*)notification{
    if (!self.isViewAppear) {
        self.shouldRefreshView = YES;
    }
}

-(void)unAddPraiseNotification:(NSNotification*)notification{
    if (!self.isViewAppear) {
        self.shouldRefreshView = YES;
    }
}

-(void)addFavNotification:(NSNotification*)notification{
    if (!self.isViewAppear) {
        self.shouldRefreshView = YES;
    }
}

-(void)unAddFavNotification:(NSNotification*)notification{
    if (!self.isViewAppear) {
        self.shouldRefreshView = YES;
    }
}

@end
