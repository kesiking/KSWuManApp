//
//  ManWuAddressManagerViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressSelectViewCell.h"
#import "ManWuAddressInfoModel.h"
#import "ManWuAddressManagerMaroc.h"
#import "ManWuAddressEditService.h"
#import "KSTableViewController.h"

@interface ManWuAddressSelectViewCell(){
    
}

@property(nonatomic,strong) ManWuAddressInfoModel   *addressInfoComponentItem;

@property(strong,nonatomic) ManWuAddressEditService *addressDeleteService;

@end

@implementation ManWuAddressSelectViewCell

+(id)createView{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    if ([nibContents count] > 0) {
        id object = [nibContents objectAtIndex:0];
        if (object && [object isKindOfClass:[self class]])
        {
            return object;
        }
    }
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [ManWuAddressSelectViewCell createView];
    if (self) {
        self.frame = frame;
        [self setupView];
    }
    return self;
}

-(void)setupView{
    [super setupView];
    [self.addressEditBtn setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_SKUButtonColor]
                              forState:UIControlStateNormal];
    [self.addressEditBtn.layer setBorderColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Price2].CGColor];
    [self.addressEditBtn setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg2]];
    
    self.addressEditBtn.layer.borderWidth  = 1.0;
    self.addressEditBtn.layer.cornerRadius = 3.0;
    
    [self.addressEditBtn setFrame:CGRectMake(self.addressIcon.left, self.addressLabel.bottom + 8, (self.width - self.addressIcon.left * 3)/2, self.addressEditBtn.height)];
    
    [self.addressEditBtn setEnabled:NO];
    
    [self.addressDeleteBtn setTitleColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_SKUButtonColor]
                              forState:UIControlStateNormal];
    [self.addressDeleteBtn.layer setBorderColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_Price2].CGColor];
    [self.addressDeleteBtn setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg2]];
    
    self.addressDeleteBtn.layer.borderWidth  = 1.0;
    self.addressDeleteBtn.layer.cornerRadius = 3.0;
    
    [self.addressDeleteBtn setFrame:CGRectMake(self.addressEditBtn.right + self.addressIcon.left, self.addressEditBtn.top, self.addressEditBtn.width, self.addressEditBtn.height)];
    
    [self.addressDeleteBtn addTarget:self action:@selector(addressDeleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

}

-(ManWuAddressEditService *)addressDeleteService{
    if (_addressDeleteService == nil) {
        _addressDeleteService = [[ManWuAddressEditService alloc] init];
        WEAKSELF
        _addressDeleteService.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            [WeAppToast toast:@"删除成功"];
            if (((KSTableViewController*)strongSelf.scrollViewCtl).tableCellViewOperationBlock) {
                ((KSTableViewController*)strongSelf.scrollViewCtl).tableCellViewOperationBlock((UITableView*)strongSelf.scrollViewCtl.scrollView,strongSelf.indexPath,strongSelf.scrollViewCtl.dataSourceRead,(KSCollectionViewConfigObject*)strongSelf.scrollViewCtl.configObject);
            }
        };
    }
    return _addressDeleteService;
}

-(void)addressDeleteBtnClicked:(id)sender{
    [self.addressDeleteService deleteAddressInfoWithAddressId:self.addressInfoComponentItem.addressId];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.seprateBackgroundView setFrame:CGRectMake(self.seprateBackgroundView.origin.x, self.height - self.seprateBackgroundView.height, self.width, self.seprateBackgroundView.height)];
    [self.phoneNumLabel setOrigin:CGPointMake(self.width - self.phoneNumLabel.width - 18, self.phoneNumLabel.origin.y)];
    [self.addressLabel setWidth:self.width - 15 * 2];

}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    ManWuAddressInfoModel* addressInfoComponentItem = (ManWuAddressInfoModel*)componentItem;
    self.addressInfoComponentItem = addressInfoComponentItem;
    if (addressInfoComponentItem.defaultAddress) {
        self.addressIcon.image = [UIImage imageNamed:@"manwu_default_address"];
    }else{
        self.addressIcon.image = [UIImage imageNamed:@"manwu_common_address"];
    }
    self.fullNameLabel.text = [NSString stringWithFormat:@"收货人：%@",addressInfoComponentItem.recvName];
    self.phoneNumLabel.text = [NSString stringWithFormat:@"联系方式：%@",addressInfoComponentItem.phoneNum];
    self.addressLabel.text = [[NSString stringWithFormat:@"收货地址：%@",addressInfoComponentItem.address] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    self.fullNameLabel.hidden = addressInfoComponentItem.recvName ? NO : YES;
    self.phoneNumLabel.hidden = addressInfoComponentItem.phoneNum ? NO : YES;
    self.addressLabel.hidden = addressInfoComponentItem.address ? NO : YES;

    [self.phoneNumLabel sizeToFit];
    CGRect phoneNumLabelRect = self.phoneNumLabel.frame;
    phoneNumLabelRect.origin.x = self.width - self.phoneNumLabel.width - 18;
    [self.phoneNumLabel setFrame:phoneNumLabelRect];
}

- (void)didSelectCellWithCellView:(id<KSViewCellProtocol>)cell componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    
}

@end
