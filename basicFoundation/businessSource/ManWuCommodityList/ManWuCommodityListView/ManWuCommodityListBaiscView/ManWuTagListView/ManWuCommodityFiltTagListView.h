//
//  ManWuCommodityFiltTagListView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-14.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "KSTagListLayoutView.h"

typedef void(^filtTagListViewSelectedBlock) (NSUInteger index,WeAppComponentBaseItem* componentItem);

typedef void(^cancelListViewBlock) (void);

@interface ManWuCommodityFiltTagListView : KSView

@property(nonatomic,strong) KSTagListLayoutView*        tagListLayoutView;

@property(nonatomic,strong) filtTagListViewSelectedBlock           filtTagListViewSelectedBlock;

@property(nonatomic,strong) cancelListViewBlock             cancelListViewBlock;

-(void)setDataWithPageList:(NSArray *)dataArray title:(NSString*)title;

@end
