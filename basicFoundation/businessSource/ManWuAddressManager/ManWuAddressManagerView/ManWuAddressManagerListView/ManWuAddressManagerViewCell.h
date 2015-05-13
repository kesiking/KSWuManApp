//
//  ManWuAddressManagerViewCell.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSViewCell.h"

@interface ManWuAddressManagerViewCell : KSViewCell

@property (nonatomic, strong) IBOutlet UILabel     *fullNameLabel;
@property (nonatomic, strong) IBOutlet UILabel     *phoneNumLabel;
@property (nonatomic, strong) IBOutlet UILabel     *addressLabel;
@property (nonatomic, strong) IBOutlet UIView      *seprateBackgroundView;

@end
