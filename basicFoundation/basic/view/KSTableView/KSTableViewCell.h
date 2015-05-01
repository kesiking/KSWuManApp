//
//  KSTableViewCell.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-26.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSViewCell.h"

@interface KSTableViewCell : UITableViewCell<KSViewCellProtocol>

+(NSString*)reuseIdentifier;

+(id)createCell;

@property (nonatomic, strong) Class                viewCellClass;

@end
