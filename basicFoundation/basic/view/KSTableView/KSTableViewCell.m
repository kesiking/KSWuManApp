//
//  KSTableViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-26.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSTableViewCell.h"

@interface KSTableViewCell ()

@property (nonatomic, strong) KSViewCell* cellView;

@end

@implementation KSTableViewCell

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        [self setupCellView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCellView];
    }
    return self;
}

-(void)awakeFromNib{
    [self setupCellView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected];
    // Configure the view for the selected state
}

+(id)createCell {
    id cellObj = [[KSTableViewCell alloc] init];
    if (cellObj) {
        [cellObj setupCellView];
        return cellObj;
    }
    return nil;
}

+(NSString*)reuseIdentifier{
    return @"KSTableViewCell";
}

-(void)setViewCellClass:(Class)viewCellClass{
    if (_viewCellClass != viewCellClass) {
        _viewCellClass = viewCellClass;
    }
}

-(void)setupCellView{
    
}

-(KSViewCell *)cellView{
    if (_cellView == nil) {
        if (self.viewCellClass && [self.viewCellClass isSubclassOfClass:[KSViewCell class]]) {
            _cellView = [[self.viewCellClass alloc] initWithFrame:self.bounds];
        }else{
            _cellView = [[KSViewCell alloc] initWithFrame:self.bounds];
        }
    }
    return _cellView;
}

- (void)configCellWithFrame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(id)extroParams{
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
