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
}

- (void)setObject:(id)object{
    
}

- (CGRect)seperateFrame {
    return CGRectMake(12, 0, TBBUY_SCREEN_WIDTH - 24, kSeperateHeight);
}

- (UIColor *)seperateColor {
    return RGB(0xDD, 0xDD, 0xDD);
}

- (UIImageView *)seperateLine {
    if (!_seperateLine) {
        _seperateLine = [[UIImageView alloc] initWithFrame:self.seperateFrame];
        _seperateLine.backgroundColor = self.seperateColor;
    }
    return _seperateLine;
}

- (void)extraInitializationByDelegate:(id)delegate {
    self.delegate = delegate;
}

- (void)inspectSeperateFrame {
    _seperateLine.frame = CGRectMake(12, 0, TBBUY_SCREEN_WIDTH - 24, kSeperateHeight);
}


@end
