//
//  TBTradeDetailSKUService.m
//  TBTradeSDK
//
//  Created by neo on 14-1-23.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

#import "TBTradeDetailSKUService.h"
#import "TBDetailSkuImgManager.h"
#import "TBDetailSKUModelAndService.h"

@interface TBTradeDetailSKUService ()

@property (nonatomic, strong) TBDetailSKUModelAndService               *tbDetailModel;
@property (nonatomic, strong) TBDetailSkuModel            *skuModel;
@property (nonatomic, strong) NSMutableDictionary         *skuValueNameDic;//valueId到name的映射
@property (nonatomic, strong) NSMutableDictionary         *skuPropMap;//属性map
@property (nonatomic, strong) NSMutableDictionary         *pidvidMap;//用户已选择的pv对
@property (nonatomic, strong) NSMutableArray              *casCadePidvids;//用户已选择的级联pv对
@property (nonatomic, strong) NSMutableArray              *allPids;//所有的普通pid
@property (nonatomic, strong) NSMutableDictionary         *validSkuMap;//所有有存货的SKU ppath到skuId的对应
@property (nonatomic, strong) NSMutableDictionary         *validSkuPathMap;//所有有存货的SKUid 到ppath的对应
@property (nonatomic, strong) NSDictionary                *skuMap;//SKUMap
@property (nonatomic, strong) NSMutableDictionary         *validPropertyValueComboMap;//所有可选择的属性值的组合
@property (nonatomic, strong) NSMutableDictionary         *validSinglePropertyValueMap;//这个存在的作用就是用于去除某些没有存货的属性值选择按钮
@property (nonatomic, strong) NSString                    *selectedSkuId;//当前所构成的完成的SKU
@property (nonatomic, strong) TBDetailSKUInfo             *currentSkuInfo;
@property (nonatomic, strong) TBDetailSkuImgManager       *skuImgManager;

@end

@implementation TBDetailPidVidPair

- (id)initWithPid:(NSString *)pid vid:(NSString *)vid{
    _pid = pid;
    _vid = vid;
    return self;
}

- (id)initWithPidvid:(NSString *)pidvid{
    _pid = [[pidvid componentsSeparatedByString:@":"] objectAtIndex:0];
    _vid = [[pidvid componentsSeparatedByString:@":"] objectAtIndex:1];
    return self;
}

@end

@implementation TBTradeDetailSKUService

- (void)initProperties {
    _allPids = [NSMutableArray array];
    _skuValueNameDic = [NSMutableDictionary dictionary];
    _validSkuMap = [NSMutableDictionary dictionary];
    _validSkuPathMap = [NSMutableDictionary dictionary];
    _validPropertyValueComboMap = [NSMutableDictionary dictionary];
    _validSinglePropertyValueMap =[NSMutableDictionary dictionary];
    _skuPropMap = [NSMutableDictionary dictionary];
    _pidvidMap = [NSMutableDictionary dictionary];
}

- (id)initWithDetailResult:(TBDetailSKUModelAndService *)tBDetailModel{
    if (self = [super init]) {
        _skuImgManager = [[TBDetailSkuImgManager alloc] init];
        
        [self resetDetailResult:tBDetailModel];
    }
    return self;
}



- (void)resetDetailResult:(TBDetailSKUModelAndService *)tBDetailModel{
    _tbDetailModel = tBDetailModel;
    _skuModel = _tbDetailModel.skuModel;
    [self initProperties];
    _skuMap = _skuModel.skus;
    [self initSKUData];
    [self processSkuData];
    [_skuImgManager resetTBDetailModel:tBDetailModel];
    [self initCurrentSkuInfo];
    [self initSelect];//帮用户选中只有一个选项的sku
}

- (void)initSelect{
    for (TBDetailSkuPropsModel * skuModel in _skuModel.skuProps) {
        if (skuModel.values != nil && [skuModel.values count] == 1) {
            TBDetailSkuPropsValuesModel *skuValue = [skuModel.values objectAtIndex:0];
            TBDetailPidVidPair * pair = [[TBDetailPidVidPair alloc]init];
            pair.pid = skuModel.propId;
            pair.vid = skuValue.valueId;
            [self skuSelected:pair];
        }
    }
}

- (void)initCurrentSkuInfo{
    _currentSkuInfo = [[TBDetailSKUInfo alloc]init];
    NSString * needToselectSummary = @"";
    NSArray<TBDetailSkuPropsModel> *skuProps = _skuModel.skuProps;
    for (TBDetailSkuPropsModel* skuProp in skuProps) {
        needToselectSummary=[needToselectSummary stringByAppendingFormat:@" %@",skuProp.propName];
    }
    _currentSkuInfo.skuCellString = [@"选择" stringByAppendingFormat:@"%@",needToselectSummary];
    _currentSkuInfo.skuPopUpString = [@"请选择" stringByAppendingFormat:@"%@",needToselectSummary];
    _currentSkuInfo.skuDisplayString = [@"请选择" stringByAppendingFormat:@"%@",needToselectSummary];
//    _currentSkuInfo.priceUnits = _tbDetailModel.itemInfoModel.priceUnits;
//    _currentSkuInfo.quantity = _tbDetailModel.itemInfoModel.quantity;
//    _currentSkuInfo.quantityText = _tbDetailModel.itemInfoModel.quantityText;
//    _currentSkuInfo.picUrl = _skuImgManager.selectPic;
//    _currentSkuInfo.skuUnitControl = _tbDetailModel.itemControl.unitControl;
    [self initEnableMap];
}

- (TBDetailSKUInfo *)removeSelects{
    return _currentSkuInfo;
}

- (void)initEnableMap {
    for (int propertyIndex = 0; propertyIndex < [_tbDetailModel.skuModel.skuProps count]; propertyIndex++) {
        TBDetailSkuPropsModel *skuProps = [_tbDetailModel.skuModel.skuProps objectAtIndex:propertyIndex];
        
        NSArray<TBDetailSkuPropsValuesModel> * values = skuProps.values;
        
        for (TBDetailSkuPropsValuesModel *value in values) {
            [_currentSkuInfo.enableMap setValue:@"YES" forKey:[NSString stringWithFormat:@"%@:%@",skuProps.propId,value.valueId]];
        }
    }
}

- (void)initSKUData{
    NSArray<TBDetailSkuPropsModel> *skuProps = _skuModel.skuProps;
    for (TBDetailSkuPropsModel* skuProp in skuProps) {
        [_allPids addObject:[NSString stringWithFormat:@"%@",skuProp.propId]];
    }
    // 因为是客户端生成的sku信息，因此不需要排序
//    _allPids = [self sort:_allPids];
    
    for (TBDetailSkuPropsModel* skuProp in skuProps) {
        
        [_skuPropMap setObject:skuProp forKey:[NSString stringWithFormat:@"%@",skuProp.propId]];
        NSArray<TBDetailSkuPropsValuesModel> *values = skuProp.values;
        for (TBDetailSkuPropsValuesModel *valueModel in values) {
            if (valueModel.valueAlias != nil) {
                [_skuValueNameDic setValue:valueModel.valueAlias forKey:[NSString stringWithFormat:@"%@",valueModel.valueId]];
            }else if(valueModel.name != nil){
                [_skuValueNameDic setValue:valueModel.name forKey:[NSString stringWithFormat:@"%@",valueModel.valueId]];
            }
        }
    }
        
}

- (BOOL)hasSKU{
    if (_skuModel != nil) {
        return true;
    }else{
        return false;
    }
}

- (void)insert2ValidSinglePVMap:(NSArray *)skuProps {
    for (NSString *skuProp in skuProps) {
        if (![self.validSinglePropertyValueMap objectForKey:skuProp]) {
            [self.validSinglePropertyValueMap setValue:@"" forKey:skuProp];
        }
    }
}

- (void)insert2ValidPVComboMap:(NSArray *)skuProps {
    NSInteger skuPropCount = [skuProps count];
    NSInteger nonemptySubsetCount = pow(2, skuPropCount) - 1;
    NSMutableArray *subsetArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 1; i <= nonemptySubsetCount; i ++) {
        [subsetArray removeAllObjects];//清空
        
        for (int j = 0; j < skuPropCount; j ++) {
            if (i & 1<<j) {
                [subsetArray addObject:[skuProps objectAtIndex:j]];
            }else{
                [subsetArray addObject:@""];
            }
        }
        
        if ([subsetArray count] > 0) {
            NSString *subsetString = [subsetArray componentsJoinedByString:@";"];
            if (![self.validPropertyValueComboMap objectForKey:subsetString]) {
                [self.validPropertyValueComboMap setValue:@""
                                                   forKey:subsetString];
            }
        }
    }
}

//解析SKU数据并对数据进行预处理
- (void)processSkuData{
    if (![self hasSKU]) {
        return;
    }
    
    /*计算所有可以选择的SKU属性值的组合，其实就是依次对每一个SKU的属性值对的集合求非空子集，然后去除重复的以及没有存货的便可
     算法描述:
     一个有存货的SKU中的任何一个属性值对，我们可以假设其有两种状态0和1,0代表未选择，1代表已选择，
     所以算出SKU属性值对集合的非空子集就是通过0到2的n次方减1进行遍历，然后通过位运算来检查出为1的二进制位的index
     */
 
    NSDictionary *ppathIdmap = _skuModel.ppathIdmap;
    NSDictionary<TBDetailSKUPriceAndQuanitiyModel> *skus = _skuModel.skus;

    for (NSString* tmppath in [ppathIdmap allKeys]) {
        
        NSString* ppath = [self sortPpath:tmppath];
        NSString * skuId = [ppathIdmap objectForKey:ppath];
        
        TBDetailSKUPriceAndQuanitiyModel *skuModel = [skus objectForKey:skuId];
        
        if ([self isValidSku:skuModel SkuId:skuId]) {
        
            [self.validSkuMap setValue:skuId forKey:ppath];
            [self.validSkuPathMap setValue:ppath forKey:skuId];

            NSArray *skuProps = [ppath componentsSeparatedByString:@";"];
           
            [self insert2ValidSinglePVMap:skuProps];
            [self insert2ValidPVComboMap:skuProps];
        }
    }
}

- (BOOL) isValidSku:(TBDetailSKUPriceAndQuanitiyModel *)skuModel SkuId:(NSString *)skuId{

    if ([skuModel quantity] > 0) {
        return true;
    }
    // 暂时返回valid
    return true;
    return false;
}

- (NSString *)sortPpath:(NSString *)ppath{
    NSArray *skuProps = [ppath componentsSeparatedByString:@";"];
    
    skuProps=[skuProps sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1,NSString* obj2) {
        NSString * pid1 = [[obj1 componentsSeparatedByString:@":"] objectAtIndex:0];
        NSString * pid2 = [[obj1 componentsSeparatedByString:@":"] objectAtIndex:0];
        if ([pid1 integerValue] > [pid2 integerValue]) {
            return NSOrderedDescending;
        }
        if ([pid1 integerValue] < [pid2 integerValue]) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    return [skuProps componentsJoinedByString:@";"];
}

- (id)sort:(NSArray *)pids {
    return [pids sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

- (void)generateEnableMap:(TBDetailSKUInfo *)skuInfo selectedSkuPropertyValues:(NSMutableArray *)selectedSkuPropertyValues allPids:(NSArray *)allPids {
    /*对非当前操作属性行的所有按钮的可选性进行检查和设置
     检查的算法就是，将已选属性值数组中对应的位置的属性值对换成当前检查的属性值对，然后检查其是否可选，然后设置其对应的按钮
     */
    for (int propertyIndex = 0; propertyIndex < [allPids count]; propertyIndex ++) {
        NSString * propId = [allPids objectAtIndex:propertyIndex];
        
        NSMutableArray *selectedArray = [NSMutableArray arrayWithArray:selectedSkuPropertyValues];
        
        TBDetailSkuPropsModel *skuModel = [_skuPropMap objectForKey:propId];
        
        NSArray<TBDetailSkuPropsValuesModel> * values = skuModel.values;
        
        for (TBDetailSkuPropsValuesModel *value in values ) {
            [selectedArray replaceObjectAtIndex:propertyIndex withObject:[NSString stringWithFormat:@"%@:%@",propId,value.valueId]];
            
            NSString* enabled = @"NO";
            if ([self.validPropertyValueComboMap objectForKey:[selectedArray componentsJoinedByString:@";"]]) {
                enabled = @"YES";
            }
            [skuInfo.enableMap setValue:enabled forKey:[NSString stringWithFormat:@"%@:%@",skuModel.propId,value.valueId]];
        }
    }
}

- (TBDetailSKUInfo *)skuChanged{
    @try {
        
        //以选择以及未选择
        
        NSString* skuSummaryString=@"已选:";
        NSString* needToselectSummary=@"";
        // selectedSkuPropertyValues 存放目前已选择的属性值
        NSMutableArray *selectedSkuPropertyValues = [NSMutableArray array];
        
        NSArray * allTempPids = _allPids;
        NSDictionary * tempPidVidMap = _pidvidMap;
        
        for (NSString * propId in allTempPids) {
            NSString * valueId = [tempPidVidMap objectForKey:propId];
            if (valueId != nil) {
                NSString *selectedPVString = [NSString stringWithFormat:@"%@:%@",propId,valueId];
                [selectedSkuPropertyValues addObject:selectedPVString];
                NSString * valueName = [_skuValueNameDic objectForKey:valueId];
                skuSummaryString=[skuSummaryString stringByAppendingFormat:@" \"%@\"",valueName];
                
            }else{
                [selectedSkuPropertyValues addObject:@""];
                TBDetailSkuPropsModel *model = [_skuPropMap objectForKey:propId];
                needToselectSummary=[needToselectSummary stringByAppendingFormat:@" %@",model.propName];
                
            }
            
        }

        //如果sku为nil，说明无法构成一个完整的SKU，则相应的当前 self.selectedSku 也就是nil了
        NSString *skuId = [self.validSkuMap objectForKey:[selectedSkuPropertyValues componentsJoinedByString:@";"]];
        TBDetailSKUInfo *skuInfo = [[TBDetailSKUInfo alloc]init];

        if (skuId == nil) {
            skuInfo.skuDisplayString = [@"请选择" stringByAppendingFormat:@"%@",needToselectSummary];
            skuInfo.skuPopUpString = [@"请选择" stringByAppendingFormat:@"%@",needToselectSummary];
//            skuInfo.priceUnits = _tbDetailModel.itemInfoModel.priceUnits;
            skuInfo.skuCellString = [@"选择" stringByAppendingFormat:@"%@",needToselectSummary];;
//            skuInfo.quantity = _tbDetailModel.itemInfoModel.quantity;
//            skuInfo.quantityText = _tbDetailModel.itemInfoModel.quantityText;
        }else{
            skuInfo.skuDisplayString = skuSummaryString;
            skuInfo.skuCellString = skuSummaryString;
            skuInfo.selectSkuId = skuId;
            _selectedSkuId = skuId;
            TBDetailSKUPriceAndQuanitiyModel * currentSku = [_skuMap objectForKey:skuId];
            skuInfo.priceUnits = currentSku.priceUnits;
            skuInfo.quantity = currentSku.quantity;
            skuInfo.quantityText = currentSku.quantityText;
        }

        if (skuId == nil && [tempPidVidMap count] == [allTempPids count]) {
            skuInfo.skuDisplayString = @"无法购买";

        }
        
        [self generateEnableMap:skuInfo selectedSkuPropertyValues:selectedSkuPropertyValues allPids:allTempPids];
        
        return skuInfo;
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    }
}

- (NSArray *)createCascadePids:(NSArray *)allPids selectCasCade:(NSMutableArray *)casCadePidvids{
    NSMutableDictionary * dic = [NSMutableDictionary  dictionary];//去重
    for (NSString * key in allPids) {
        [dic setValue:@"" forKey:key];
    }
    for (TBDetailPidVidPair * pair in casCadePidvids) {
        [dic setValue:@"" forKey:pair.pid];
    }
    return [self sort:[dic allKeys]];
}

- (NSDictionary *)createTempPidVidMap:(NSDictionary *)pidVidMap casCadeMap:(NSMutableArray *)casCadePidvids{
    NSMutableDictionary * dic = [NSMutableDictionary  dictionary];
    [dic addEntriesFromDictionary:pidVidMap];
    for (TBDetailPidVidPair * pair in casCadePidvids) {
        [dic setValue:pair.vid forKey:pair.pid];
    }
    return dic;
}

/*
 相关逻辑描述:
 当某个SKU属性的某个值被选择了之后，需要判断当前是否构成一个完整的SKU，以及对其他SKU属性的值的可选性进行更新
 */

- (TBDetailSKUInfo *)skuSelected:(TBDetailPidVidPair *)pair{
    
    [_pidvidMap setValue:pair.vid forKey:pair.pid];
    
    TBDetailSKUInfo * skuInfo = [self skuChanged];
    [_skuImgManager getSkuPicSelected:pair];
    skuInfo.picUrl = _skuImgManager.selectPic;
    _currentSkuInfo = skuInfo;
    return skuInfo;
}

- (TBDetailSKUInfo *)skuUnSelected:(TBDetailPidVidPair *)pair{
    [_pidvidMap removeObjectForKey:pair.pid];
    TBDetailSKUInfo * skuInfo = [self skuChanged];
    [_skuImgManager getSkuPicUnSelected:pair];
    skuInfo.picUrl = [_skuImgManager selectPic];
    _currentSkuInfo = skuInfo;
    return skuInfo;

}

- (TBDetailSKUInfo *)skuInitWithSkuId:(NSString *)skuId{
    
    TBDetailSKUPriceAndQuanitiyModel *skuModel = [_skuModel.skus objectForKey:skuId];
    
    if ([self isValidSku:skuModel SkuId:skuId]) {
        
        NSString *ppath = [_validSkuPathMap valueForKey:skuId];
        NSArray *skuProps = [ppath componentsSeparatedByString:@";"];
        
        for (NSString *skuProp in skuProps) {

            TBDetailPidVidPair * pair =[[TBDetailPidVidPair alloc] initWithPidvid:skuProp];
            [_pidvidMap setValue:pair.vid forKey:pair.pid];
            [_skuImgManager getSkuPicSelected:pair];
            
        }
        
        TBDetailSKUInfo * skuInfo = [self skuChanged];
        skuInfo.picUrl = _skuImgManager.selectPic;
        _currentSkuInfo = skuInfo;
        return skuInfo;
    }else{
        return _currentSkuInfo;
    }
 
}
- (TBDetailSKUInfo *)caculatePrice:(double)servicePrice {
    NSMutableArray<TBDetailPriceUnitsModel> *prices = (NSMutableArray<TBDetailPriceUnitsModel> *)[NSMutableArray array];

    NSArray<TBDetailPriceUnitsModel> *originPrices = nil;
    
//    if (_tbDetailModel.itemInfoModel.sku) {
//        TBDetailSKUPriceAndQuanitiyModel * model = [_skuMap objectForKey:_selectedSkuId];
//        originPrices = model.priceUnits;
//    }else{
//        originPrices = _tbDetailModel.itemInfoModel.priceUnits;
//    }
    
    for(TBDetailPriceUnitsModel *price in originPrices){
        TBDetailPriceUnitsModel *newPrice = [price deepCopy];
        newPrice.price = [NSString stringWithFormat:@"%.2f",[price.price doubleValue] + servicePrice];
        [prices addObject:newPrice];
    }
    _currentSkuInfo.priceUnits = prices;
    return _currentSkuInfo;
}

- (TBDetailSKUInfo *)currentSKUInfo{
    return _currentSkuInfo;
}

@end


