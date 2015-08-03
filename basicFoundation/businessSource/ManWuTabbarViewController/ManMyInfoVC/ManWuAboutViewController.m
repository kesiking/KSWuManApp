//
//  ManWuAboutViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/7/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAboutViewController.h"

@interface ManWuAboutViewController ()
{
    UITextView *textView;
}

@end

@implementation ManWuAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithHexString:@"#ffffff"]];
    
    self.title = @"关于我们";
    
    NSString *aboutStr = @"客服QQ：2192378714\n客服电话：057186290178\n退换货须知——屋满支持自签收之日起3天无理由退货，退货商品必须保持状态完好，内外标签未被拆下（剪标商品除外）。由于涉及个人卫生问题，内衣裤袜子已经签收不得退换。退换货之前，请务必先联系客服，方能办理退换货。每个退货包裹需包含相应的订单票据，请按收货时的包装方法包装和寄送包裹以避免商品的损坏。退货经过核实后，将为您提供商品的退款服务。\n退换货邮资——退换商品所产生的邮资均由客户承担；由于商品质量问题退换货所产生的邮资均由屋满网承担。如衣物存在质量问题，请于签收之时起24小时之内联系客服处理，超过24小时即表示对商品质量表示认可，屋满不再对商品质量问题负责。";
    textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 20, self.view.width - 30, self.view.height - 20)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:17],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:aboutStr attributes:attributes];
    textView.textColor =  [TBDetailUIStyle colorWithHexString:@"#666666"];
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
