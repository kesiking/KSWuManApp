//
//  ManWuSearchView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-5.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuSearchView.h"

@implementation ManWuSearchView

-(void)setupView{
    [super setupView];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [super searchBarSearchButtonClicked:searchBar];
    NSMutableArray* arrayData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20 ; i++) {
        WeAppComponentBaseItem* component = [[WeAppComponentBaseItem alloc] init];
        [arrayData addObject:component];
    }
    [_dataSourceRead setDataWithPageList:arrayData extraDataSource:nil];
    [self reloadData];
}

@end
