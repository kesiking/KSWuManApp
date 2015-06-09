//
//  KSRegisterViewController.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/9.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSRegisterViewController.h"
#import "KSRegisterView.h"
#import "KSLoginMaroc.h"

@interface KSRegisterViewController ()

@property (nonatomic,strong) registerActionBlock  registerActionBlock;

@property (nonatomic,strong) cancelActionBlock    cancelActionBlock;

@property (nonatomic,strong) KSRegisterView       *registerView;

@end

@implementation KSRegisterViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    self = [self init];
    if (self) {
        self.registerActionBlock = [nativeParams objectForKey:@"registerActionBlock"];
        self.cancelActionBlock = [nativeParams objectForKey:@"cancelActionBlock"];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"注册";
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    [self.view addSubview:self.registerView];
}

-(KSRegisterView *)registerView{
    if (_registerView == nil) {
        _registerView = [[KSRegisterView alloc] initWithFrame:self.view.bounds];
        WEAKSELF
        _registerView.registerActionBlock = ^(BOOL success){
            STRONGSELF
            [strongSelf.navigationController popViewControllerAnimated:YES];
            if (strongSelf.registerActionBlock) {
                strongSelf.registerActionBlock(success);
            }
        };
        _registerView.cancelActionBlock = ^(){
            STRONGSELF
            [strongSelf.navigationController popViewControllerAnimated:YES];
            if (strongSelf.cancelActionBlock) {
                strongSelf.cancelActionBlock();
            }
        };
    }
    return _registerView;
}

@end
