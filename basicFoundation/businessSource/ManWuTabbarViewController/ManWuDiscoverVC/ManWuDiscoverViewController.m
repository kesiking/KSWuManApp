//
//  ManWuDiscoverViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiscoverViewController.h"
#import "ManWuDiscoverListView.h"

@interface ManWuDiscoverViewController ()

@property (nonatomic ,strong) ManWuDiscoverListView*          discoverListView;

@end

@implementation ManWuDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发现";
    [self.view addSubview:self.discoverListView];
}

-(void)viewDidUnload{
    self.discoverListView = nil;
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ManWuDiscoverListView *)discoverListView{
    if (_discoverListView == nil) {
        _discoverListView = [[ManWuDiscoverListView alloc] initWithFrame:self.view.bounds];
    }
    return _discoverListView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
