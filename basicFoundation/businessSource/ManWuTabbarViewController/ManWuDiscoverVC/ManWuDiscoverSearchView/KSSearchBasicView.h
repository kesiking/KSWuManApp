//
//  KSGGShopAndPreferentialSearchView.h
//  GuangguangDemo
//
//  Created by 逸行 on 14-11-14.
//  Copyright (c) 2014年 ICSCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSTableViewController.h"

typedef void(^SearchCompleteBlock) (UISearchBar* searchBar,KSTableViewController* tableViewCtl);

typedef void(^SearchStartBlock) (UISearchBar* searchBar);

typedef void(^SearchChangeBlock) (UISearchBar* searchBar, NSString* searchText);

typedef void(^SearchCancelBlock) (UISearchBar* searchBar);

typedef void(^SearchEndBlock) (UISearchBar* searchBar, NSString* searchText);

@interface KSSearchBasicView : UIView<UISearchBarDelegate>{
    KSDataSource            *_dataSourceRead;
    KSTableViewController   *_tableViewCtl;
    UISearchBar             *_searchBar;
}

// 设置KSViewCell的类型，用于反射viewCell，在tableView中使用
-(instancetype)initWithFrame:(CGRect)frame viewCellClass:(Class)viewCellClass modelInfoClass:(Class)modelInfoClass;

// 重置searchview
-(void)resetSearchView;

// for override
-(void)setupView;

// 刷新tableview数据
-(void)reloadData;

-(void)cancel;

// 可操控searchbar所在的样式，例如加入回退按钮等
@property(nonatomic,strong) UIView              *navigateview;

/**
 *  searchBar位置
 */
@property(nonatomic,assign) CGRect                     searchBarRect;
@property(nonatomic,assign) CGRect                     searchBarSelectRect;

/**
 *  回调函数
 */
@property(nonatomic,strong) SearchCompleteBlock searchCompleteBlock;

@property(nonatomic,strong) SearchStartBlock    searchStarkBlock;

@property(nonatomic,strong) SearchChangeBlock   searchChangeBlock;

@property(nonatomic,strong) SearchCancelBlock   searchCancelBlock;

@property(nonatomic,strong) SearchEndBlock      searchEndBlock;

@end
