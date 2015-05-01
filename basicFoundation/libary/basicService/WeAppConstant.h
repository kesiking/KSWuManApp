//
//  TBCAContanst.h
//  Taobao2013
//
//  Created by 淘云 on 14-1-2.
//  Copyright (c) 2013年 Taobao.com. All rights reserved.
//

// scale
//#define CA_SCALE    (0.5)
#define CA_BASE_SCALE (0.5)
#define CA_SCALE      ([WeAppEnviroment getScreenAdapterScale])

#define SCREEN_BASE     320
#define SCREEN_SCALE    ([UIScreen mainScreen].bounds.size.width / SCREEN_BASE)


#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
#define SCREEN_WITHOUT_STATUS_HEIGHT (SCREEN_HEIGHT - [[UIApplication sharedApplication] statusBarFrame].size.height)

#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

#if OS_OBJECT_USE_OBJC
#undef  WeAppDispatchQueueRelease
#undef  WeAppDispatchQueueSetterSementics
#define WeAppDispatchQueueRelease(q)
#define WeAppDispatchQueueSetterSementics strong
#else
#undef  WeAppDispatchQueueRelease
#undef  WeAppDispatchQueueSetterSementics
#define WeAppDispatchQueueRelease(q) (dispatch_release(q))
#define WeAppDispatchQueueSetterSementics assign
#endif
