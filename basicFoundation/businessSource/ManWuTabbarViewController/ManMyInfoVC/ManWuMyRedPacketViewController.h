//
//  ManWuMyRedPacketViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/6/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManWuMyRedPacketViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, WeAppBasicServiceDelegate>

@property (nonatomic, strong) UITableView *table;
//@property (nonatomic, strong) UIButton *btn_delete;
//@property (nonatomic, strong) UIButton *btn_done;

@property (nonatomic, strong) KSAdapterService *service;

@end
