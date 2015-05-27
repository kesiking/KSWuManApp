//
//  ManWuBuyBasicView.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuBuyBasicView.h"

@implementation ManWuBuyBasicView

-(void)setupView{
    [super setupView];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.endline];
}

- (void)setObject:(id)object{
    [self setObject:object dict:nil];
}

- (void)setObject:(id)object dict:(NSDictionary*)dict{
    
}

- (CGRect)seperateFrame {
    return CGRectMake(12, 0, TBBUY_SCREEN_WIDTH - 24, kSeperateHeight);
}

-(UIView *)endline{
    if (_endline == nil) {
        _endline = [TBDetailUITools drawDivisionLine:0
                                                yPos:self.height - 0.5
                                           lineWidth:self.width];
    }
    return _endline;
}

- (void)extraInitializationByDelegate:(id)delegate {
    self.delegate = delegate;
}


@end
