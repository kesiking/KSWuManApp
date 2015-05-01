//
//  TBDetailInputViewModel.h
//  TBDetailSDK
//
//  Created by neo on 14-8-6.
//  Copyright (c) 2014年 TB. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@protocol TBDetailInputViewModel <NSObject>
@end

@interface TBDetailInputViewModel : WeAppComponentBaseItem

@property (nonatomic , copy) NSString * key;


// 1:TBDetailCheckBoxModel 多选  2 TBDetailRadioBoxModel 单选 3 TBDetailTreeModel
@property (nonatomic , assign) NSInteger type;

@property (nonatomic , copy)   NSString * data;

@property (nonatomic , copy)   NSString * text;

-(BOOL) isRadioBox;
-(BOOL) isCheckBox;
-(BOOL) isTree;
-(NSString * )getKey;
-(NSString * )getText;

@end
