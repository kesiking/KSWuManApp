//
//  KSView.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSView : UIView

-(void)setupView;

// 寻找Keyboard输入框
+ (UIView *)findKeyboard;

@end
