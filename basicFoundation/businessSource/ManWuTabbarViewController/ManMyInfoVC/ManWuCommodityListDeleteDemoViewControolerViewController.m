//
//  ManWuCommodityListDeleteDemoViewControolerViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListDeleteDemoViewControolerViewController.h"
#import "ManWuCommodityListForDeleteView.h"

@interface ManWuCommodityListDeleteDemoViewControolerViewController ()

@property (nonatomic,strong) ManWuCommodityListForDeleteView* commodityListView;

@end

@implementation ManWuCommodityListDeleteDemoViewControolerViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        NSString* commodityId = [nativeParams objectForKey:@"commodityId"];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我喜欢的";
    [self.view addSubview:self.commodityListView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(edit)];
}

-(void)viewDidUnload{
    self.commodityListView = nil;
    [super viewDidUnload];
}

- (void)edit{
    [self.commodityListView setIsCollectionEdit:!self.commodityListView.isCollectionEdit];
}

-(ManWuCommodityListForDeleteView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuCommodityListForDeleteView alloc] initWithFrame:self.view.bounds];
    }
    return _commodityListView;
}

@end
