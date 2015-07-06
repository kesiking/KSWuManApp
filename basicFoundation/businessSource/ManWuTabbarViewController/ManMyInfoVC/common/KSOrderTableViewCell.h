//
//  KSOrderTableViewCell.h
//  basicFoundation
//
//  Created by 许学 on 15/6/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSOrderModel;

#define kCellControlSpacingX 10 //X轴间距
#define kCellControlSpacingY 15 //Y轴间距
#define kImageViewWidth 50 //头像宽度
#define kPriceLabelWidth 50 //价格标签宽度
#define kStatusLabelWidth 100 //价格标签宽度
#define kButtonWidth 100 //价格标签宽度
#define kTitleFontSize 13
#define kSize_ColorFontSize 11
#define kBuyNumFontSize kSize_ColorFontSize
#define kPriceFontSize 12
#define kStatusFontSize 12
#define kPayFontSize 12
#define kButtonFontSize 12

#define OrderTableCellStyleInfo @"OrderTableCellStyleInfo"
#define OrderTableCellStyleDeal @"OrderTableCellStyleDeal"


@interface KSOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) KSOrderModel *orderModel;

@property (nonatomic, strong) UIButton *btn_left;
@property (nonatomic, strong) UIButton *btn_right;
@property (nonatomic, strong) UILabel *payLabel;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;

@end
