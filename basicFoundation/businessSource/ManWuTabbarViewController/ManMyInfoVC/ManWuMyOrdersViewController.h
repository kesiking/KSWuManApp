//
//  ManWuMyOrdersViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/5/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTHorizontalSelectionList.h"

@interface ManWuMyOrdersViewController : KSViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,WeAppBasicServiceDelegate,HTHorizontalSelectionListDataSource,HTHorizontalSelectionListDelegate>

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) NSArray *orderMarks;
@property (nonatomic, strong) UILabel *selectedItemLabel;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, assign) NSInteger origIndex;   //初始选项

@property (nonatomic, strong) KSAdapterService *service;

@end
