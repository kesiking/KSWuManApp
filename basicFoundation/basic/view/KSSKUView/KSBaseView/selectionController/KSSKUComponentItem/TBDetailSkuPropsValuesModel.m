//
//  SkuPropsValues.m
//
//  Generated by MTOPModelGenerator
//  Copyright (c) Taobao.com. All rights reserved.
//

#import "TBDetailSkuPropsValuesModel.h"

@implementation TBDetailSkuPropsValuesModel

-(void)setFromDictionary:(NSDictionary *)dict{
    [super setFromDictionary:dict];
    if (self.valueId == nil) {
        self.valueId = [NSString stringWithFormat:@"%lu",(unsigned long)[self hash]];
    }
}

@end