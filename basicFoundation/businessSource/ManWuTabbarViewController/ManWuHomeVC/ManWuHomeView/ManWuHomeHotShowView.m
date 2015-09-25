//
//  ManWuHomeHotShowView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/9/24.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHomeHotShowView.h"
#import "CSLinearLayoutView.h"
#import "ManWuHotShowItemVIew.h"

@interface ManWuHomeHotShowView()

@property (nonatomic, strong) CSLinearLayoutView   *linearContainer;
@property (nonatomic, strong) UIImageView          *bgImageView;

@end

@implementation ManWuHomeHotShowView

-(void)setupView{
    [super setupView];
    _viewListArray = [NSMutableArray array];
    self.padding = CSLinearLayoutMakePadding(0.0, 0.0, 4, 0);
    self.selectIndex = 0;
    [self addSubview: self.bgImageView];
    [self addSubview:self.linearContainer];
    self.backgroundColor = [UIColor clearColor];
}

-(void)reloadData{
    [self.linearContainer removeAllItems];
    for (UIView* subView in self.viewListArray) {
        if (![subView isKindOfClass:[UIView class]]) {
            continue;
        }
        CSLinearLayoutItem *subViewLayoutItem = [[CSLinearLayoutItem alloc]
                                                 initWithView:subView];
        subViewLayoutItem.padding             = self.padding;
        [self.linearContainer addItem:subViewLayoutItem];
    }
    [self sizeToFit];
}

#pragma mark - container

- (CSLinearLayoutView *)linearContainer {
    if (!_linearContainer) {
        float containerHeight = self.height;
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, containerHeight);
        _linearContainer = [[CSLinearLayoutView alloc] initWithFrame:frame];
        _linearContainer.orientation = CSLinearLayoutViewOrientationVertical;
        _linearContainer.autoAdjustFrameSize = YES;
        _linearContainer.backgroundColor  =  [UIColor clearColor];
    }
    return _linearContainer;
}

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.linearContainer.bounds];
        [_bgImageView setImage:[UIImage imageNamed:@"bg_add"]];
    }
    return _bgImageView;
}

-(void)resetDataList{
    [self.viewListArray removeAllObjects];
}

-(void)setupDataWithDataList:(NSArray*)dataList{
    if (dataList == nil) {
        return;
    }
    [self resetDataList];
    for (ManWuHomeAdvertisementModel *advertisementModel in dataList) {
        if (![advertisementModel isKindOfClass:[ManWuHomeAdvertisementModel class]]) {
            continue;
        }
        
        ManWuHotShowItemVIew *hotShowItemVIew = [[ManWuHotShowItemVIew alloc] initWithFrame:CGRectMake(0, 0, self.linearContainer.width, hotShowViewHeight)];
        hotShowItemVIew.advertisementModel = advertisementModel;
        WEAKSELF
        hotShowItemVIew.buttonClicedBlock = ^(ManWuHotShowItemVIew* hotShowItemVIew){
            STRONGSELF
            NSUInteger index = [strongSelf.viewListArray indexOfObject:hotShowItemVIew];
            if (index == NSNotFound) {
                return;
            }
            strongSelf.selectIndex = index;
            // 回调
            if (strongSelf.listViewClickedBlock) {
                strongSelf.listViewClickedBlock(strongSelf,strongSelf.selectIndex, hotShowItemVIew.advertisementModel);
            }
        };
        [self.viewListArray addObject:hotShowItemVIew];
    }
    [self reloadData];
}

-(CGSize)sizeThatFits:(CGSize)size{
    CGSize newSize = size;
    
    if ([self.viewListArray count] > 0) {
        newSize = CGSizeMake(newSize.width, self.linearContainer.height);
    }else{
        newSize = CGSizeMake(newSize.width, 0);
    }
    
    return newSize;
}

@end
