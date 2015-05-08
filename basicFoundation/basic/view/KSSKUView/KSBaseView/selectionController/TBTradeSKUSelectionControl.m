//
//  TBTradeSKUSelectionControl.m
//  TBTrade
//
//  Created by christ.yuj on 14-1-21.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "TBTradeSKUSelectionControl.h"
#import "TBTradeSKUPropSelectControl.h"
#import "TBSelectionControlDelegate.h"
#import "TBDetailSkuPropsModel.h"
#import "TBDetailSKULayout.h"
#import "TBDetailSystemUtil.h"
#import "TBDetailUIStyle.h"
#import "TBDetailUITools.h"

@interface TBTradeSKUSelectionControl ()<TBSelectionControlDelegate>

@property (nonatomic, strong) NSMutableArray *propertyTitles;
@property (nonatomic, strong) NSMutableArray *propertySelectControls;
@property (nonatomic, strong) NSMutableArray *endLines;

@end

@implementation TBTradeSKUSelectionControl

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Initialize

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Accessor

- (void)setDetailModel:(TBDetailSKUModelAndService *)detailModel{
    _detailModel = detailModel;
    [self reloadData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

- (void)reloadData{
    [self createSkuPropertyValueControl];
    [self sizeToFit];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private
/**
 *  创建sku选择标题
 */
-(UIView *)createTitle:(NSString *)propName
{
    CGRect frame = CGRectMake(0, 0, self.width, TBSKU_PROP_SELECTIONTITLE_HEIGHT);
    UIView *labelContainer=[[UIView alloc] initWithFrame:frame];
    
    frame = CGRectMake(0, TBSKU_VERTICAL_GAP, self.bounds.size.width, TBSKU_PROP_TITLE_LABLE_HEIGHT);
    UILabel *label        = [[UILabel alloc] initWithFrame:frame];
    label.text            = propName;
    label.font            = [TBDetailUIStyle fontWithStyle:TBDetailFontStyle_Chinese
                                                      size:TBDetailFontSize_Title1];
    label.backgroundColor = [UIColor clearColor];
    label.textColor       = [TBDetailUIStyle colorWithStyle:TBDetailColorStyle_SKUButtonColor];
    
    [labelContainer addSubview:label];
    return labelContainer;
}

/**
 * 创建属性值选择控件填充的值
 */
-(NSMutableArray *)createPropValueArray:(TBDetailSkuPropsModel *)skuProperty
{
    NSMutableArray *valueNames = [NSMutableArray arrayWithCapacity:[skuProperty.values count]];
    for (TBDetailSkuPropsValuesModel * value in skuProperty.values) {
        if (value.valueAlias.length > 0) {
            [valueNames addObject:value.valueAlias];
        }else{
            [valueNames addObject:value.name];
        }
    }
    return valueNames;
}

/**
 *  创建属性选择控件
 */
-(TBTradeSKUPropSelectControl *)createPropSelectControl:(TBDetailSkuPropsModel *)skuProperty
{
    TBTradeSKUPropSelectControl *propertySelectControl = [[TBTradeSKUPropSelectControl alloc] init];
    propertySelectControl.delegate = self;
    propertySelectControl.frame = CGRectMake(0, 0, self.width, TBSKU_PROP_TITLE_HEIGHT);
    propertySelectControl.title = skuProperty.propName;
    [propertySelectControl setItems:[self createPropValueArray:skuProperty]];
    propertySelectControl.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleBottomMargin;
    
    
    /*设置选择状态*/
    for (TBDetailSkuPropsValuesModel *value in skuProperty.values) {
        NSUInteger index = [skuProperty.values indexOfObject:value];
        NSString *key = [NSString stringWithFormat:@"%@:%@", skuProperty.propId, value.valueId];
        NSString *enable = [self.detailModel.skuService.currentSKUInfo.enableMap objectForKey:key];
        if (enable.length > 0) {
            if ([enable isEqualToString:@"NO"]) {
                [propertySelectControl setEnabled:NO atIndex:index];
            } else {
                [propertySelectControl setEnabled:YES atIndex:index];
            }
        }
    }
    
    NSDictionary *pidvidMap = self.detailModel.skuService.pidvidMap;
    NSString *valueId = [pidvidMap objectForKey:[NSString stringWithFormat:@"%@",skuProperty.propId]];
    if (valueId.length > 0) {
        for (TBDetailSkuPropsValuesModel * value in skuProperty.values) {
            if ([valueId isEqualToString:[NSString stringWithFormat:@"%@", value.valueId]]) {
                [propertySelectControl setSelectedIndex:[skuProperty.values indexOfObject:value]];
                break;
            }
        }
    }
    return propertySelectControl;
}

/**
 *  创建sku属性选择控件组
 */
- (void)createSkuPropertyValueControl{
    [self removeAllSubviews];
    self.propertyTitles = [NSMutableArray array];
    self.propertySelectControls = [NSMutableArray array];
    self.endLines = [NSMutableArray array];

    for (TBDetailSkuPropsModel *skuProperty in self.detailModel.skuModel.skuProps) {
        /*创建某个属性选择的提示信息*/
        UIView *labelContainer = [self createTitle:skuProperty.propName];
        [self addSubview:labelContainer];
        [self.propertyTitles addObject:labelContainer];
        
        if (self.width < 0 || isnan(self.width)) {
            continue;
        }
        
        /*创建属性选择控件*/
        TBTradeSKUPropSelectControl *propertySelectControl = [self createPropSelectControl:skuProperty];
        [self addSubview:propertySelectControl];
        [self.propertySelectControls addObject:propertySelectControl];
        
        /*创建底部分割线*/
        UIView *endline = [TBDetailUITools drawDivisionLine:0
                                                       yPos:0
                                                  lineWidth:TBSKU_LINE_WIDTH];
        [self addSubview:endline];
        [self.endLines addObject:endline];
    }
    
}

- (void)clickedControl:(UIControl *)control index:(NSUInteger)index{
    TBTradeSKUPropSelectControl *propertySelectControl = (TBTradeSKUPropSelectControl *)control;
    NSUInteger pidIndex = [self.propertySelectControls indexOfObject:propertySelectControl];
    TBDetailSkuPropsModel *skuPropsModel = self.detailModel.skuModel.skuProps.count> pidIndex ? [self.detailModel.skuModel.skuProps objectAtIndex:pidIndex]:nil;
    TBDetailPidVidPair *pidVidPair = [[TBDetailPidVidPair alloc] init];
    [pidVidPair setPid:[NSString stringWithFormat:@"%@",skuPropsModel.propId]];
    if (propertySelectControl.selectedIndex >= 0 &&propertySelectControl.selectedIndex <= skuPropsModel.values.count) {
        TBDetailSkuPropsValuesModel *skuPropsValuesModel = [skuPropsModel.values objectAtIndex:propertySelectControl.selectedIndex];
        [pidVidPair setVid:[NSString stringWithFormat:@"%@", skuPropsValuesModel.valueId]];
    }else{
        [pidVidPair setVid:@""];
    }
    /*@""没有选中*/
    if ([pidVidPair.vid isEqualToString:@""]) {
        [self.detailModel.skuService skuUnSelected:pidVidPair];
    }else{
        [self.detailModel.skuService skuSelected:pidVidPair];
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Override
- (void)layoutSubviews {
    [super layoutSubviews];
    [self performLayoutSubviews];
}

- (void)performLayoutSubviews {
    float width = self.bounds.size.width;
    float y = 0;
    
    for (int i = 0; i < [self.propertyTitles count]; ++i) {
        UIView *titleView = [self.propertyTitles objectAtIndex:i];
        TBTradeSKUPropSelectControl *skuControl = [self.propertySelectControls objectAtIndex:i];
        UIView *endLine = [self.endLines objectAtIndex:i];
        
        /*设置标题的位置*/
        //        y += TBSKU_HEADER_VERTICAL_GAP;
        titleView.frame = CGRectMake(0, y, width, TBSKU_PROP_SELECTIONTITLE_HEIGHT);
        
        /*设置属性选择按钮的位置*/
        skuControl.frame = CGRectMake(0, 0, width, 9999.0);
        [skuControl sizeToFit];
        y += titleView.height + TBSKU_PROP_TITLE_BELOW_GAP + TBSKU_HEADER_VERTICAL_GAP;
        skuControl.frame = CGRectMake(0, y, width, skuControl.height);
        
        /*设置底部分割线的位置*/
        y = skuControl.bottom + TBSKU_VERTICAL_GAP - 0.5;
        float lineWidth = [TBDetailSystemUtil getCurrentDeviceWidth] - self.left * 2;
        endLine.frame = CGRectMake(0, y, lineWidth, 0.5);
        
        y = endLine.bottom + 1;
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self performLayoutSubviews];
    
    CGSize  newSize = size;
    if ([self.propertySelectControls count] > 0) {
        UIView *lastView = [self.propertySelectControls objectAtIndex:[self.propertySelectControls count] - 1];
        newSize = CGSizeMake(size.width, lastView.frame.origin.y + lastView.frame.size.height + TBSKU_VERTICAL_GAP);
    }
    
    return newSize;
}

@end
