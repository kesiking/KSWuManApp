//
//  ManWuCommodityListBasicViewController.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/18.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSManWuViewController.h"
#import "ManWuPraiseService.h"
#import "ManWuFavService.h"

@interface ManWuCommodityListBasicViewController : KSManWuViewController

@property (nonatomic,assign) BOOL           shouldRefreshView;

-(BOOL)needRefreshFav;

-(BOOL)needRefreshPraise;

@end
