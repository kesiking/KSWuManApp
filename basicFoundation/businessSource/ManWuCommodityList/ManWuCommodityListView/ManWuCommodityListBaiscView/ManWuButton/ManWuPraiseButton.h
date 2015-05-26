//
//  ManWuPraiseButton.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-11.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuOperationButton.h"

@interface ManWuPraiseButton : ManWuOperationButton

@property(nonatomic,strong)  NSString*          itemId;

-(void)updatePraiseBtnStatus:(BOOL)isPraise;

@end
