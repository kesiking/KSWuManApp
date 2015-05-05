//
//  ManWuSearchViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-5.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuSearchViewCell.h"
#import "ManWuSearchViewCellInfoItem.h"

@interface ManWuSearchViewCell()

@property (nonatomic,strong) UILabel*                       titleLabel;

@end

@implementation ManWuSearchViewCell

-(void)setupView{
    [super setupView];
    [self.titleLabel setFrame:CGRectMake(0, 0, self.width , 20)];
    [self addSubview:self.titleLabel];
    [self.titleLabel setText:@"text"];
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    
    ManWuSearchViewCellInfoItem* cellModelInfoItem = (ManWuSearchViewCellInfoItem*)extroParams;
    
    self.titleLabel.text = @"测试风刀霜剑烦死了都快捷方式来得及菲利克斯";
    
}

- (void)refreshCellImagesWithComponentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    
}

- (void)didSelectCellWithCellView:(id<KSViewCellProtocol>)cell componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    NSLog(@"did select cell in list");
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:@"commodityId",@"commodityId", nil];
    TBOpenURLFromTargetWithNativeParams(internalURL(kManWuCommodityList), self,nil,params);
}

@end
