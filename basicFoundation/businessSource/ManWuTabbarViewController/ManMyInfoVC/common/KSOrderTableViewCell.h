//
//  KSOrderTableViewCell.h
//  basicFoundation
//
//  Created by 许学 on 15/6/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSOrderModel;

@interface KSOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) KSOrderModel *orderModel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;

@end
