//
//  UserInfoViewItem.m
//  basicFoundation
//
//  Created by 许学 on 15/5/7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "UserInfoViewItem.h"

@implementation UserInfoViewItem

-(id)initWithFrame:(CGRect)frame Tag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.tag = tag;
        [self addSubview:self.itemImageView];
        [self addSubview:self.itemName];
        //创建一个点击手势对象，该对象可以调用handelSingleTap：方法
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelSingleTap)];
        [self addGestureRecognizer:singleTap];
        [singleTap setNumberOfTouchesRequired:1];//触摸点个数
        [singleTap setNumberOfTapsRequired:1];//点击次数
    }
    return self;
}

- (UIImageView*)itemImageView
{
    if(!_itemImageView)
    {
        _itemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    }
    return _itemImageView;
}

- (UILabel*)itemName
{
    if(!_itemName)
    {
        _itemName = [[UILabel alloc]initWithFrame:CGRectMake(0, self.width, self.width, self.height - self.width)];
        _itemName.font = [UIFont systemFontOfSize:12.0];
        _itemName.textAlignment = NSTextAlignmentCenter;
    }
    
    return _itemName;
}

- (void)handelSingleTap
{
    if(self.delegate)
    {
        [self.delegate didSelectedItem:self.tag];
    }
}

@end
