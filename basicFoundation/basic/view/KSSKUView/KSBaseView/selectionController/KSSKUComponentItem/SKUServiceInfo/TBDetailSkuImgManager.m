//
//  TBDetailSkuImgManager.m
//  TBTradeSDK
//
//  Created by neo on 14-1-24.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "TBDetailSkuImgManager.h"
@interface TBDetailSkuImgManager()

@property (nonatomic, strong) NSMutableDictionary *picMap;
@property (nonatomic, strong) NSString            *propId;
@property (nonatomic ,strong) NSString            *defaultPic;
@property (nonatomic ,strong) NSString            *selectPic;

@end

@implementation TBDetailSkuImgManager
- (void)resetTBDetailModel:(TBDetailSKUModelAndService *)tbDetailModel {
    _picMap = [NSMutableDictionary dictionary];
    TBDetailSkuModel *skuModel = tbDetailModel.skuModel;
    TBDetailSkuPropsModel *skuProps = [self getPicSkuProps:skuModel];
    if (skuProps != nil) {
        _propId = [NSString stringWithFormat:@"%@",skuProps.propId];
        for (TBDetailSkuPropsValuesModel * valueModel in skuProps.values){
            if (valueModel.imgUrl != nil) {
                [_picMap setValue:valueModel.imgUrl forKey:[NSString stringWithFormat:@"%@",valueModel.valueId]];
            }
        }
    }
    [self setDefault:tbDetailModel];
    _selectPic = _defaultPic;
}

- (id)initWithDetailResult:(TBDetailSKUModelAndService *)tbDetailModel{
    if (self = [super init]) {
        [self resetTBDetailModel:tbDetailModel];
        return self;
    }
    return nil;
}

- (void)setDefault:(TBDetailSKUModelAndService *) tbDetailModel{
//    if (tbDetailModel.itemInfoModel.picsPath != nil) {
//        _defaultPic = [tbDetailModel.itemInfoModel.picsPath objectAtIndex:0];
//    }
    if (_defaultPic == nil) {
        NSArray *keys = [_picMap allKeys];
        if (keys.count > 0) {
            _defaultPic = [_picMap valueForKey:[keys objectAtIndex:0]];
        }
    }
}

- (TBDetailSkuPropsModel *)getPicSkuProps:(TBDetailSkuModel *)skuModel{
    NSArray<TBDetailSkuPropsModel> * skuArray = skuModel.skuProps;
    for (TBDetailSkuPropsModel *skuProps in skuArray) {
        NSArray<TBDetailSkuPropsValuesModel> *values = skuProps.values;
        for (TBDetailSkuPropsValuesModel *value in values) {
            if (value.imgUrl != nil){
                return skuProps;
            }
        }
    }
    return nil;
}

- (void)getSkuPicSelected:(TBDetailPidVidPair *)pair{
    if(_propId == nil){
        return ;
    }
    
    if([_propId isEqualToString:pair.pid]){
        NSString * img = [_picMap valueForKey:pair.vid];
        if(img != nil){
            _selectPic = img;
        }else{
            _selectPic = _defaultPic;
        }
    }
}

- (void)getSkuPicUnSelected:(TBDetailPidVidPair *)pair{
    if(_propId == nil){
        return ;
    }
    if([_propId isEqualToString:pair.pid]){
        _selectPic = _defaultPic;
    }
}

@end
