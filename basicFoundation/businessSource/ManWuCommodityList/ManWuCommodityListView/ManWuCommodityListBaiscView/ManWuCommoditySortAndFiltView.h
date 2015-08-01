//
//  ManWuCommoditySortAndFiltView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"

typedef void(^leftButtonSelectedBlock) (UIView *leftButton);
typedef void(^rightButtonSelectedBlock) (UIView *rightButton);

@interface ManWuCommoditySortAndFiltView : KSView

@property(nonatomic,strong) leftButtonSelectedBlock leftButtonSelectedBlock;
@property(nonatomic,strong) rightButtonSelectedBlock rightButtonSelectedBlock;

-(void)clearButtonStatus;

-(void)setLeftBtnTitle:(NSString*)title;

-(void)setRightBtnTitle:(NSString*)title;

@end
