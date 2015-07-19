//
//  KSDropDownListView.h
//  basicFoundation
//
//  Created by 许学 on 15/7/3.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSDropDownListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *btn_select;
    BOOL isShowList;
    CGFloat tableHeight;
    CGFloat frameHeight;
}

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UILabel *userActionLabel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger serviceType;

-(id)initWithFrame:(CGRect)frame CellHeight:(CGFloat)cellHeight;

@end
