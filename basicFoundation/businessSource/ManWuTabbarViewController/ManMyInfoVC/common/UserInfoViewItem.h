//
//  UserInfoViewItem.h
//  basicFoundation
//
//  Created by 许学 on 15/5/7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInfoViewItemDelegate <NSObject>

- (void)didSelectedItem:(NSInteger)tag;

@end

@interface UserInfoViewItem : UIView

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UIImageView *remindImage;  //提醒图
@property (nonatomic, assign) BOOL isRemind;  //是否提醒
@property (nonatomic, assign) NSInteger remindNum;  //提醒数量
@property (nonatomic, strong) UILabel *itemName;
@property (nonatomic, assign) id <UserInfoViewItemDelegate> delegate;

-(id)initWithFrame:(CGRect)frame Tag:(NSInteger)tag;

@end
