//
//  KSGuideConfig.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSGuideConfig.h"

#define FIRST_LOAD_INTRODUCTION_VIEW  @"FIRST_LOAD_INTRODUCTION_VIEW"

@implementation KSGuideConfig

+ (void)configGuideScrollView{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];      //获取项目版本号
    NSString* firstLoadIntroductionViewKey = [version stringByAppendingString:FIRST_LOAD_INTRODUCTION_VIEW];
    
    BOOL isFirstLoadIntrodutionView = [userDefaults boolForKey:firstLoadIntroductionViewKey];
    if (isFirstLoadIntrodutionView) {
        return;
    }
    static ZWIntroductionViewController *introductionView = nil;
    if (introductionView == nil) {
        NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
        NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
        introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:introductionView.view];
    
    __typeof(introductionView) __weak __block weakIntroductionView = introductionView;
    
    introductionView.didSelectedEnter = ^() {
        [weakIntroductionView.view removeFromSuperview];
        weakIntroductionView = nil;
    };
    [userDefaults setBool:YES forKey:firstLoadIntroductionViewKey];
    [userDefaults synchronize];
}

@end
