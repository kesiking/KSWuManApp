//
//  ManWuTradeDetailSKUService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuTradeDetailSKUService.h"
#import "ManWuCommodityDetailModel.h"
#import "ManWuCommodityPriceCaculate.h"

@interface ManWuTradeDetailSKUService ()

@property (nonatomic, strong) ManWuCommodityDetailModel   *tbDetailModel;

@property (nonatomic, strong) ManWuCommodityPriceCaculate *commodityPriceCaculate;

@property (nonatomic, strong) NSMutableDictionary         *skuValueNameDic;//valueId到name的映射
@property (nonatomic, strong) NSMutableDictionary         *skuPropMap;//属性map
@property (nonatomic, strong) NSMutableDictionary         *pidvidMap;//用户已选择的pv对
@property (nonatomic, strong) NSMutableArray              *allPids;//所有的普通pid
@property (nonatomic, strong) NSMutableDictionary         *validSkuMap;//所有有存货的SKU ppath到skuId的对应
@property (nonatomic, strong) NSMutableDictionary         *validSkuPathMap;//所有有存货的SKUid 到ppath的对应
@property (nonatomic, strong) NSDictionary                *skuMap;//SKUMap
@property (nonatomic, strong) NSMutableDictionary         *validPropertyValueComboMap;//所有可选择的属性值的组合
@property (nonatomic, strong) NSMutableDictionary         *validSinglePropertyValueMap;//这个存在的作用就是用于去除某些没有存货的属性值选择按钮
@property (nonatomic, strong) NSString                    *selectedSkuId;//当前所构成的完成的SKU
@property (nonatomic, strong) TBDetailSKUInfo             *currentSkuInfo;

@end

@implementation ManWuTradeDetailSKUService

+(BOOL)dbWillInsert:(NSObject *)entity{
    return NO;
}

+(BOOL)dbWillUpdate:(NSObject *)entity{
    return NO;
}

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

- (id)initWithDetailResult:(ManWuCommodityDetailModel *)tBDetailModel{
    if (self = [super init]) {
        [self resetDetailResult:tBDetailModel];
    }
    return self;
}



- (void)resetDetailResult:(ManWuCommodityDetailModel *)tBDetailModel{
    _tbDetailModel = tBDetailModel;
    _commodityPriceCaculate = [ManWuCommodityPriceCaculate new];
    [_commodityPriceCaculate setObject:tBDetailModel dict:nil];
    [self initProperties];
    _skuMap = tBDetailModel.skuMap;
    [self initSKUData];
    [self processSkuData];
    [self initCurrentSkuInfo];
    [self initSelect];//帮用户选中只有一个选项的sku
}

- (void)initSelect{
    for (ManWuCommoditySKUModel * skuModel in _tbDetailModel.skuArray) {
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
    NSArray*skuProps = _tbDetailModel.skuArray;
    for (ManWuCommoditySKUModel* skuProp in skuProps) {
        needToselectSummary=[needToselectSummary stringByAppendingFormat:@" %@",skuProp.propName];
    }
    _currentSkuInfo.skuCellString = [@"选择" stringByAppendingFormat:@"%@",needToselectSummary];
    _currentSkuInfo.skuPopUpString = [@"请选择" stringByAppendingFormat:@"%@",needToselectSummary];
    _currentSkuInfo.skuDisplayString = [@"请选择" stringByAppendingFormat:@"%@",needToselectSummary];
    _currentSkuInfo.quantity = [[_commodityPriceCaculate getCommodityQuantity] integerValue];
    _currentSkuInfo.price = [_commodityPriceCaculate getCommodityPrice];
    [self initEnableMap];
}

- (TBDetailSKUInfo *)removeSelects{
    return _currentSkuInfo;
}

- (void)initEnableMap {
    for (int propertyIndex = 0; propertyIndex < [_tbDetailModel.skuArray count]; propertyIndex++) {
        ManWuCommoditySKUModel *skuProps = [_tbDetailModel.skuArray objectAtIndex:propertyIndex];
        
        NSArray * values = skuProps.values;
        
        for (TBDetailSkuPropsValuesModel *value in values) {
            [_currentSkuInfo.enableMap setValue:@"YES" forKey:[NSString stringWithFormat:@"%@:%@",skuProps.propId,value.valueId]];
        }
    }
}

- (void)initSKUData{
    NSArray *skuProps = _tbDetailModel.skuArray;
    for (ManWuCommoditySKUModel* skuProp in skuProps) {
        [_allPids addObject:[NSString stringWithFormat:@"%@",skuProp.propId]];
    }
    // 因为是客户端生成的sku信息，因此不需要排序
    //    _allPids = [self sort:_allPids];
    
    for (ManWuCommoditySKUModel* skuProp in skuProps) {
        
        [_skuPropMap setObject:skuProp forKey:[NSString stringWithFormat:@"%@",skuProp.propId]];
        NSArray *values = skuProp.values;
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
    if (_tbDetailModel.skuArray != nil && [_tbDetailModel.skuArray count] > 0) {
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
            NSString *subsetString = [subsetArray componentsJoinedByString:separatorForPidAndVid];
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
    
    NSDictionary *ppathIdmap = _tbDetailModel.ppathIdmap;
    NSDictionary<ManWuCommoditySKUDetailModel> *skus = _tbDetailModel.skuMap;
    
    for (NSString* tmppath in [ppathIdmap allKeys]) {
        
        NSString * skuId = [ppathIdmap objectForKey:tmppath];
        
        ManWuCommoditySKUDetailModel *skuModel = [skus objectForKey:skuId];
        
        if ([self isValidSku:skuModel SkuId:skuId]) {
            
            [self.validSkuMap setValue:skuId forKey:tmppath];
            [self.validSkuPathMap setValue:tmppath forKey:skuId];
            
            NSArray *skuProps = [tmppath componentsSeparatedByString:separatorForPidAndVid];
            
            [self insert2ValidSinglePVMap:skuProps];
            [self insert2ValidPVComboMap:skuProps];
        }
    }
}

- (BOOL) isValidSku:(ManWuCommoditySKUDetailModel *)skuModel SkuId:(NSString *)skuId{
    
    if ([skuModel quantity] > 0) {
        return true;
    }
    return false;
}

- (NSString *)sortPpath:(NSString *)ppath{
    return ppath;
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
        
        ManWuCommoditySKUModel *skuModel = [_skuPropMap objectForKey:propId];
        
        NSArray * values = skuModel.values;
        
        for (TBDetailSkuPropsValuesModel *value in values ) {
//            [selectedArray replaceObjectAtIndex:propertyIndex withObject:[NSString stringWithFormat:@"%@:%@",propId,value.valueId]];
            [selectedArray replaceObjectAtIndex:propertyIndex withObject:[NSString stringWithFormat:@"%@",value.valueId]];

            
            NSString* enabled = @"NO";
            if ([self.validPropertyValueComboMap objectForKey:[selectedArray componentsJoinedByString:separatorForPidAndVid]]) {
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
        // 已经选择的属性名称拼接
        NSString* skuInfoDescription = @"";
        // selectedSkuPropertyValues 存放目前已选择的属性值
        NSMutableArray *selectedSkuPropertyValues = [NSMutableArray array];
        
        NSArray * allTempPids = _allPids;
        NSDictionary * tempPidVidMap = _pidvidMap;
        
        for (NSString * propId in allTempPids) {
            NSString * valueId = [tempPidVidMap objectForKey:propId];
            if (valueId != nil) {
                NSString *selectedPVString = [NSString stringWithFormat:@"%@",valueId];
                [selectedSkuPropertyValues addObject:selectedPVString];
                NSString * valueName = [_skuValueNameDic objectForKey:valueId];
                skuSummaryString = [skuSummaryString stringByAppendingFormat:@" \"%@\"",valueName];
                ManWuCommoditySKUModel *propObject = [self.skuPropMap objectForKey:propId];
                NSString* propName = propObject.propName;
                if (skuInfoDescription.length > 0) {
                    skuInfoDescription = [skuInfoDescription stringByAppendingString:@","];
                }
                skuInfoDescription = [skuInfoDescription stringByAppendingFormat:@"%@:",propName];
                skuInfoDescription = [skuInfoDescription stringByAppendingFormat:@"%@",valueName];
                
            }else{
                [selectedSkuPropertyValues addObject:@""];
                ManWuCommoditySKUModel *model = [_skuPropMap objectForKey:propId];
                needToselectSummary=[needToselectSummary stringByAppendingFormat:@"%@",model.propName];
                
            }
            
        }
        
        //如果sku为nil，说明无法构成一个完整的SKU，则相应的当前 self.selectedSku 也就是nil了
        NSString *skuPpathId = [self.validSkuMap objectForKey:[selectedSkuPropertyValues componentsJoinedByString:separatorForPidAndVid]];
        TBDetailSKUInfo *skuInfo = [[TBDetailSKUInfo alloc]init];
        
        if (skuPpathId == nil) {
            skuInfo.skuDisplayString = [@"请选择" stringByAppendingFormat:@"%@",needToselectSummary];
            skuInfo.skuPopUpString = [@"请选择" stringByAppendingFormat:@"%@",needToselectSummary];
            skuInfo.skuCellString = [@"选择" stringByAppendingFormat:@"%@",needToselectSummary];
            skuInfo.price = [_commodityPriceCaculate getCommodityPrice];
        }else{
            skuInfo.skuDisplayString = skuSummaryString;
            skuInfo.skuCellString = skuSummaryString;
            skuInfo.skuInfoDescription = skuInfoDescription;
            skuInfo.selectSkuPpathId = skuPpathId;
            ManWuCommoditySKUDetailModel * currentSku = [_skuMap objectForKey:skuPpathId];
            skuInfo.selectSkuId = currentSku.skuId;
            _selectedSkuId = currentSku.skuId;
            skuInfo.quantity = [[_commodityPriceCaculate getCommodityQuantityWithSkuModel:currentSku] integerValue];
            skuInfo.price = [_commodityPriceCaculate getCommodityPriceWithSkuModel:currentSku];
        }
        
        if (skuPpathId == nil && [tempPidVidMap count] == [allTempPids count]) {
            skuInfo.skuDisplayString = @"无法购买";
        }
        
        [self generateEnableMap:skuInfo selectedSkuPropertyValues:selectedSkuPropertyValues allPids:allTempPids];
        
        return skuInfo;
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    }
}

/*
 相关逻辑描述:
 当某个SKU属性的某个值被选择了之后，需要判断当前是否构成一个完整的SKU，以及对其他SKU属性的值的可选性进行更新
 */

- (TBDetailSKUInfo *)skuSelected:(TBDetailPidVidPair *)pair{
    
    [_pidvidMap setValue:pair.vid forKey:pair.pid];
    
    TBDetailSKUInfo * skuInfo = [self skuChanged];
    _currentSkuInfo = skuInfo;
    return skuInfo;
}

- (TBDetailSKUInfo *)skuUnSelected:(TBDetailPidVidPair *)pair{
    [_pidvidMap removeObjectForKey:pair.pid];
    TBDetailSKUInfo * skuInfo = [self skuChanged];;
    _currentSkuInfo = skuInfo;
    return skuInfo;
    
}

- (TBDetailSKUInfo *)skuInitWithSkuId:(NSString *)skuId{
    
    ManWuCommoditySKUDetailModel *skuModel = [_tbDetailModel.skuMap objectForKey:skuId];
    
    if ([self isValidSku:skuModel SkuId:skuId]) {
        
        NSString *ppath = [_validSkuPathMap valueForKey:skuId];
        NSArray *skuProps = [ppath componentsSeparatedByString:@";"];
        
        for (NSString *skuProp in skuProps) {
            
            TBDetailPidVidPair * pair =[[TBDetailPidVidPair alloc] initWithPidvid:skuProp];
            [_pidvidMap setValue:pair.vid forKey:pair.pid];
        }
        
        TBDetailSKUInfo * skuInfo = [self skuChanged];
        _currentSkuInfo = skuInfo;
        return skuInfo;
    }else{
        return _currentSkuInfo;
    }
    
}

- (TBDetailSKUInfo *)currentSKUInfo{
    return _currentSkuInfo;
}

@end
