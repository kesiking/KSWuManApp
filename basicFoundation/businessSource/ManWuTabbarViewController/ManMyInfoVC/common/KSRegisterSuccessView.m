//
//  KSRegisterSuccessView.m
//  basicFoundation
//
//  Created by 许学 on 15/6/30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSRegisterSuccessView.h"

#define KSPaddingX 10
#define KSPaddingY 10

@implementation KSRegisterSuccessView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        UIView *maskview = [[UIView alloc]initWithFrame:self.frame];
        maskview.backgroundColor = [UIColor blackColor];
        maskview.alpha=0.5;
        [self addSubview:maskview];

        [self initSubView];
    }
    return self;
}

- (void)initSubView
{
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(30, 180, self.width - 60, 215)];
    [subView setBackgroundColor:[TBDetailUIStyle colorWithHexString:@"#ffffff"]];
    
    UIButton *btn_close = [[UIButton alloc]initWithFrame:CGRectMake(subView.width - KSPaddingX - 20, KSPaddingY, 20, 20)];
    [btn_close setBackgroundImage:[UIImage imageNamed:@"registerSuc_close"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:btn_close];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(KSPaddingX, CGRectGetMaxY(btn_close.frame) + 5, subView.width - 2*KSPaddingX, 14)];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:@"恭喜您获得%ld元新手红包",(long)self.redPackerPrice];
    [subView addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(2*KSPaddingX, CGRectGetMaxY(titleLabel.frame) + 10, subView.width - 4*KSPaddingX, 120)];
    imageView.image = [UIImage imageNamed:@"register_success"];
    [subView addSubview:imageView];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(KSPaddingX, CGRectGetMaxY(imageView.frame) + 10, subView.width - 2*KSPaddingX, 12)];
    [titleLabel setFont:[UIFont systemFontOfSize:12]];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"存放在 “我的” > “我的红包” 里";
    [subView addSubview:tipLabel];
    
    [self addSubview:subView];
    
}

- (void)closeButtonClicked
{
    if(self.delegate)
    {
        [self.delegate didClickCloseButton];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
