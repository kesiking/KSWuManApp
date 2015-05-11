//
//  ManWuViewCell.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-25.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSViewCell.h"
#import "ManWuPraiseButton.h"

@interface ManWuViewCell : KSViewCell

@property (nonatomic,strong) UIImageView*         commodityImageView;
@property (nonatomic,strong) ManWuPraiseButton*   favorateImageView;
@property (nonatomic,strong) UILabel*             titleLabel;
@property (nonatomic,strong) UILabel*             priceLabel;
@property (nonatomic,strong) UILabel*             favorateLabel;
@property (nonatomic,strong) UIButton*            selectButton;

@end
