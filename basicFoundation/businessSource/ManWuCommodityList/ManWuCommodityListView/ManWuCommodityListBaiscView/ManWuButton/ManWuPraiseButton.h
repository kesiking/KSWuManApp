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

@property(nonatomic,assign)  BOOL               isPraise;

-(void)updatePraiseBtnStatus:(BOOL)isPraise;

@end
