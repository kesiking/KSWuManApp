//
//  KSAdapterCacheService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/3.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterCacheService.h"
#import "LKDBHelper.h"

@implementation KSAdapterCacheService

-(void)writeCacheWithApiName:(NSString *)apiName withParam:(NSDictionary *)param componentItem:(WeAppComponentBaseItem *)componentItem writeSuccess:(WriteSuccessCacheBlock)writeSuccessBlock{
    if (componentItem == nil) {
        return;
    }
    componentItem.db_tableName = [self getTableNameFromApiName:apiName];
    BOOL inseted = [[LKDBHelper getUsingLKDBHelper] insertToDB:componentItem];
    writeSuccessBlock(inseted);
}

-(void)writeCacheWithApiName:(NSString*)apiName
                   withParam:(NSDictionary*)param
          componentItemArray:(NSArray*)componentItemArray
                writeSuccess:(WriteSuccessCacheBlock)writeSuccessBlock{
    if (componentItemArray == nil || [componentItemArray count] <= 0) {
        return;
    }
    [[LKDBHelper getUsingLKDBHelper] executeForTransaction:^BOOL(LKDBHelper *helper) {
        
        BOOL isSuccess = YES;
        for (int i = 0; i < componentItemArray.count; i++)
        {
            WeAppComponentBaseItem* componentItem = [componentItemArray objectAtIndex:i];
            componentItem.db_tableName = [self getTableNameFromApiName:apiName];
            BOOL inseted = [helper insertToDB:componentItem];
            isSuccess = isSuccess && inseted;
        }
        writeSuccessBlock(isSuccess);
        return (isSuccess == YES);
    }];
}

-(void)readCacheWithApiName:(NSString *)apiName
                  withParam:(NSDictionary *)param
         withFetchCondition:(NSDictionary*)fetchCondition
         componentItemClass:(Class)componentItemClass
                readSuccess:(ReadSuccessCacheBlock)readSuccessBlock{
    NSString* where = [fetchCondition objectForKey:@"where"];
    NSString* orderBy = [fetchCondition objectForKey:@"orderBy"];
    NSInteger offset = [[fetchCondition objectForKey:@"offset"] integerValue];
    NSInteger count = [[fetchCondition objectForKey:@"count"] integerValue];
    
    LKDBQueryParams *params = [[LKDBQueryParams alloc]init];
    params.toClass = componentItemClass;
    params.tableName = [self getTableNameFromApiName:apiName];
    
    params.where = where;
    params.orderBy = orderBy;
    params.offset = offset;
    params.count = count;
    
    NSMutableArray* componentItems = [[LKDBHelper getUsingLKDBHelper] searchWithParams:params];
    
    readSuccessBlock(componentItems);
}

-(void)clearCacheWithApiName:(NSString*)apiName
                   withParam:(NSDictionary*)param
          withFetchCondition:(NSDictionary*)fetchCondition
          componentItemClass:(Class)componentItemClass{
    
    NSString* where = [fetchCondition objectForKey:@"where"];
    
    [[LKDBHelper getUsingLKDBHelper] deleteWithTableName:[self getTableNameFromApiName:apiName] where:where];
    
}

-(NSString*)getTableNameFromApiName:(NSString*)apiName{
    NSString* tableName = [apiName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    tableName = [tableName stringByReplacingOccurrencesOfString:@"." withString:@"_"];
    return tableName;
}

@end
