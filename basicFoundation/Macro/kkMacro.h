//
//  kkMacro.h
//  GuangguangDemo
//
//  Created by zws on 10/31/14.
//  Copyright (c) 2014 ICSCN. All rights reserved.
//

#ifndef GuangguangDemo_kkMacro_h
#define GuangguangDemo_kkMacro_h

#if DEBUG
#define RMLog(args...) NSLog(@"%@", [NSString stringWithFormat: args])
#define LogMethod() NSLog(@"logged method call: -[%@ %@] (line %d)", self, NSStringFromSelector(_cmd), __LINE__)
#define WarnDeprecated() NSLog(@"***** WARNING: deprecated method call: -[%@ %@] (line %d)", self, NSStringFromSelector(_cmd), __LINE__)
#else
// DEBUG not defined:

#define RMLog(args...)    // do nothing.
#define LogMethod()
#define WarnDeprecated()
#define NS_BLOCK_ASSERTIONS 1
#endif

#define RMPostVersion6 (floor(NSFoundationVersionNumber) >  NSFoundationVersionNumber_iOS_5_1)
#define RMPreVersion6  (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_5_1)

#define RMPostVersion7 (floor(NSFoundationVersionNumber) >  NSFoundationVersionNumber_iOS_6_1)
#define RMPreVersion7  (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
#define LOADIMAGE(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:@"png"]]
#define CACHEPATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
#define DOCUMENTPATH NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]


#endif
