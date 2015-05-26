//
//  ManWuCommodityFiltTagListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-14.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityFiltTagListView.h"
#import "ManWuCommodityFiltTagCellView.h"
#import "ManWuCommodityFiltTabLabel.h"
#import "ManWuDiscoverModel.h"

#define tag_width  (40 * SCREEN_SCALE)
#define tag_height (20 * SCREEN_SCALE)

@interface ManWuCommodityFiltTagListView()<KSTagListSelectDelegate>

@property (nonatomic,strong) UIButton*                   cancelButton;

@property (nonatomic,strong) NSArray *                   discoverModels;

@end

@implementation ManWuCommodityFiltTagListView

-(void)setupView{
    [super setupView];
    [self addSubview:self.cancelButton];
    [self addSubview:self.tagListLayoutView];
    /*
    NSMutableArray* arrayData = [[NSMutableArray alloc] init];
    NSMutableArray* tagCells = [NSMutableArray array];
    
    ManWuCommodityFiltTabLabel* cellLabel = [[ManWuCommodityFiltTabLabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [cellLabel setTitle:@"男装"];
    [tagCells addObject:cellLabel];
    
    for (int i = 0; i < 10 ; i++) {
        WeAppComponentBaseItem* component = [[WeAppComponentBaseItem alloc] init];
        [arrayData addObject:component];
        ManWuCommodityFiltTagCellView* cellView = [[ManWuCommodityFiltTagCellView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        [cellView setTitle:[NSString stringWithFormat:@"fdsfas%d",rand()%1000]];
        [tagCells addObject:cellView];
    }
     
    [self.tagListLayoutView setViewItems:tagCells];
     */
    
}

-(void)setDataWithPageList:(NSArray *)dataArray title:(NSString*)title{
    if (dataArray == nil || [dataArray count] == 0) {
        return;
    }
    // do clear
    self.discoverModels = nil;
    
    // do init
    self.discoverModels = dataArray;
    
    NSMutableArray* tagCells = [NSMutableArray array];
    
    ManWuCommodityFiltTagCellView* cellLabel = [[ManWuCommodityFiltTagCellView alloc] initWithFrame:CGRectMake(0, 0, tag_width, tag_height)];
    if (title) {
        [cellLabel setTitle:[NSString stringWithFormat:@"%@:",title]];
    }
    [cellLabel.tagCellButton setBackgroundColor:self.backgroundColor];
    [tagCells addObject:cellLabel];
    
    for (ManWuDiscoverModel *discoverModel in dataArray) {
        if (![discoverModel isKindOfClass:[ManWuDiscoverModel class]]) {
            continue;
        }
        ManWuCommodityFiltTagCellView* cellView = [[ManWuCommodityFiltTagCellView alloc] initWithFrame:CGRectMake(0, 0, tag_width, tag_height)];
        [cellView setTitle:discoverModel.name];
        [tagCells addObject:cellView];
    }
    
    [self.tagListLayoutView setViewItems:tagCells];

    [self.tagListLayoutView sizeToFit];
    CGRect rect = self.tagListLayoutView.frame;
    rect.size.height += 10;
    [self.tagListLayoutView setFrame:rect];
}

-(KSTagListLayoutView *)tagListLayoutView{
    if (_tagListLayoutView == nil) {
        _tagListLayoutView = [[KSTagListLayoutView alloc] initWithFrame:self.bounds];
        _tagListLayoutView.backgroundColor = [UIColor whiteColor];
        _tagListLayoutView.delegate = self;
    }
    return _tagListLayoutView;
}

-(UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] initWithFrame:self.bounds];
        [_cancelButton setBackgroundColor:[UIColor clearColor]];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(void)cancelButtonClick:(id)sender{
    if (self.cancelListViewBlock) {
        self.cancelListViewBlock();
    }
}

- (void)clickedControl:(UIView<KSTagListSelectProtocal> *)control index:(NSUInteger)index{
    if (self.discoverModels == nil || index >= [self.discoverModels count] + 1 || index < 1) {
        return;
    }
    WeAppComponentBaseItem* componentItem = [self.discoverModels objectAtIndex:index - 1];
    if (self.filtTagListViewSelectedBlock) {
        self.filtTagListViewSelectedBlock(index,componentItem);
    }
}

@end
