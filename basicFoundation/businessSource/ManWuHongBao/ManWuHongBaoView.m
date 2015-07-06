//
//  ManWuHongBaoView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHongBaoView.h"
#import "ManWuHongBaoInfoDescriptionView.h"
#import "ManWuHongBaoService.h"

@interface ManWuHongBaoView()

@property (nonatomic, strong) CSLinearLayoutView           *skuContainer;

@property (nonatomic, strong) UIImageView                  *headerImageView;

@property (nonatomic, strong) ManWuHongBaoInfoDescriptionView  *descriptionView;

@property (nonatomic, strong) UIButton                     *clickedBtn;

@property (nonatomic, strong) ManWuHongBaoService          *voucherService;

@end

@implementation ManWuHongBaoView

-(void)setupView{
    [super setupView];
    self.backgroundColor = RGB(0xf8, 0xf8, 0xf8);
    [self addSubview:self.skuContainer];
    [self addSubview:self.clickedBtn];
    [self reloadData];
}

-(void)setVoucherModel:(ManWuHomeVoucherModel *)voucherModel{
    _voucherModel = voucherModel;
    [self setupDataWithVoucherModel:voucherModel];
}

-(void)refreshDataRequest{

}

-(UIImageView *)headerImageView{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 55)];
        _headerImageView.image = [UIImage imageNamed:@"gz_image_loading"];
    }
    return _headerImageView;
}

- (CSLinearLayoutView *)skuContainer {
    if (!_skuContainer) {
        float containerHeight = self.height - 80;
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, containerHeight);
        _skuContainer = [[CSLinearLayoutView alloc] initWithFrame:frame];
        _skuContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _skuContainer.backgroundColor  = RGB(0xf8, 0xf8, 0xf8);
    }
    return _skuContainer;
}

-(ManWuHongBaoInfoDescriptionView *)descriptionView{
    if (_descriptionView == nil) {
        _descriptionView = [[ManWuHongBaoInfoDescriptionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200 * SCREEN_SCALE)];
    }
    return _descriptionView;
}

-(UIButton *)clickedBtn{
    if (_clickedBtn == nil) {
        _clickedBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.width - 290)/2, self.height - 34 - 24, 290, 34)];
        _clickedBtn.layer.cornerRadius = 3.0;
        [_clickedBtn setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Tag alpha:1]
                         forState:UIControlStateNormal];
        [_clickedBtn setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Tag alpha:0.2]
                         forState:UIControlStateDisabled];
        [_clickedBtn setTitleColor:[UIColor colorWithRed:225.0/255
                                                  green:225.0/255
                                                   blue:225.0/255 alpha:0.7f]
                         forState:UIControlStateSelected];
        
        [_clickedBtn setBackgroundColor:RGB(0xe8, 0x53, 0x53)];
        _clickedBtn.titleLabel.font = [TBDetailUIStyle fontWithStyle:TBDetailFontStyle_ChineseBold  size:TBDetailFontSize_Title0];
        [_clickedBtn addTarget:self action:@selector(clickedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickedBtn;
}

-(ManWuHongBaoService *)voucherService{
    if (_voucherService == nil) {
        _voucherService = [ManWuHongBaoService new];
        WEAKSELF
        _voucherService.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            [strongSelf setupDataWithVoucherModel:service.item];
        };
    }
    return _voucherService;
}

-(void)setupDataWithVoucherModel:(ManWuHomeVoucherModel*)voucherModel{
    if (voucherModel == nil || ![voucherModel isKindOfClass:[ManWuHomeVoucherModel class]]) {
        return;
    }
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:voucherModel.picUrl] placeholderImage:[UIImage imageNamed:@"gz_image_loading"]];
    [self.descriptionView setDescriptionModel:voucherModel];
    [self.descriptionView sizeToFit];
    switch (voucherModel.type) {
        case 0:
            [self.clickedBtn setTitle:@"我要注册" forState:UIControlStateNormal];
            break;
        case 1:
            [self.clickedBtn setTitle:@"我要去邀请" forState:UIControlStateNormal];
            break;
        case 2:
            [self.clickedBtn setTitle:@"我要买买买" forState:UIControlStateNormal];
            break;
        default:
            [self.clickedBtn setTitle:@"我要注册" forState:UIControlStateNormal];
            break;
    }
    [self reloadData];
}

-(void)reloadData{
    /*重新布局*/
    
    CGPoint skuContentOffset          = self.skuContainer.contentOffset;
    [self.skuContainer removeAllItems];
    CSLinearLayoutItemPadding padding = CSLinearLayoutMakePadding(5, 0, 0, 0.0);
    
    
    /*头部图片*/
    CSLinearLayoutItem *addressViewItem = [[CSLinearLayoutItem alloc]
                                           initWithView:self.headerImageView];
    addressViewItem.padding = padding;
    [self.skuContainer addItem:addressViewItem];
    
    /*描述信息*/
    CSLinearLayoutItem *commodityInfoItem = [[CSLinearLayoutItem alloc]
                                             initWithView:self.descriptionView];
    commodityInfoItem.padding             = padding;
    [self.skuContainer addItem:commodityInfoItem];
    
    /*调整布局*/
    if (self.skuContainer.contentSize.height > self.skuContainer.height) {
        [self.skuContainer setContentOffset:skuContentOffset];
    }
}

-(void)clickedBtnClick:(id)sender{
    
}

@end
