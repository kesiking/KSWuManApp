//
//  ManWuBuyBasicView.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"

#define kArrowFileName         @"tbbuy_arrow"
#define kLocationFileName      @"tbbuy_location"
#define kQuestionFileName      @"tbbuy_question_fill"
#define kWarningFileName       @"tbbuy_warning"

#define MAIN_PAGE_TITLE        @"确认订单"
#define GIFT_PICKER_PAGE_TITLE @"选择赠品"
#define INSTALLMENT_PAGE_TITLE @"天猫分期购"
#define kCompletionButtonTitle @"完成"
#define kSelectNothingText     @"未选择"

#define TBBUY_SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define TBBUY_SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define TBBUY_CONTENT_HEIGHT ([UIScreen mainScreen].applicationFrame.size.height)

#define kSeperateHeight      0.7
#define kArrowSize           17.0f
#define kTextLabelMarginLeft 12.0f

#define kTBBuyColorNA RGB(0x05,0x1B,0x28)
#define kTBBuyColorNB RGB(0x99,0x99,0x99)
#define kTBBuyColorNC RGB(0xF5,0xF5,0xF5)
#define kTBBuyColorND RGB_A(0x00,0x00,0x00,0.5)
#define kTBBuyColorNE RGB(0x3D,0x42,0x45)
#define kTBBuyColorNF RGB(0xCC,0xCC,0xCC)

#define TBBUY_COLOR_a_bg   RGB(0xF9,0xF9,0xF9)
#define TBBUY_COLOR_b_bg   RGB(0xEE,0xEE,0xEE)
#define TBBUY_COLOR_c_bg   RGB(0xE8,0xE8,0xE8)
#define TBBUY_COLOR_d_bg   RGB(0xDD,0xDD,0xDD)
#define TBBUY_COLOR_g_bg   RGB(0xF5,0xF5,0xF5)
#define TBBUY_COLOR_L      RGB(0x3D,0x42,0x45)
#define TBBUY_COLOR_C      RGB(0x99,0x99,0x99)
#define TBBUY_COLOR_K      RGB(0x5F,0x64,0x6E)
#define TBBUY_COLOR_G      RGB(0xFF,0x50,0x00)
#define TBBUY_COLOR_b_line RGB(0xDD,0xDD,0xDD)
#define TBBUY_COLOR_N_A    RGB(0xFF,0x50,0x01)
#define TBBUY_COLOR_N_B    RGB(0xE0,0xE0,0xE0)

#define TBBUY_FONT_3 16
#define TBBUY_FONT_4 14
#define TBBUY_FONT_5 12

@interface ManWuBuyBasicView : KSView

@property (nonatomic, weak)   id                    delegate;

@property (nonatomic, strong) UIImageView           *seperateLine;
@property (nonatomic, assign, readonly) CGRect      seperateFrame;
@property (nonatomic, strong, readonly) UIColor     *seperateColor;

- (void)inspectSeperateFrame;

- (void)setObject:(id)object;

@end
