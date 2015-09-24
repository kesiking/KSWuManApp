//
//  ManWuHomeHotShowView.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/9/24.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"

#define hotShowViewHeight (128)

@class ManWuHomeHotShowView;

typedef void (^doListViewClickedBlock)  (ManWuHomeHotShowView* listView, NSInteger index, id dataInfo);


@interface ManWuHomeHotShowView : KSView{
    NSMutableArray              *_viewListArray;
    CSLinearLayoutView          *_linearContainer;
}

@property (nonatomic, strong) NSMutableArray *            viewListArray;

@property (nonatomic, assign) CSLinearLayoutItemPadding   padding;

@property (nonatomic, assign) NSInteger                   selectIndex;

// 某个baby被选中时触发，告知宝贝信息
@property (nonatomic, copy)   doListViewClickedBlock  listViewClickedBlock;

-(void)setupDataWithDataList:(NSArray*)dataList;

-(void)resetDataList;

-(void)reloadData;

@end
