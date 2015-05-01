//
//  WeAppTableViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppTableViewCell.h"

@interface WeAppTableViewCell ()

@property (nonatomic, strong) KSViewCell* cellView;

@property (nonatomic, assign) CGRect      cellViewFrame;

@end

@implementation WeAppTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(id)createCell {
    id cellObj = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self reuseIdentifier]];
    if (cellObj) {
        [(WeAppTableViewCell*)cellObj setupCellView];
        return cellObj;
    }
    return nil;
}

+(NSString*)reuseIdentifier{
    return @"KSTableViewCellReUserId";
}

-(void)setViewCellClass:(Class)viewCellClass{
    if (_viewCellClass != viewCellClass) {
        _viewCellClass = viewCellClass;
    }
}

-(void)setupCellView{

}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(KSViewCell *)cellView{
    if (_cellView == nil) {
        if (self.viewCellClass && [self.viewCellClass isSubclassOfClass:[KSViewCell class]]) {
            if (!CGRectEqualToRect(CGRectZero, self.cellViewFrame)) {
                _cellView = [[self.viewCellClass alloc] initWithFrame:self.cellViewFrame];
            }else{
                _cellView = [[self.viewCellClass alloc] initWithFrame:self.bounds];
            }
        }else{
            if (!CGRectEqualToRect(CGRectZero, self.cellViewFrame)) {
                _cellView = [[KSViewCell alloc] initWithFrame:self.cellViewFrame];
            }else{
                _cellView = [[KSViewCell alloc] initWithFrame:self.bounds];
            }
        }
    }
    return _cellView;
}

- (void)configCellWithFrame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(id)extroParams{
    self.cellViewFrame = rect;
    if (![self.cellView checkCellLegalWithWithCellView:self componentItem:componentItem]) {
        return;
    }
    [self.cellView configCellWithCellView:self Frame:rect componentItem:componentItem extroParams:extroParams];
    if (self.cellView && self.cellView.superview == nil) {
        [self addSubview:self.cellView];
    }else if(self.cellView && self.cellView.superview != self){
        [self.cellView removeFromSuperview];
        [self addSubview:self.cellView];
    }
}

- (void)refreshCellImagesWithComponentItem:(WeAppComponentBaseItem *)componentItem extroParams:(id)extroParams{
    [self.cellView refreshCellImagesWithComponentItem:componentItem extroParams:extroParams];
}

-(void)didSelectItemWithComponentItem:(WeAppComponentBaseItem *)componentItem extroParams:(id)extroParams{
    [self.cellView didSelectCellWithCellView:self componentItem:componentItem extroParams:extroParams];
}

-(void)dealloc{
    _cellView = nil;
}

@end
