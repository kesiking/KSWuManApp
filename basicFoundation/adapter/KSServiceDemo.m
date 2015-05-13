//
//  KSServiceDemo.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSServiceDemo.h"
#import "KSModelDemo.h"

@interface KSServiceDemo()<WeAppBasicServiceDelegate>

@property (nonatomic, strong) KSAdapterService  *service;

@end

@implementation KSServiceDemo

-(KSAdapterService *)service{
    if (_service == nil) {
        _service = [[KSAdapterService alloc] init];
        _service.delegate = self;
        [_service setItemClass:[KSModelDemo class]];
    }
    return _service;
}

-(void)loadData{
    [self.service setJsonTopKey:@"data"];
    [self.service loadItemWithAPIName:@"user/login.do" params:@{@"userName":@"yongl",@"pwd":@123} version:nil];
//    [self.service loadNumberValueWithAPIName:@"user/queryCode.do" params:@{@"phoneNum":@18626876833} version:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark WeAppBasicServiceDelegate method

- (void)serviceDidStartLoad:(WeAppBasicService *)service{
    if (service == _service) {
        // todo start
    }
}

- (void)serviceDidFinishLoad:(WeAppBasicService *)service{
    if (service == _service) {
        // todo success
        KSServiceDemo* modelDemo = (KSServiceDemo*)_service.item;
        NSLog(@"%@",modelDemo.description);
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    if (service == _service) {
        // todo fail
    }
}

@end
