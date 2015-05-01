//
//  TBDetailSkuModel.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "TBDetailSkuModel.h"

@implementation TBDetailSkuModel

-(void)setFromDictionary:(NSDictionary *)dict{
    [super setFromDictionary:dict];
    if (self.ppathIdmap == nil) {
        NSMutableDictionary* pathIdMapTemp = [[NSMutableDictionary alloc] init];
        NSMutableArray* array = [[NSMutableArray alloc] init];
        for (NSUInteger index = 0; index < [self.skuProps count]; index++) {
            NSMutableArray* skuPropAndValueArray = [[NSMutableArray alloc] init];
            TBDetailSkuPropsModel* skuProp = [self.skuProps objectAtIndex:index];
            NSArray<TBDetailSkuPropsValuesModel> *values = skuProp.values;
            for (TBDetailSkuPropsValuesModel *valueModel in values) {
                NSString* propIdAndValueId = [NSString stringWithFormat:@"%@:%@",skuProp.propId,valueModel.valueId];
                [skuPropAndValueArray addObject:propIdAndValueId];
            }
            [array addObject:skuPropAndValueArray];
        }
        
        [self getPathIdRecur:array AtIndex:0 pathId:nil pathIdMap:pathIdMapTemp];
        self.ppathIdmap = pathIdMapTemp;
    }
}

-(void)getPathIdRecur:(NSArray*)array AtIndex:(NSUInteger)index pathId:(NSString*)pathId pathIdMap:(NSMutableDictionary*)pathIdMap{
    @autoreleasepool {
        if (pathId == nil) {
            pathId = [NSString string];
        }
        if (pathIdMap == nil) {
            pathIdMap = [[NSMutableDictionary alloc] init];
        }
        NSUInteger indexRecur = index;
        if ([array count] <= indexRecur) {
            return;
        }
        NSArray *skuPropAndValueArray = [array objectAtIndex:indexRecur];
        for (NSUInteger j = 0; j < [skuPropAndValueArray count]; j++) {
            NSString* pathIdFromSku = [skuPropAndValueArray objectAtIndex:j];
            NSString* pathIdTmp = [pathId stringByAppendingString:pathIdFromSku];
            if (indexRecur < [array count] - 1) {
                pathIdTmp = [pathIdTmp stringByAppendingString:@";"];
                [self getPathIdRecur:array AtIndex:indexRecur + 1 pathId:pathIdTmp pathIdMap:pathIdMap];
            }else{
                if (pathIdTmp) {
                    [pathIdMap setObject:pathIdTmp forKey:pathIdTmp];
                }
            }
        }
    }
}



@end
