//
//  ManWuLoginDemoViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuLoginDemoViewController.h"
#import "ManWuLoginContent.h"

@interface ManWuLoginDemoViewController()

@property (nonatomic,strong) loginActionBlock        loginActionBlock;

@property (nonatomic,strong) cancelActionBlock       cancelActionBlock;

@end

@implementation ManWuLoginDemoViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    self = [self init];
    if (self) {
        self.loginActionBlock = [nativeParams objectForKey:kLoginSuccessBlock];
        self.cancelActionBlock = [nativeParams objectForKey:kLoginCancelBlock];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = NO;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStyleBordered target:self action:@selector(login:)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    
    UIButton* rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.right - 100, 0, 100, 50)];
    [rightButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor = [UIColor redColor];
    UIButton* leftButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.left, 0, 100, 50)];
    [leftButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:leftButton];
    [self.view addSubview:rightButton];
}

-(void)login:(UIBarButtonItem*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.loginActionBlock) {
        self.loginActionBlock(YES);
    }
}

-(void)cancel:(UIBarButtonItem*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.cancelActionBlock) {
        self.cancelActionBlock();
    }
}

@end
