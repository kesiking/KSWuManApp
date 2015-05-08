//
//  ManWuCommodityDescriptionBasicView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityDescriptionBasicView.h"

#define labelPaddingLeft (8.0)

@interface ManWuCommodityDescriptionBasicView()

@property (nonatomic, strong) CSLinearLayoutView               *labelContainer;

@end

@implementation ManWuCommodityDescriptionBasicView

-(void)setupView{
    [self addSubview:self.labelContainer];
}

-(NSMutableArray *)descriptionArray{
    if (_descriptionArray == nil) {
        _descriptionArray = [[NSMutableArray alloc] init];
    }
    return _descriptionArray;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = RGB(0x66, 0x66, 0x66);
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

- (CSLinearLayoutView *)labelContainer {
    if (!_labelContainer) {
        float containerHeight = self.height -  TBSKU_BOTTOM_HEIGHT;
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, containerHeight);
        _labelContainer = [[CSLinearLayoutView alloc] initWithFrame:frame];
        _labelContainer.autoAdjustFrameSize = YES;
        _labelContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _labelContainer.backgroundColor  = [TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg1];
    }
    return _labelContainer;
}

- (void)reloadData {
    
    if (self.descriptionArray == nil || [self.descriptionArray count] == 0) {
        return;
    }
    
    /*重新布局*/
    [self.labelContainer removeAllItems];
    CSLinearLayoutItemPadding padding = CSLinearLayoutMakePadding(0, labelPaddingLeft, 5.0, 0.0);
    
    CSLinearLayoutItem *titleLabelLayoutItem = [[CSLinearLayoutItem alloc]
                                             initWithView:self.titleLabel];
    titleLabelLayoutItem.padding             = padding;
    [self.labelContainer addItem:titleLabelLayoutItem];
    
    for (NSString *description in self.descriptionArray) {
        if (description == nil || ![description isKindOfClass:[NSString class]]) {
            continue;
        }
        UIView* descriptionView = [self getDescriptionViewWithDescription:description];
        if (descriptionView == nil) {
            continue;
        }
        CSLinearLayoutItem *subviewLayoutItem = [[CSLinearLayoutItem alloc]
                                                initWithView:descriptionView];
        subviewLayoutItem.padding             = padding;
        [self.labelContainer addItem:subviewLayoutItem];
    }
}

-(void)setDescriptionModel:(WeAppComponentBaseItem *)descriptionModel{

}

-(UIView*)getDescriptionViewWithDescription:(NSString*)description{
    if (description == nil) {
        return nil;
    }
    
    UILabel* label = [[UILabel alloc] initWithFrame:self.bounds];
    label.backgroundColor = [UIColor whiteColor];
    label.autoresizingMask =  UIViewAutoresizingFlexibleHeight;
    label.adjustsFontSizeToFitWidth = NO;
    label.numberOfLines = 0;
    label.textColor = RGB(0x66, 0x66, 0x66);
    label.font = [UIFont systemFontOfSize:13];
    [label setText:description];
    [label sizeToFit];
    
    return label;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Override

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = size;
    
    if ([self.descriptionArray count] > 0) {
        CGRect rect = self.bounds;
        
        rect.size.height = self.labelContainer.height;
        
        /*Bug,会以中点，上下缩的，不能直接设置Bound*/
        newSize = CGSizeMake(newSize.width, rect.size.height);
    }else {
        newSize = CGSizeZero;
    }
    
    return newSize;
}

@end
