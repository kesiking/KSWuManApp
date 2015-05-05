//
//  KSGGShopAndPreferentialSearchView.h
//  GuangguangDemo
//
//  Created by 逸行 on 14-11-14.
//  Copyright (c) 2014年 ICSCN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchCompleteBlock) (BOOL complete, BOOL animation, UISearchBar* searchView);

typedef void(^SearchStartBlock) (UISearchBar* searchView);

typedef void(^SearchChangeBlock) (UISearchBar* searchView, NSString* searchText);

typedef void(^SearchEndBlock) (UISearchBar* searchView, NSString* searchText);

@interface KSSearchBasicView : UIView

-(void)resetSearchView;

-(void)setupView;

@property(nonatomic,strong) UIView              *navigateview;

@property(nonatomic,strong) UIView              *searchbarbackgroundview;

@property(nonatomic,strong) UIView              *leftView;

@property(nonatomic,assign) BOOL                showSearchChoose;

@property(nonatomic,strong) SearchCompleteBlock searchCompleteBlock;

@property(nonatomic,strong) SearchStartBlock    searchStarkBlock;

@property(nonatomic,strong) SearchChangeBlock   searchChangeBlock;

@property(nonatomic,strong) SearchEndBlock      searchEndBlock;

@end
