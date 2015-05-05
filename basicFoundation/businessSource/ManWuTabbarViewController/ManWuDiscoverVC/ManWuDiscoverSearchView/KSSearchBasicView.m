//
//  KSGGShopAndPreferentialSearchView.m
//  GuangguangDemo
//
//  Created by 逸行 on 14-11-14.
//  Copyright (c) 2014年 ICSCN. All rights reserved.
//

#import "KSSearchBasicView.h"
#import "KSTableViewController.h"
#import "KSViewCell.h"

#define SEARCH_BAR_HEIGHT (44)
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define labelViewTag 1002

@interface KSSearchBasicView ()<UISearchBarDelegate>

@property(nonatomic,strong) KSTableViewController     *tableViewCtl;
@property(nonatomic,strong) KSDataSource              *dataSourceRead;

@property(nonatomic,strong) UISearchBar               *searchBar;
@property(nonatomic,strong) UIButton                  *btnAccessoryView;

/**
 *  searchBar位置
 */
@property(nonatomic,assign) CGRect                     searchBarRect;
@property(nonatomic,assign) CGRect                     searchBarSelectRect;

@end

@implementation KSSearchBasicView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    [self create];
}

-(void)create
{
    self.backgroundColor = [UIColor whiteColor];
    [self initSearchBar];
    [self initTableView];
}

-(void)initTableView {
    //init tableView
    KSCollectionViewConfigObject* configObject = [[KSCollectionViewConfigObject alloc] init];
    [configObject setupStandConfig];
    configObject.collectionCellSize = CGSizeZero;
    configObject.needQueueLoadData = NO;
    configObject.needRefreshView = NO;
    CGRect frame = self.bounds;
    frame.origin.y = self.navigateview.bottom;
    frame.size.height -= self.navigateview.height;
    self.tableViewCtl = [[KSTableViewController alloc] initWithFrame:frame withConfigObject:configObject];
    [self.tableViewCtl registerClass:[KSViewCell class]];
    UITableView* tableView = [self.tableViewCtl getTableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.scrollsToTop = YES;
    [self addSubview:tableView];
}

-(void)initSearchBar{
    CGFloat navigateViewYOringe = (IOS_VERSION<7?0:20);
    _navigateview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, UI_NAVIGATION_HEIGHT)];
    _navigateview.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    _navigateview.backgroundColor=[UIColor colorWithPatternImage:LOADIMAGE(@"navigate_background")];
    
    self.searchBarRect = CGRectMake(0, navigateViewYOringe, self.navigateview.frame.size.width - 5, SEARCH_BAR_HEIGHT);
    self.searchBarSelectRect = CGRectMake(0,navigateViewYOringe, self.navigateview.frame.size.width, SEARCH_BAR_HEIGHT);
    
    _searchbarbackgroundview = [[UIView alloc] initWithFrame:self.searchBarRect];
    _searchbarbackgroundview.backgroundColor=[UIColor yellowColor];
    _searchbarbackgroundview.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    
    [_navigateview addSubview:_searchbarbackgroundview];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:_searchbarbackgroundview.bounds];
    self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.searchBar.backgroundImage=LOADIMAGE(@"navigate_background");
    [self.searchBar setSearchTextPositionAdjustment:UIOffsetMake(0, 0)];// 设置搜索框中文本框的文本偏移量
    [self.searchBar setAutocorrectionType:UITextAutocorrectionTypeDefault];
    self.searchBar.delegate = self;
    
    [_searchbarbackgroundview addSubview:self.searchBar];
    
    [self.searchBar sizeToFit];
    
    [self addSubview:self.navigateview];
}

-(KSDataSource *)dataSourceRead {
    if (!_dataSourceRead) {
        _dataSourceRead = [[KSDataSource alloc]init];
    }
    return _dataSourceRead;
}

-(UIButton*)btnAccessoryView{
    if (_btnAccessoryView == nil) {
        _btnAccessoryView=[[UIButton alloc] initWithFrame:CGRectMake(0, _navigateview.frame.origin.y + _navigateview.height, self.width, self.height)];
        [_btnAccessoryView setBackgroundColor:[UIColor blackColor]];
        [_btnAccessoryView setAlpha:0.0f];
        [_btnAccessoryView addTarget:self action:@selector(ClickControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnAccessoryView];
    }
    return _btnAccessoryView;
}

-(void)setShowSearchChoose:(BOOL)showSearchChoose{
    _showSearchChoose = showSearchChoose;
    if (showSearchChoose) {
        CGRect rect = self.searchBarSelectRect;
        rect.origin.x = 30;
        rect.size.width = rect.size.width - 30;
        self.searchBarSelectRect = rect;
    }
}

#pragma mark - reset searchView

-(void)resetSearchView{
    self.searchBar.text = @"";
    [self.tableViewCtl reloadData];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark private method

#pragma mark - btnAccessoryView

// 遮罩层（按钮）-点击处理事件
- (void) ClickControlAction:(id)sender{
    NSLog(@"handleTaps");
    [self controlAccessoryView:0];
}

// 控制遮罩层的透明度
- (void)controlAccessoryView:(float)alphaValue{
    [UIView animateWithDuration:0.2 animations:^{
        //动画代码
        [self.btnAccessoryView setAlpha:alphaValue];
    }completion:^(BOOL finished){
        if (alphaValue<=0 && [self.searchBar isFirstResponder]) {
            [self.searchBar resignFirstResponder];
            [self.searchBar setShowsCancelButton:NO animated:YES];
            [self controlSearchBarAnimation:YES completion:nil];
        }
    }];
}

#pragma mark - UISearchBarDelegate Delegate

-(void)controlSearchBarAnimation:(BOOL)searchBarIsShow completion:(void (^)(BOOL finished))completion{
    if (searchBarIsShow) {
        [UIView animateWithDuration:0.2 animations:^{
            //动画代码
            [self.searchbarbackgroundview setFrame:self.searchBarRect];
            [self.searchBar sizeToFit];
        }completion:^(BOOL finished){
            if (completion) {
                completion(finished);
            }
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            //动画代码
            [self.searchbarbackgroundview setFrame:self.searchBarSelectRect];
            [self.searchBar sizeToFit];
        }completion:^(BOOL finished){
            if (completion) {
                completion(finished);
            }
        }];
    }
    
}

//点击搜索框时调用

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar

{
    if (self.searchStarkBlock) {
        self.searchStarkBlock(self.searchBar);
    }
    [self controlSearchBarAnimation:NO completion:nil];
    [self.searchBar becomeFirstResponder];
    [self.searchBar setShowsCancelButton:YES animated:YES];
    [self controlAccessoryView:0.7];// 隐藏遮盖层。
}

// 取消按钮被按下时，执行的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self controlSearchBarAnimation:YES completion:nil];
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self controlAccessoryView:0];// 隐藏遮盖层。
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (self.searchChangeBlock) {
        self.searchChangeBlock(searchBar,searchText);
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *trimmedKeyword = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (trimmedKeyword == nil || trimmedKeyword.length == 0 || [trimmedKeyword isEqualToString:@""]) {
        return;
    }else if ([trimmedKeyword length] >= 255) {
        trimmedKeyword = [trimmedKeyword substringToIndex:255];
    }
    // 转义字符
    
    [self controlSearchBarAnimation:YES completion:nil];
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self controlAccessoryView:0];// 隐藏遮盖层。
    if (self.searchEndBlock) {
        self.searchEndBlock(searchBar,trimmedKeyword);
    }
}

@end
