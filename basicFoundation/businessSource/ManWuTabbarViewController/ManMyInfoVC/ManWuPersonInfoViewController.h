//
//  ManWuPersonInfoViewController.h
//  e企
//
//  Created by royaMAC on 14-11-14.
//  Copyright (c) 2014年 QYB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImagePickerController.h"
#import "ImageFilterProcessViewController.h"

typedef void (^Myblock)(UIImage * UserImage);

@interface ManWuPersonInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,CustomImagePickerControllerDelegate,ImageFitlerProcessDelegate,WeAppBasicServiceDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, copy)   Myblock myblock;
@property (nonatomic, strong) UIImage * image11;
@property (nonatomic, strong) NSString *plistUrl;

@property (nonatomic, strong) KSAdapterService *service;

-(void)useThePersoninfoImageChangeOther:(Myblock)myblock;

@end
