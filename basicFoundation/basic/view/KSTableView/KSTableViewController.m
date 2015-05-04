//
//  KSTableViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-26.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSTableViewController.h"
#import "WeAppTableViewCell.h"

@interface KSTableViewController ()

@property (nonatomic, strong) UITableView*         tableView;

@property (nonatomic, strong) Class                viewCellClass;

@end

@implementation KSTableViewController

@synthesize tableView = _tableView;

-(instancetype)initWithFrame:(CGRect)frame withConfigObject:(KSCollectionViewConfigObject*)configObject{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.configObject = configObject;
        self.scrollView = (UIScrollView*)[self createView];
    }
    return self;
}

-(instancetype)initWithConfigObject:(KSScrollViewConfigObject *)configObject{
    self = [super initWithConfigObject:configObject];
    if (self) {
        self.configObject = configObject;
        self.scrollView = (UIScrollView*)[self createView];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.scrollView = (UIScrollView*)[self createView];
    }
    return self;
}

-(UIView *)createView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self configPullToRefresh:_tableView];
        
        self.canImageRefreshed = YES;
    }
    return _tableView;
}

-(void)dealloc {
    if (_tableView) {
        _tableView.delegate = nil;
        _tableView.dataSource = nil;
        _tableView = nil;
    }
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}

-(void)updateCollectionConfigObject:(KSCollectionViewConfigObject*)configObject{
    if (self.configObject != configObject) {
        self.configObject = configObject;
    }
}

-(void)registerClass:(Class)viewCellClass{
    self.viewCellClass = viewCellClass;
}

-(UITableView*)getTableView{
    return self.tableView;
}

-(void)refreshData {
    if (self.tableView == nil) {
        return;
    }
    [super refreshData];
}

-(void)reloadData{
    [self.tableView reloadData];
}

-(void)setFootView:(UIView*)view{
    if (view == nil) {
        return;
    }
    [self setTableFooterView:view];
}

-(void)setTableFooterView:(UIView *)tableFooterView{
    self.tableView.tableFooterView = tableFooterView;
}

-(void)setTableHeaderView:(UIView *)tableHeaderView{
    self.tableView.tableHeaderView = tableHeaderView;
}

- (void)loadImagesForOnscreenCells{
    NSArray *indexPaths = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *visibleIndexPath in indexPaths) {
        if (visibleIndexPath.row >= 0) {
            WeAppTableViewCell *cell = (WeAppTableViewCell *)[self.tableView cellForRowAtIndexPath:visibleIndexPath];
            BOOL imageLoaded = [self.dataSourceRead getImageDidLoadedWithIndex:[visibleIndexPath row]];
            //如果imageLoaded标志位不存在或是为NO则刷新，如果canImageRefreshed被设为NO，表示速度过快优化后不再加载图片，因此也需要刷新
            if(!imageLoaded || self.canImageRefreshed){
                WeAppComponentBaseItem* componentItem = [self.dataSourceRead getComponentItemWithIndex:[visibleIndexPath row]];
                KSCellModelInfoItem* modelInfoItem = [self.dataSourceRead getComponentModelInfoItemWithIndex:[visibleIndexPath row]];
                [cell refreshCellImagesWithComponentItem:componentItem extroParams:modelInfoItem];
                modelInfoItem.imageHasLoaded = YES;
            }
        }
    }
}

#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.dataSourceRead count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeAppTableViewCell *cell = (WeAppTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[WeAppTableViewCell reuseIdentifier]];
    
    //获取cell模板数据
    WeAppComponentBaseItem *componentItem = [self.dataSourceRead getComponentItemWithIndex:[indexPath row]];
    KSCellModelInfoItem* modelInfoItem = [self.dataSourceRead getComponentModelInfoItemWithIndex:[indexPath row]];
    
    CGRect rect = CGRectZero;
    if(CGSizeEqualToSize(CGSizeZero, ((KSCollectionViewConfigObject*)self.configObject).collectionCellSize)){
        KSCellModelInfoItem* modelInfoItem = [self.dataSourceRead getComponentModelInfoItemWithIndex:[indexPath row]];
        rect = CGRectMake(0, 0, self.tableView.width, modelInfoItem.frame.size.height);
    }else{
        rect = CGRectMake(0, 0, self.tableView.width, ((KSCollectionViewConfigObject*)self.configObject).collectionCellSize.height);
    }
    
    if (!cell) {
        cell = [WeAppTableViewCell createCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    //保证cell中的可以重用
    if (componentItem) {
        [cell setViewCellClass:self.viewCellClass];
        [cell configCellWithFrame:rect componentItem:componentItem extroParams:modelInfoItem];
    }
    
    if (self.canImageRefreshed && [self needQueueLoadData]) {
        //当UItableViewCell还没有图像信息的时候
        //table停止不再滑动的时候下载图片（先用默认的图片来代替Cell的image）
        /**/
        // 因为性能问题先注释
        if (tableView.dragging == NO
            && tableView.decelerating == NO
            && !modelInfoItem.imageHasLoaded)
        {
            [cell refreshCellImagesWithComponentItem:componentItem extroParams:modelInfoItem];
            modelInfoItem.imageHasLoaded = YES;
        }
        /**/
    }
    
    [self configTableView:tableView withCollectionViewCell:cell cellForItemAtIndexPath:indexPath];
    
    
    return cell;
}

-(void)configTableView:(UITableView *)tableView withCollectionViewCell:(UITableViewCell*)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 结束reload
    /**********************************************************************
     翻页逻辑，grid的scroll滑动导致一下子会翻页多屏幕数据
     **********************************************************************/
    /**************************/
    if ([indexPath row] >= [self.dataSourceRead count] - 1) {
        if ([self canNextPage]) {
            [self nextPage];
        }
    }
    /**************************/
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(CGSizeEqualToSize(CGSizeZero, ((KSCollectionViewConfigObject*)self.configObject).collectionCellSize)){
        KSCellModelInfoItem* modelInfoItem = [self.dataSourceRead getComponentModelInfoItemWithIndex:[indexPath row]];
        return modelInfoItem.frame.size.height;
    }
    return ((KSCollectionViewConfigObject*)self.configObject).collectionCellSize.height;
}

// 用于展示加载动画
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Select Item
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WeAppTableViewCell *cell = (WeAppTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        //获取cell模板数据
        WeAppComponentBaseItem *componentItem = [self.dataSourceRead getComponentItemWithIndex:[indexPath row]];
        KSCellModelInfoItem* modelInfoItem = [self.dataSourceRead getComponentModelInfoItemWithIndex:[indexPath row]];
        [cell didSelectItemWithComponentItem:componentItem extroParams:modelInfoItem];
    }
}

@end
