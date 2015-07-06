//
//  KSDropDownListView.m
//  basicFoundation
//
//  Created by 许学 on 15/7/3.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSDropDownListView.h"

@implementation KSDropDownListView

-(id)initWithFrame:(CGRect)frame
{
    if (frame.size.height > 200) {
        frameHeight = 200;
    }else{
        frameHeight = frame.size.height;
    }
    tableHeight = frameHeight - 60;
    
    frame.size.height = 60.0f;
    
    self = [super initWithFrame:frame];
    
    if(self){
        isShowList = NO; //默认不显示下拉框
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, frame.size.width, 0)];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor grayColor];
        _table.separatorColor = [UIColor lightGrayColor];
        _table.hidden = YES;
        [self addSubview:_table];
        
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 60)];
        [headView setBackgroundColor:[TBDetailUIStyle colorWithHexString:@"#ffffff"]];
        headView.layer.cornerRadius = 3;
//        headView.layer.borderColor = [[TBDetailUIStyle colorWithHexString:@"#666666"]CGColor];
//        headView.layer.borderWidth = 0.5;
        [self addSubview:headView];
        
        _userActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 60)];
        [_userActionLabel setFont:[UIFont systemFontOfSize:18]];
        [headView addSubview:_userActionLabel];
        
        btn_select = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - kSpaceX - 30, CGRectGetMinY(_userActionLabel.frame) + 15, 30, 30)];
        [btn_select setBackgroundColor:[UIColor greenColor]];
        [btn_select addTarget:self action:@selector(selectedDorpDown) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:btn_select];
        
    }
    return self;
}

-(void)selectedDorpDown
{
    if (isShowList)
    {//如果下拉框已显示，什么都不做
        [btn_select setBackgroundColor:[UIColor greenColor]];
        isShowList = NO;
        _table.hidden = YES;
        
        CGRect sf = self.frame;
        sf.size.height = 40;
        self.frame = sf;
        CGRect frame = _table.frame;
        frame.size.height = 0;
        _table.frame = frame;

        return;
    }else {//如果下拉框尚未显示，则进行显示
        
        [btn_select setBackgroundColor:[UIColor redColor]];
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
    }
    
    cell.textLabel.text = [_dataArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [btn_select setBackgroundColor:[UIColor greenColor]];
    _userActionLabel.text = [_dataArray objectAtIndex:[indexPath row]];
    isShowList = NO;
    _table.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 40;
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
