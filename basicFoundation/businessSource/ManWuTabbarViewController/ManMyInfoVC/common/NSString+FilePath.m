//
//  NSString+FilePath.m
//  O了
//
//  Created by 卢鹏达 on 14-1-23.
//  Copyright (c) 2014年 QYB. All rights reserved.
//

#import "NSString+FilePath.h"

@implementation NSString (FilePath)
#pragma mark 获取项目沙盒中Documents所在路径
- (NSString *)filePathOfDocuments
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    path=[path stringByAppendingPathComponent:self];
    return path;
}
#pragma mark 获取项目沙盒中Caches所在路径
- (NSString *)filePathOfCaches
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    path=[path stringByAppendingPathComponent:self];
    return path;
}
#pragma mark 获取项目沙盒中Library所在路径
- (NSString *)filePathOfLibrary
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
    path=[path stringByAppendingPathComponent:self];
    return path;
}
#pragma mark 获取项目沙盒中Tmp所在路径
- (NSString *)filePathOfTmp
{
    NSString *path=NSTemporaryDirectory();
    path=[path stringByAppendingPathComponent:self];
    return path;
}
#pragma mark - 设备型号
- (NSString *)deviceString{
    return nil;
}
#pragma mark - 拼装网络请求的path
//- (NSString *)pathRequestUuid:(NSString *)uuid{
//    NSString *newPath=[NSString stringWithFormat:@"%@%@%@",self,request_path_uuid,uuid];
//    return newPath;
//}
- (NSString *)timeWithSecondAndFormat:(NSString *)format{
//    NSString *s = @”1295355600000″; //对应21:00
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/1000];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    if (!format) {
        format=@"yyyy-MM-dd hh:mm:ss";
    }
    [formatter1 setDateFormat:format];
    NSString *showtimeNew = [formatter1 stringFromDate:d];
    return showtimeNew;
}
#pragma mark - 根据时间获取秒数
- (NSString *)secondWithTimeAndFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if(!format){
        format=@"YYYY-MM-dd HH:mm:ss";
    }
    [formatter setDateFormat:format];
    NSDate* date = [formatter dateFromString:self];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}
- (NSString *)pathRequestUuid:(NSString *)uuid{
    return nil;
}

@end
