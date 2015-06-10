//
//  KSResetPasswordViewController.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/10.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSResetPasswordViewController.h"
#import "KSResetView.h"

@interface KSResetPasswordViewController ()

@property (nonatomic,strong) KSResetView       *resetView;

@end

@implementation KSResetPasswordViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    self = [self init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    self.title = @"找回密码";
    [self.view addSubview:self.resetView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(KSResetView *)resetView{
    if (_resetView == nil) {
        _resetView = [[KSResetView alloc] initWithFrame:self.view.bounds];
    }
    return _resetView;
}

@end
