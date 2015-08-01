//
//  KSImageListCache.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSImageListCache.h"

@implementation KSImageListCache

+ (KSImageListCache *)sharedImageCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

-(void)config{
    _memCache = [[NSCache alloc] init];
    _memCache.name = @"KSIMAGELISTCACHE";
    
    _ioQueue = dispatch_queue_create("com.hackemist.SDWebImageCache", DISPATCH_QUEUE_SERIAL);

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemory)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemory)
                                                 name:ClearCacheNotification
                                               object:nil];
    
}

- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key {
    if (key == nil) {
        return nil;
    }
    
    return [self.memCache objectForKey:key];
}

- (void)storeImage:(UIImage *)image forKey:(NSString *)key {
    if (!image || !key) {
        return;
    }
    
    [self.memCache setObject:image forKey:key cost:image.size.height * image.size.width * image.scale];
}

- (void)removeImageForKey:(NSString *)key{
    if (key == nil) {
        return;
    }
    
    [self.memCache removeObjectForKey:key];
}

- (void)clearMemory {
    [self.memCache removeAllObjects];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    SDDispatchQueueRelease(_ioQueue);
}

@end
