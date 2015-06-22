//
//  KSOrderTableViewCell.m
//  basicFoundation
//
//  Created by 许学 on 15/6/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSOrderTableViewCell.h"
#import "KSOrderModel.h"

#define kCellControlSpacingX 10 //X轴间距
#define kImageViewWidth 60 //头像宽度
#define kPriceLabelWidth 50 //价格标签宽度
#define kStatusLabelWidth 100 //价格标签宽度
#define kButtonWidth 100 //价格标签宽度
#define kTitleFontSize 14
#define kSize_ColorFontSize 12
#define kPriceFontSize kSize_ColorFontSize
#define kStatusFontSize kTitleFontSize
#define kPayFontSize kSize_ColorFontSize
#define kButtonFontSize kSize_ColorFontSize


@implementation KSOrderTableViewCell
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_sizeLabel;
    UILabel *_colorLabel;
    UILabel *_priceLabel;
    UILabel *_statusLabel;
    UILabel *_payLabel;
    UIButton *_btn_left;
    UIButton *_btn_right;
    UIView *_LineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initSubView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.frame = frame;
        [self initSubView];
    }
    return self;
}

#pragma mark - 初始化视图
- (void)initSubView
{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kCellControlSpacingX, kCellControlSpacingX, kImageViewWidth, kImageViewWidth)];
    [self addSubview:_imageView];
    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - kPriceLabelWidth - kCellControlSpacingX, kCellControlSpacingX, kPriceLabelWidth, kPriceFontSize)];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_priceLabel];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, kCellControlSpacingX, CGRectGetMinX(_priceLabel.frame) - CGRectGetMaxX(_imageView.frame) - 15, kTitleFontSize)];
    [self addSubview:_titleLabel];
    
    _sizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, CGRectGetMaxY(_titleLabel.frame) + 10, 100, kSize_ColorFontSize)];
    [self addSubview:_sizeLabel];
    
    _colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, CGRectGetMaxY(_sizeLabel.frame) + 5, 100, kSize_ColorFontSize)];
    [self addSubview:_colorLabel];
    
    _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - kStatusLabelWidth - kCellControlSpacingX, CGRectGetMinY(_colorLabel.frame), kStatusLabelWidth, kStatusFontSize)];
    _statusLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_statusLabel];
    
    _LineView=[[UIView alloc] initWithFrame:CGRectMake(kCellControlSpacingX, CGRectGetMaxY(_imageView.frame) + kCellControlSpacingX, self.width - 2*kCellControlSpacingX, 0.5)];
    _LineView.opaque = YES;
    _LineView.backgroundColor =[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [self addSubview:_LineView];
    
    _payLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCellControlSpacingX, CGRectGetMaxY(_LineView.frame) + kCellControlSpacingX, 120, kPayFontSize)];
    [self addSubview:_payLabel];
    
    _btn_left = [[UIButton alloc]init];
    [self addSubview:_btn_left];
    
    _btn_right = [[UIButton alloc]init];
    [self addSubview:_btn_right];
}

#pragma mark - 设置订单数据
- (void)setOrderModel:(KSOrderModel *)orderModel
{
    //设置按钮大小
    NSString *title_leftBtn = [[NSString alloc]init];
    NSString *title_rightBtn = [[NSString alloc]init];
    NSString *statusStr = [[NSString alloc]init];
    switch ([orderModel.status integerValue]) {
        case 0:
        {
            statusStr = @"待付款";
            title_leftBtn = @"支付";
            title_rightBtn = @"取消订单";
        }
            break;
        case 1:
        {
            statusStr = @"待发货";
            title_leftBtn = @"";
            title_rightBtn = @"提醒发货";
        }
            break;
        case 2:
        {
            statusStr = @"待收货";
            title_leftBtn = @"确认收货";
            title_rightBtn = @"查看物流";
        }
            break;
        case 3:
        {
            statusStr = @"已收货";
            title_leftBtn = @"";
            title_rightBtn = @"删除订单";
        }
            break;
        case 4:
        {
            statusStr = @"退/换货";
            title_leftBtn = @"";
            title_rightBtn = @"查看进度";
        }
            break;
            
        default:
            break;
    }
    CGSize btn_rightSize = [title_rightBtn sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kButtonFontSize]}];
    CGFloat btn_rightX = self.width - kCellControlSpacingX - kButtonWidth;
    CGFloat btn_rightY = CGRectGetMaxY(_LineView.frame) + 5;
    CGRect btn_rightRect=CGRectMake(btn_rightX, btn_rightY, kButtonWidth, btn_rightSize.height + 5);
    [_btn_right setFrame:btn_rightRect];
    [_btn_right setTitle:title_rightBtn forState:UIControlStateNormal];
    [_btn_right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if([title_leftBtn length] == 0)
    {
        _btn_left.enabled = NO;
    }else
    {
        CGSize btn_leftSize = [title_rightBtn sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kButtonFontSize]}];
        CGFloat btn_leftX = CGRectGetMinX(_btn_right.frame) - kButtonWidth - 10;
        CGFloat btn_leftY = CGRectGetMaxY(_LineView.frame) + 5;
        CGRect btn_leftRect=CGRectMake(btn_leftX, btn_leftY, kButtonWidth, btn_leftSize.height + 5);
        [_btn_left setFrame:btn_leftRect];
        [_btn_left setTitle:title_leftBtn forState:UIControlStateNormal];
        [_btn_left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

    _imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:orderModel.imgUrl]]];
    _titleLabel.text = orderModel.title;
    
    NSArray *skuList = orderModel.skuList;
    for(KSOrderSKUModel *orderSku in skuList)
    {
        NSString *propertyName = orderSku.propertyName;
        if([propertyName isEqualToString:@"颜色"])
        {
            _colorLabel.text = [NSString stringWithFormat:@"颜色：%@",orderSku.value];
            
        }else if ([propertyName isEqualToString:@"尺码"])
        {
            _sizeLabel.text = [NSString stringWithFormat:@"尺码：%@",orderSku.value];
        }
    }
    _statusLabel.text = statusStr;
    _priceLabel.text = orderModel.oriPrice;
    _payLabel.text = [NSString stringWithFormat:@"实付款：%@",orderModel.payPrice];
    
}

- (void) layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
