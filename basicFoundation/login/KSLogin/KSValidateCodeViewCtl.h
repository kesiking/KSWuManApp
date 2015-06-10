//
//  KSValidateCodeViewCtl.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/9.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeAppBasicFieldView.h"

#define validate_width     (self.frame.size.width - kSpaceX * 2)
#define view_width      (self.frame.size.width)

#define text_height     (40.0)
#define text_border     (8.0)

@class KSValidateCodeViewCtl;

typedef BOOL (^doGetValidateColdBlock)  (KSValidateCodeViewCtl* validateCodeViewCtl);

@interface KSValidateCodeViewCtl : UIView{
    UIView                    *_smsCodeView;
}

@property (nonatomic, strong) WeAppBasicFieldView       *text_smsCode;
@property (nonatomic, strong) UIView                    *smsCodeView;
@property (nonatomic, strong) UIButton                  *btn_smsCode;

@property (nonatomic, assign) NSUInteger                smsCodeSeconds;

@property (nonatomic, strong) doGetValidateColdBlock    getValidateColdBlock;

@end
