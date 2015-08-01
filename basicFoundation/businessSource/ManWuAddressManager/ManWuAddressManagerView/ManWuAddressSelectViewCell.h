//
//  ManWuAddressManagerViewCell.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSViewCell.h"

@interface ManWuAddressSelectViewCell : KSViewCell

@property (nonatomic, strong) IBOutlet UIImageView *addressIcon;
@property (nonatomic, strong) IBOutlet UILabel     *defaultAddressLabel;
@property (nonatomic, strong) IBOutlet UILabel     *fullNameLabel;
@property (nonatomic, strong) IBOutlet UILabel     *phoneNumLabel;
@property (nonatomic, strong) IBOutlet UILabel     *addressLabel;
@property (nonatomic, strong) IBOutlet UIView      *seprateBackgroundView;
@property (nonatomic, strong) IBOutlet UIButton    *addressEditBtn;
@property (nonatomic, strong) IBOutlet UIButton    *addressDeleteBtn;

@end
