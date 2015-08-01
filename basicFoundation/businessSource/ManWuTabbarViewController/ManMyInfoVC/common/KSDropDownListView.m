//
//  KSDropDownListView.m
//  basicFoundation
//
//  Created by 许学 on 15/7/3.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSDropDownListView.h"

#define CELLHEIGHT 60

@implementation KSDropDownListView

-(id)initWithFrame:(CGRect)frame CellHeight:(CGFloat)cellHeight
{
    self.cellHeight = cellHeight;
    frameHeight = frame.size.height;
    tableHeight = frameHeight - self.cellHeight;
    frame.size.height = self.cellHeight;
    self = [super initWithFrame:frame];
    if(self){
        isShowList = NO; //默认不显示下拉框
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.cellHeight, frame.size.width, 0)];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor grayColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.hidden = YES;
        [self addSubview:_table];
        
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, self.cellHeight)];
        [headView setBackgroundColor:[TBDetailUIStyle colorWithHexString:@"#ffffff"]];
        headView.layer.cornerRadius = 3;
        [self addSubview:headView];
        
        _userActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSpaceX, 0, 200, self.cellHeight)];
        [_userActionLabel setFont:[UIFont systemFontOfSize:18]];
        [headView addSubview:_userActionLabel];
        
        btn_select = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - kSpaceX - 30, frame.size.height/2 - 15, 30, 30)];
        [btn_select setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_droplist"]]];
        [btn_select addTarget:self action:@selector(selectedDorpDown) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:btn_select];
        
    }
    return self;
}

-(void)selectedDorpDown
{
    if (isShowList)
    {//如果下拉框已显示，什么都不做
        isShowList = NO;
        _table.hidden = YES;
        
        CGRect sf = self.frame;
        sf.size.height = self.cellHeight;
        self.frame = sf;
        CGRect frame = _table.frame;
        frame.size.height = 0;
        _table.frame = frame;

        return;
    }else {//如果下拉框尚未显示，则进行显示
        
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        _table.hidden = NO;
        isShowList = YES;//显示下拉框
        
        CGRect frame = _table.frame;
        frame.size.height = 0;
        _table.frame = frame;
        frame.size.height = tableHeight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        _table.frame = frame;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [TBDetailUIStyle colorWithHexString:@"#bdbcbc"];
    }
    
    cell.textLabel.text = [_dataArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.textColor = [TBDetailUIStyle colorWithHexString:@"#ffffff"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if(indexPath.row != [_dataArray count] - 1)
    {
        UIView *LineView=[[UIView alloc] initWithFrame:CGRectMake(0, self.cellHeight - 0.5, self.width, 0.5)];
        LineView.opaque = YES;
        LineView.backgroundColor = [TBDetailUIStyle colorWithHexString:@"#ffffff"];
        [cell.contentView addSubview:LineView];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _userActionLabel.text = [_dataArray objectAtIndex:[indexPath row]];
    self.serviceType = indexPath.row + 1;
    isShowList = NO;
    _table.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = self.cellHeight;
    self.frame = sf;
    CGRect frame = _table.frame;
    frame.size.height = 0;
    _table.frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
