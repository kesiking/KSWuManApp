//
//  ManWuLoginNavigationController.m
//  basicFoundation
//
//  Created by 许学 on 15/5/31.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuLoginNavigationController.h"

@interface ManWuLoginNavigationController ()

@end

@implementation ManWuLoginNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view from its nib.
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:19.0],NSFontAttributeName,nil]];
    
    [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = NO;
    
    self.loginVC = [[ManWuLoginViewController alloc]init];
    [self addChildViewController:self.loginVC];
}

-(UIImage*) imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)cancelLogin
{
    
    if([[self.navigationController.viewControllers lastObject]isKindOfClass:[ManWuLoginViewController class]])
    {
        [[self.navigationController.viewControllers lastObject]dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [[self.navigationController.viewControllers lastObject] popViewControllerAnimated:YES];
    }
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
