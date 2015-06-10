//
//  WeAppBasicFieldView.h
//  WeAppSDK
//
//  Created by 逸行 on 14-12-25.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSInsetsTextField.h"

@interface WeAppBasicFieldView : UIView

+(WeAppBasicFieldView*)getSecurityFieldView;

+(WeAppBasicFieldView*)getCommonFieldView;

@property (strong, nonatomic) KSInsetsTextField   *textView;

@property (strong, nonatomic) UIImageView         *backgroundImage;

@property (strong, nonatomic,getter=getText) NSString            *text;

@property (weak, nonatomic  ) id<UITextFieldDelegate> aDelegate;

@property (assign, nonatomic) UIEdgeInsets        textViewInsets;

@end
