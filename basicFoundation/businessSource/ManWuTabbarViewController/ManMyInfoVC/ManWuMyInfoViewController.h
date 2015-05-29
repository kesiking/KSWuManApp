//
//  ManWuMyInfoViewController.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSTabbarViewController.h"
#import "UserInfoViewItem.h"

@interface ManWuMyInfoViewController : KSTabbarViewController<UITableViewDataSource,UITableViewDelegate,UserInfoViewItemDelegate,WeAppBasicServiceDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) CSLinearLayoutView *myInfoContainer;
@property (nonatomic, strong) UIView *userInfoView;
@property (nonatomic, strong) UIButton *btn_config;

@property (nonatomic, strong) KSAdapterService *service;

@end
