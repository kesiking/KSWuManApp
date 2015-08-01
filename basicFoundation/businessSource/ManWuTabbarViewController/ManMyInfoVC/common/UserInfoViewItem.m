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
        _itemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 0, self.width - 8, self.width - 16)];
    }
    return _itemImageView;
}

- (UILabel*)itemName
{
    if(!_itemName)
    {
        _itemName = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_itemImageView.frame) + 5, self.width, 12)];
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

#pragma mark -订单消息提醒数目

- (void)setRemindImage:(UIImageView *)remindImage{
    
    
    [self bringSubviewToFront:remindImage];
}

-(void)addTheRemindImage{
    _remindImage=[[UIImageView alloc] initWithFrame:CGRectMake(45, 5, 15, 15)];
    _remindImage.image=[UIImage imageNamed:@"public_Remindnumber.png"];
    _remindImage.backgroundColor=[UIColor clearColor];
    [self addSubview:_remindImage];
    
    [self bringSubviewToFront:_remindImage];
}

-(void)setRemindNum:(NSInteger)remindNum{
    _remindNum=remindNum;
    if (_remindImage!=nil) {
        [_remindImage removeFromSuperview];
    }
    [self addTheRemindImage];
    if (_remindNum==0) {
        _remindImage.alpha = 0;
    }else{
        _remindImage.alpha = 1;
        if(remindNum < 0 ){
            _remindImage.frame = CGRectMake(55, 5, 8, 8);
        }else{
            UILabel *numberLabel=[[UILabel alloc] initWithFrame:CGRectMake(3, 2, 10, 10)];
            numberLabel.backgroundColor=[UIColor clearColor];
            numberLabel.textAlignment=NSTextAlignmentCenter;
            numberLabel.font=[UIFont systemFontOfSize:8];
            numberLabel.textColor=[UIColor whiteColor];
            numberLabel.text=[NSString stringWithFormat:@"%ld",(long)remindNum];
            if (remindNum>99) {
                
                NSString *imageName= @"public_Remindnumber";
                UIImage *img=[UIImage imageNamed:imageName];
                
                //对图片进行边帽设置，可以把图片分为4个部分，取大约值即可，将来放大的话 四个角不变，其余部分会自动有规则的填充
                UIImage *newImage=[img stretchableImageWithLeftCapWidth:7.5 topCapHeight:7.5];
                _remindImage.image=newImage;
                _remindImage.frame=CGRectMake(40, 5, 20, 15);
                numberLabel.frame=CGRectMake(3, 2, 15, 10);
                numberLabel.text=[NSString stringWithFormat:@"99+"];
            }
            
            [_remindImage addSubview:numberLabel];
        }
    }
    
}

-(void)setIsRemind:(BOOL)isRemind{
    if (isRemind && _remindNum == 0) {
        if (_remindImage==nil) {
            _remindImage=[[UIImageView alloc] initWithFrame:CGRectMake(47, 5, 8, 8)];
        }
        
        _remindImage.image=[UIImage imageNamed:@"public_Remindnumber"];
        _remindImage.backgroundColor=[UIColor clearColor];
        _remindImage.alpha = 1;
        [self addSubview:_remindImage];
        [self bringSubviewToFront:_remindImage];
    }
    else
    {
        if (_remindImage)
        {
            [_remindImage removeFromSuperview];
        }
    }
}

@end
