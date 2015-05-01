//
//  KSDataSource.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KSCellModelInfoItem;

@interface KSDataSource : NSObject{
    NSArray                          *_dataList;
    NSMutableDictionary              *_modelList;
}

@property (nonatomic, strong) Class                modelInfoItemClass;

// 用pageList初始化dataSource
-(void)setDataWithPageList:(NSArray *)pageList extraDataSource:(NSDictionary*)extraInfoParams;

// 根据index获取componentItem，而后配置初始化modelInfoItem，在modelInfoItem中可以配置cell需要的参数
-(void)setupComponentItemWithIndex:(NSUInteger)index;

// 在dataList中，获取componentItem
-(WeAppComponentBaseItem*)getComponentItemWithIndex:(NSUInteger)index;

-(NSInteger)count;

-(void)removeAllCellitems;

// 获取KSCellModelInfoItem，在modelInfoItem中可以获取cell需要的参数
-(KSCellModelInfoItem*)getComponentModelInfoItemWithIndex:(NSUInteger)index;

-(BOOL)getImageDidLoadedWithIndex:(NSUInteger)index;

-(void)setImageDidLoaded:(BOOL)imageLoaded atIndex:(NSUInteger)index;

@end

@interface KSCellModelInfoItem : NSObject

@property (nonatomic, strong) NSString*          modelInfoItemId;

@property (nonatomic, assign) CGRect             frame;

@property (nonatomic, assign) BOOL               imageHasLoaded;

@property (nonatomic, strong) id                 modelInfoObject;

@property (nonatomic, strong) NSDictionary*      modelInfoDict;

// 配置初始化KSCellModelInfoItem，在modelInfoItem中可以配置cell需要的参数
// 根据componentItem计算高度或是存储需要的数据，用于优化性能
-(void)setupCellModelInfoItemWithComponentItem:(WeAppComponentBaseItem*)componentItem;

@end
