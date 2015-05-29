//
//  ManWuFeedBackViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/5/20.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManWuFeedBackViewController : UIViewController<UITextViewDelegate,WeAppBasicServiceDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *btn_commit;

@property (nonatomic, strong) KSAdapterService *service;

@end
