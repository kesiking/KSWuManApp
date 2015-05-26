//
//  ManWuDiscoverViewCell.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiscoverViewCell.h"
#import "ManWuDiscoverCollectionViewCell.h"
#import "ManWuDiscoverCellModelInfoItem.h"
#import "ManWuDiscoverModel.h"

#define titleLabel_left_border     (8.0)
#define titleLabel_right_border    (8.0)
#define titleLabel_top_border      (6.0)
#define titleLabel_height          (20.0)

@interface ManWuDiscoverViewCell()

@property (nonatomic,strong) KSDataSource*      dataSourceRead;

@property (nonatomic,strong) UIView*            endline;

@end

@implementation ManWuDiscoverViewCell

-(void)setupView{
    [super setupView];
    [self.titleLabel setFrame:CGRectMake(titleLabel_left_border, titleLabel_top_border, self.width - titleLabel_left_border - titleLabel_right_border, titleLabel_height)];
    [self addSubview:self.titleLabel];
    [self addSubview: self.collectionViewCtl.scrollView];
    [self addSubview:self.endline];
}

-(KSCollectionViewController *)collectionViewCtl{
    if (_collectionViewCtl == nil) {
        KSCollectionViewConfigObject* configObject = [[KSCollectionViewConfigObject alloc] init];
        CGRect frame = self.bounds;
        frame.origin.y = self.titleLabel.bottom + 4;
        frame.origin.x = titleLabel_left_border;
        frame.size.width = frame.size.width - 2 * titleLabel_left_border;
        configObject.collectionColumn = 4;
        configObject.minimumInteritemSpacing = 4;
        configObject.minimumLineSpacing = 4;
        configObject.needQueueLoadData = NO;
        configObject.needRefreshView = NO;
        configObject.needNextPage = NO;
        configObject.needFootView = NO;
        configObject.collectionCellSize = CGSizeMake(72, 72);
        _collectionViewCtl = [[KSCollectionViewController alloc] initWithFrame:frame withConfigObject:configObject];
        [_collectionViewCtl.scrollView setScrollEnabled:NO];
        [_collectionViewCtl registerClass:[ManWuDiscoverCollectionViewCell class]];
        [_collectionViewCtl setDataSourceRead:self.dataSourceRead];
    }
    return _collectionViewCtl;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

-(UIView *)endline{
    if (_endline == nil) {
        _endline = [TBDetailUITools drawDivisionLine:0
                                                yPos:self.height - 0.5
                                           lineWidth:self.width];
    }
    return _endline;
}

-(KSDataSource *)dataSourceRead {
    if (!_dataSourceRead) {
        _dataSourceRead = [[KSDataSource alloc]init];
    }
    return _dataSourceRead;
}

- (void)configCellWithCellView:(id<KSViewCellProtocol>)cell Frame:(CGRect)rect componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    [super configCellWithCellView:cell Frame:rect componentItem:componentItem extroParams:extroParams];
    ManWuDiscoverCellModelInfoItem* cellModelInfoItem = (ManWuDiscoverCellModelInfoItem*)extroParams;
    
    ManWuDiscoverModel* discoverModel = (ManWuDiscoverModel*)componentItem;
    
    self.titleLabel.text = discoverModel.name;

    if ([cellModelInfoItem.discoverCollectionArray count] == 0) {
        [self.collectionViewCtl.scrollView setHidden:YES];
    }else{
        [self.collectionViewCtl.scrollView setHidden:NO];
    }
    
    CGRect frame = self.collectionViewCtl.scrollView.frame;
    if (frame.size.height != cellModelInfoItem.discoverCollectionHeight) {
        frame.size.height = cellModelInfoItem.discoverCollectionHeight;
        [self.collectionViewCtl setFrame:frame];
    }
    
    [self.dataSourceRead setDataWithPageList:cellModelInfoItem.discoverCollectionArray extraDataSource:nil];
    [self.collectionViewCtl reloadData];
    
    [self.endline setOrigin:CGPointMake(self.endline.origin.x, rect.size.height - 0.5)];
}

- (void)refreshCellImagesWithComponentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{

}

- (void)didSelectCellWithCellView:(id<KSViewCellProtocol>)cell componentItem:(WeAppComponentBaseItem *)componentItem extroParams:(KSCellModelInfoItem*)extroParams{
    NSLog(@"did select cell in list");
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:@"commodityId",@"commodityId", nil];
    TBOpenURLFromTargetWithNativeParams(internalURL(kManWuCommodityList), self,nil,params);
}

@end
