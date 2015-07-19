//
//  KSRegisterSuccessView.h
//  basicFoundation
//
//  Created by 许学 on 15/6/30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KSRegisterSuccessViewDelegate <NSObject>

- (void)didClickCloseButton;

@end

@interface KSRegisterSuccessView : UIView

@property (nonatomic, assign) id<KSRegisterSuccessViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame RedPackerPrice:(NSInteger)packerPrice;

@end
