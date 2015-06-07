//
//  KSInsetsTextField.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSInsetsTextField.h"

@interface KSInsetsTextField()

@end

@implementation KSInsetsTextField

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.leftViewEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        UIImage *backgroundImage = [UIImage imageNamed:@"inputbox.png"];
        backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:floorf(backgroundImage.size.width/2) topCapHeight:floorf(backgroundImage.size.height/2)];
        //[self setBackground:backgroundImage];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.textEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.leftViewEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        UIImage *backgroundImage = [UIImage imageNamed:@"inputbox.png"];
        backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:floorf(backgroundImage.size.width/2) topCapHeight:floorf(backgroundImage.size.height/2)];
        [self setBackground:backgroundImage];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.textEdgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.textEdgeInsets)];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    //    return [super leftViewRectForBounds:UIEdgeInsetsInsetRect(bounds, leftViewEdgeInsets)];
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += self.leftViewEdgeInsets.left;// 右偏10	return iconRect;
    return iconRect;
}

@end
