//
//  ManWuHomeViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHomeViewController.h"

@interface ManWuHomeViewController ()

@end

@implementation ManWuHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"屋满";
    UIButton* button = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    button.frame = CGRectMake(0, 0, 100, 100);
    [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)add{
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:@"commodityId",@"commodityId", nil];
    TBOpenURLFromTargetWithNativeParams(internalURL(kManWuCommodityList), self,nil,params);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
