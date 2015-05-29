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
@property (nonatomic, strong) UILabel *itemName;
@property (nonatomic, strong) id <UserInfoViewItemDelegate> delegate;

-(id)initWithFrame:(CGRect)frame Tag:(NSInteger)tag;

@end
