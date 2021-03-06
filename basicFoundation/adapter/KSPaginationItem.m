//
//  KSPaginationItem.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSPaginationItem.h"

#define default_current_page @"cpage"
#define default_timestamp @"timestamp"
#define default_id_name @"id"
#define default_page_size @"pageSize"
#define default_direction @"direction"

@implementation KSPaginationItem

-(void)addParams:(NSDictionary *)params withDict:(NSMutableDictionary *)dict{
    if (dict && [dict isKindOfClass:[NSMutableDictionary class]]) {
        
        id curPageName = nil;
        id timestampName = nil;
        id idStampName = nil;
        id pageSizeName = nil;
        id directionName = nil;
        
        //获取数据
        if (params && [params count] > 0) {
            curPageName = [params objectForKey:@"curPageName"];
            if (curPageName == nil || ![curPageName isKindOfClass:[NSString class]]) {
                curPageName = [NSString stringWithFormat:default_current_page];
            }
            timestampName = [params objectForKey:@"timestampName"];
            if (timestampName == nil || ![timestampName isKindOfClass:[NSString class]]) {
                timestampName = [NSString stringWithFormat:default_timestamp];
            }
            idStampName = [params objectForKey:@"idName"];
            if (idStampName == nil || ![idStampName isKindOfClass:[NSString class]]) {
                idStampName = [NSString stringWithFormat:default_id_name];
            }
            pageSizeName = [params objectForKey:@"pageSizeName"];
            if (pageSizeName == nil || ![pageSizeName isKindOfClass:[NSString class]]) {
                pageSizeName = [NSString stringWithFormat:default_page_size];
            }
            directionName = [params objectForKey:@"directionName"];
            if (directionName == nil || ![directionName isKindOfClass:[NSString class]]) {
                directionName = [NSString stringWithFormat:default_direction];
            }
        }else{
            curPageName = [NSString stringWithFormat:default_current_page];
            timestampName = [NSString stringWithFormat:default_timestamp];
            idStampName = [NSString stringWithFormat:default_id_name];
            pageSizeName = [NSString stringWithFormat:default_page_size];
            directionName = [NSString stringWithFormat:default_direction];
        }
        
        if (self.paginationType == WeAppPaginationTypeDefault) {
            [dict setObject:[NSString stringWithFormat:@"%d", self.pageSize] forKey:((NSString*)pageSizeName)];
            //            pagination.curPage = pagination.reallyCurpage + 1;
            if (self.isTimestampEnable && self.reallyCurpage == 0) {
                //已经获取了第一页，而reallyCurpage指向的仍然是0页，这种情况下需要将页面置为1
                [self paginationPlus];
            }
            [dict setObject:[NSString stringWithFormat:@"%d", self.reallyCurpage + 1] forKey:((NSString*)curPageName)];
            if (self.isTimestampEnable) {
                [dict setObject:[NSString stringWithFormat:@"%lld", self.timestamp] forKey:((NSString*)timestampName)];
            }
        }else if(self.paginationType == WeAppPaginationTypeId){
            [dict setObject:[NSString stringWithFormat:@"%d", self.pageSize] forKey:((NSString*)pageSizeName)];
            [dict setObject:[NSString stringWithFormat:@"%d", self.reallyCurpage + 1] forKey:((NSString*)curPageName)];
            [dict setObject:[NSString stringWithFormat:@"%lld", self.id] forKey:((NSString*)idStampName)];
        }else if(self.paginationType == WeAppPaginationTypeALL){
            //加入普通翻页逻辑
            [dict setObject:[NSString stringWithFormat:@"%d", self.pageSize] forKey:((NSString*)pageSizeName)];
            if (self.isTimestampEnable && self.reallyCurpage == 0) {
                [self paginationPlus];
            }
            [dict setObject:[NSString stringWithFormat:@"%d", self.reallyCurpage + 1] forKey:((NSString*)curPageName)];
            if (self.isTimestampEnable) {
                [dict setObject:[NSString stringWithFormat:@"%lld", self.timestamp] forKey:((NSString*)timestampName)];
            }
            //加入id
            [dict setObject:[NSString stringWithFormat:@"%lld", self.id] forKey:((NSString*)idStampName)];
            //加入时间戳
            if (self.beforTimestamp > 0) {
                [dict setObject:[NSString stringWithFormat:@"%lld", self.beforTimestamp] forKey:((NSString*)timestampName)];
            }else{
                [dict setObject:[NSString stringWithFormat:@"%lld", self.afterTimestamp] forKey:((NSString*)timestampName)];
            }
            [dict setObject:[NSString stringWithFormat:@"%d", self.direction] forKey:((NSString*)directionName)];
            
        }else{
            if (self.beforTimestamp > 0) {
                [dict setObject:[NSString stringWithFormat:@"%lld", self.beforTimestamp] forKey:((NSString*)timestampName)];
            }else{
                [dict setObject:[NSString stringWithFormat:@"%lld", self.afterTimestamp] forKey:((NSString*)timestampName)];
            }
            [dict setObject:[NSString stringWithFormat:@"%d", self.pageSize] forKey:((NSString*)pageSizeName)];
            [dict setObject:[NSString stringWithFormat:@"%d", self.direction] forKey:((NSString*)directionName)];
            
        }
    }
}

@end
