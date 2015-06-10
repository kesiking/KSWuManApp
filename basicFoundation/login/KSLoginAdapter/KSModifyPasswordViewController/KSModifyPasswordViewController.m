//
//  KSModifyPasswordViewController.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/10.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSModifyPasswordViewController.h"
#import "KSModifyPasswordView.h"
#import "KSLoginComponentItem.h"

@interface KSModifyPasswordViewController ()

@property (nonatomic, strong) KSModifyPasswordView  *modifyPasswordView;

@property (nonatomic, strong) NSString              *phoneNum;

@end

@implementation KSModifyPasswordViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    self = [self init];
    if (self) {
        self.phoneNum = [nativeParams objectForKey:@"phoneNum"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    self.title = @"找回密码";
    [self.view addSubview:self.modifyPasswordView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(KSModifyPasswordView *)modifyPasswordView{
    if (_modifyPasswordView == nil) {
        _modifyPasswordView = [[KSModifyPasswordView alloc] initWithFrame:self.view.bounds];
        _modifyPasswordView.phoneNum = self.phoneNum?:[KSLoginComponentItem sharedInstance].phone;
        WEAKSELF
        _modifyPasswordView.modifyPasswordAction = ^(BOOL resetSuccess){
            STRONGSELF
            [strongSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _modifyPasswordView;
}

@end
