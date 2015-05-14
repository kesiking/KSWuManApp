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

@interface ManWuCommodityFiltTagListView()<KSTagListSelectDelegate>

@property (nonatomic,strong) UIButton*                   cancelButton;

@end

@implementation ManWuCommodityFiltTagListView

-(void)setupView{
    [super setupView];
    [self addSubview:self.cancelButton];
    
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
    [self.tagListLayoutView sizeToFit];
    [self addSubview:self.tagListLayoutView];
}

-(KSTagListLayoutView *)tagListLayoutView{
    if (_tagListLayoutView == nil) {
        _tagListLayoutView = [[KSTagListLayoutView alloc] initWithFrame:self.bounds];
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
    if (self.filtTagListViewSelectedBlock) {
        self.filtTagListViewSelectedBlock(index,nil);
    }
}

@end
