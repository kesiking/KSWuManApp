//
//  KSOrderTableViewCell.m
//  basicFoundation
//
//  Created by 许学 on 15/6/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSOrderTableViewCell.h"
#import "KSOrderModel.h"

@implementation KSOrderTableViewCell
{
    NSString *identify;
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_sizeLabel;
    UILabel *_buyNumLabel;
    UILabel *_colorLabel;
    UILabel *_priceLabel;
    UILabel *_statusLabel;
    UIView *_LineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        if([identify isEqualToString:OrderTableCellStyleInfo])
        {
            [self initOrderInfoView];
            
        }else if ([identify isEqualToString:OrderTableCellStyleDeal])
        {
            [self initOrderDealView];
        }
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;
{
    identify = [[NSString alloc]initWithString:reuseIdentifier];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.frame = frame;
        if([identify isEqualToString:OrderTableCellStyleInfo])
        {
            [self initOrderInfoView];
            
        }else if ([identify isEqualToString:OrderTableCellStyleDeal])
        {
            [self initOrderDealView];
        }
    }
    return self;
}

#pragma mark - 初始化视图
- (void)initOrderInfoView
{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kCellControlSpacingX, kCellControlSpacingY, kImageViewWidth, kImageViewWidth)];
    [self addSubview:_imageView];
    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - kPriceLabelWidth - kCellControlSpacingX, kCellControlSpacingY, kPriceLabelWidth, kPriceFontSize)];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [_priceLabel setFont:[UIFont systemFontOfSize:kPriceFontSize]];
    [_priceLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
    [self addSubview:_priceLabel];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, kCellControlSpacingY, CGRectGetMinX(_priceLabel.frame) - CGRectGetMaxX(_imageView.frame) - 15, kTitleFontSize)];
    [_titleLabel setFont:[UIFont systemFontOfSize:kTitleFontSize]];
    [_titleLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
    [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_titleLabel setNumberOfLines:0];
    [self addSubview:_titleLabel];
    
    _sizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, CGRectGetMaxY(_titleLabel.frame) + 10, 60, kSize_ColorFontSize)];
    [_sizeLabel setFont:[UIFont systemFontOfSize:kSize_ColorFontSize]];
    [_sizeLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
    [self addSubview:_sizeLabel];
    
    _buyNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_sizeLabel.frame) + 10, CGRectGetMinY(_sizeLabel.frame), 60, kBuyNumFontSize)];
    [_buyNumLabel setFont:[UIFont systemFontOfSize:kBuyNumFontSize]];
    [_buyNumLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
    [self addSubview:_buyNumLabel];
    
    _colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, CGRectGetMaxY(_sizeLabel.frame) + 5, 100, kSize_ColorFontSize)];
    [_colorLabel setFont:[UIFont systemFontOfSize:kSize_ColorFontSize]];
    [_colorLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
    [self addSubview:_colorLabel];
    
    _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - kStatusLabelWidth - kCellControlSpacingX, CGRectGetMinY(_colorLabel.frame), kStatusLabelWidth, kStatusFontSize)];
    _statusLabel.textAlignment = NSTextAlignmentRight;
    [_statusLabel setFont:[UIFont systemFontOfSize:kStatusFontSize]];
    [_statusLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#d95c47"]];
    [self addSubview:_statusLabel];
    
    _LineView=[[UIView alloc] initWithFrame:CGRectMake(kCellControlSpacingX, self.height - 0.5, self.width - 2*kCellControlSpacingX, 0.5)];
    _LineView.opaque = YES;
    _LineView.backgroundColor =[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [self addSubview:_LineView];
}

- (void)initOrderDealView
{
    _payLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCellControlSpacingX, kCellControlSpacingY, 140, kPayFontSize)];
    [_payLabel setFont:[UIFont systemFontOfSize:kPayFontSize]];
    [_payLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
    [self addSubview:_payLabel];
    
    _btn_left = [[UIButton alloc]init];
    _btn_right = [[UIButton alloc]init];

    [self addSubview:_btn_left];
    [self addSubview:_btn_right];

}

#pragma mark - 设置订单数据
- (void)setOrderModel:(KSOrderModel *)orderModel
{
    //设置按钮大小
    NSString *statusStr = [[NSString alloc]init];
    switch ([orderModel.status integerValue]) {
        case 1:
        {
            statusStr = @"待付款";
        }
            break;
        case 2:
        {
            statusStr = @"待发货";
        }
            break;
        case 3:
        {
            statusStr = @"待收货";
        }
            break;
        case 4:
        {
            statusStr = @"已收货";
        }
            break;
        case 5:
        {
            statusStr = @"退款中";
        }
            break;
        case 6:
        {
            statusStr = @"已退款";
        }
            break;
        case 7:
        {
            statusStr = @"已取消";
        }
            break;

            
        default:
            break;
    }

    if([identify isEqualToString:OrderTableCellStyleInfo])
    {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:orderModel.imgUrl]];
        _titleLabel.text = orderModel.title;
        
        NSString *titleStr = orderModel.title;
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:titleStr];
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle1 setLineSpacing:5.0];//调整行间距
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [titleStr length])];
        _titleLabel.attributedText = attributedString1;
        [_titleLabel sizeToFit];
        
        [_sizeLabel setFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, CGRectGetMaxY(_titleLabel.frame) + 10, 60, kSize_ColorFontSize)];
        
        [_buyNumLabel setFrame:CGRectMake(CGRectGetMaxX(_sizeLabel.frame) + 10, CGRectGetMinY(_sizeLabel.frame), 60, kBuyNumFontSize)];
        
        [_colorLabel setFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, CGRectGetMaxY(_sizeLabel.frame) + 5, 100, kSize_ColorFontSize)];
        
        [_statusLabel setFrame:CGRectMake(self.width - kStatusLabelWidth - kCellControlSpacingX, CGRectGetMinY(_colorLabel.frame), kStatusLabelWidth, kStatusFontSize)];
        
        [_LineView setFrame:CGRectMake(kCellControlSpacingX, CGRectGetMaxY(_statusLabel.frame) + 10, self.width - 2*kCellControlSpacingX, 0.5)];
        
        CGRect rect = self.frame;
        rect.size.height = CGRectGetMaxY(_LineView.frame);
        [self setFrame:rect];
        
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
        
        if([skuList count] == 0)
        {
            [_buyNumLabel setFrame:_sizeLabel.frame];
        }
        _buyNumLabel.text = [NSString stringWithFormat:@"数量：%@",orderModel.buyNum];
        _statusLabel.text = statusStr;
        _priceLabel.text = [NSString stringWithFormat:@"¥%0.2f",[orderModel.oriPrice floatValue]];

    }else if ([identify isEqualToString:OrderTableCellStyleDeal])
    {
        
    }

}

- (void) layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
