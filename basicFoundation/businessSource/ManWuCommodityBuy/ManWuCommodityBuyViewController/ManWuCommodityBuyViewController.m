//
//  ManWuCommodityBuyViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-29.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityBuyViewController.h"
#import "ManWuBuyScrollView.h"

@interface ManWuCommodityBuyViewController ()

@property (nonatomic, strong) ManWuBuyScrollView             *buyScrollView;

@end

@implementation ManWuCommodityBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.buyScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ManWuBuyScrollView *)buyScrollView{
    if(_buyScrollView == nil){
        _buyScrollView = [[ManWuBuyScrollView alloc] initWithFrame:self.view.bounds];
    }
    return _buyScrollView;
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
